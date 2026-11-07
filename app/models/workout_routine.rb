class WorkoutRoutine
  Exercise = Data.define(:key, :name, :sets, :reps)

  def self.workout(name, exercises)
    {
      name: name,
      exercises: exercises.map do |exercise, sets, reps|
        Exercise.new(exercise.parameterize, exercise, sets, reps)
      end.freeze
    }.freeze
  end

  SCHEDULE = {
    0 => workout("Pull #2", [
      [ "Neutral-Grip Pulldown", 4, "10–12" ],
      [ "Cable Seated Elbows-Out Row", 3, "10" ],
      [ "Cable Seated Row", 3, "10" ],
      [ "Kneeling Straight-Arm Cable Pullover", 3, "15" ],
      [ "Snatch-Grip Barbell Shrug", 3, "15" ],
      [ "Cable Reverse Flye", 3, "20" ],
      [ "Single-Arm Cable Curl", 3, "12" ],
      [ "Hammer Curl", 3, "8" ]
    ]),
    2 => workout("Push #2", [
      [ "Close-Grip Bench Press", 3, "8" ],
      [ "Overhead Press", 3, "5" ],
      [ "Dumbbell Incline Press", 3, "10–12" ],
      [ "Pec Deck", 3, "15" ],
      [ "Cable Lateral Raise", 4, "8" ],
      [ "Cable Triceps Kickback", 3, "20" ],
      [ "Bicycle Crunch", 3, "12" ]
    ]),
    3 => workout("Legs #1", [
      [ "Back Squat", 4, "5" ],
      [ "Romanian Deadlift", 3, "8–10" ],
      [ "Cable Pullthrough", 2, "10–12" ],
      [ "Dumbbell Walking Lunge", 2, "20 each leg" ],
      [ "Leg Extension", 2, "15" ],
      [ "Seated Leg Curl", 2, "15" ],
      [ "Standing Calf Raise", 3, "10" ]
    ]),
    4 => workout("Pull #1", [
      [ "1-Arm Lat Pull-In", 2, "15–20" ],
      [ "Pull-Up", 4, "6–8" ],
      [ "Pendlay Row", 3, "8–10" ],
      [ "Machine High Row", 3, "10–12" ],
      [ "Seated Face Pull", 3, "20" ],
      [ "Reverse-Grip EZ-Bar Curl", 3, "20" ],
      [ "Supinated EZ-Bar Curl", 3, "15" ],
      [ "Dumbbell Preacher Curl", 3, "12" ]
    ]),
    5 => workout("Push #1", [
      [ "Barbell Bench Press", 3, "4" ],
      [ "Dumbbell Seated Shoulder Press", 3, "8–10" ],
      [ "Weighted Dip", 2, "6–10" ],
      [ "Low-to-High Cable Flye", 2, "12–15" ],
      [ "Dumbbell Isolateral Skull Crusher", 4, "12" ],
      [ "Dumbbell Lateral Raise", 3, "15" ],
      [ "Ab Wheel Rollout", 3, "6" ]
    ]),
    6 => workout("Legs #2", [
      [ "Deadlift", 4, "4" ],
      [ "Front Squat", 3, "6–8" ],
      [ "Single-Leg Leg Press", 2, "10–12" ],
      [ "Single-Leg Leg Extension", 3, "15" ],
      [ "Swiss Ball Single-Leg Leg Curl", 3, "12" ],
      [ "Seated Calf Raise", 3, "15" ]
    ])
  }.freeze

  private_class_method :workout

  def self.for(date)
    SCHEDULE[date.wday]
  end
end
