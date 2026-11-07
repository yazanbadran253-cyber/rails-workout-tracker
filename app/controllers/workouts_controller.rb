class WorkoutsController < ApplicationController
  def show
    @date = Date.current
    @workout = WorkoutRoutine.for(@date)
    @completed_sets = CompletedSet.where(date: @date).pluck(:exercise_key, :set_number).to_set
  end

  def update
    date = Date.current
    return head :conflict unless params[:date] == date.iso8601

    workout = WorkoutRoutine.for(date)
    exercise = workout&.fetch(:exercises)&.find { |item| item.key == params[:exercise_key] }
    set_number = params[:set_number]
    return head :unprocessable_content unless exercise && set_number.is_a?(Integer) && set_number.between?(1, exercise.sets)
    return head :unprocessable_content unless [ true, false ].include?(params[:checked])

    CompletedSet.record(date: date, exercise_key: exercise.key, set_number: set_number, checked: params[:checked])
    head :no_content
  end

  def history
    @completed_workouts = CompletedSet.group(:date).order(date: :desc).count.filter_map do |date, count|
      workout = WorkoutRoutine.for(date)
      if workout && count == workout.fetch(:exercises).sum(&:sets)
        [ date, workout.fetch(:name) ]
      end
    end
  end
end
