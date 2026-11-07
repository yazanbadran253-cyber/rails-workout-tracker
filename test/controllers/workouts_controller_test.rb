require "test_helper"

class WorkoutsControllerTest < ActionDispatch::IntegrationTest
  test "each weekday shows the right workout and number of sets" do
    sunday = Date.new(2026, 11, 8)
    expected = [
      [ "Pull #2", 25 ], [ "Rest day", 0 ], [ "Push #2", 22 ],
      [ "Legs #1", 18 ], [ "Pull #1", 24 ], [ "Push #1", 20 ], [ "Legs #2", 18 ]
    ]

    expected.each_with_index do |(name, sets), offset|
      travel_to((sunday + offset).noon) do
        get root_path
        assert_response :success
        assert_dom "h1", text: name
        assert_dom "input[type=checkbox]", count: sets
      end
    end
  end

  test "sets save independently and history reflects completion" do
    date = Date.new(2026, 11, 10)
    travel_to(date.noon) do
      exercises = WorkoutRoutine.for(date).fetch(:exercises)
      assert_difference "CompletedSet.count", 1 do
        2.times { save_set(date, exercises.first, 1) }
      end

      get root_path
      assert_dom "input[checked]", count: 1
      get workout_history_path
      assert_dom "time", count: 0

      exercises.each do |exercise|
        1.upto(exercise.sets) { |number| save_set(date, exercise, number) }
      end

      get workout_history_path
      assert_dom "time[datetime='#{date.iso8601}']", count: 1
      assert_dom "li", text: /Push #2/

      save_set(date, exercises.first, 1, checked: false)
      get workout_history_path
      assert_dom "time", count: 0
      save_set(date, exercises.first, 1)
    end

    travel_to((date + 7).noon) do
      get root_path
      assert_dom "input[checked]", count: 0
      get workout_history_path
      assert_dom "time[datetime='#{date.iso8601}']", count: 1
    end
  end

  test "stale dates and invalid sets cannot change progress" do
    date = Date.new(2026, 11, 10)
    travel_to(date.noon) do
      assert_no_difference "CompletedSet.count" do
        patch workout_sets_path, params: { date: (date - 7).iso8601 }, as: :json
        assert_response :conflict

        exercise = WorkoutRoutine.for(date).fetch(:exercises).first
        patch workout_sets_path, params: {
          date: date.iso8601, exercise_key: exercise.key, set_number: 4, checked: true
        }, as: :json
        assert_response :unprocessable_content
      end
    end
  end

  private

  def save_set(date, exercise, number, checked: true)
    patch workout_sets_path, params: {
      date: date.iso8601, exercise_key: exercise.key, set_number: number, checked: checked
    }, as: :json
    assert_response :no_content
  end
end
