class CompletedSet < ApplicationRecord
  def self.record(date:, exercise_key:, set_number:, checked:)
    attributes = { date: date, exercise_key: exercise_key, set_number: set_number }

    if checked
      insert_all([ attributes ], unique_by: %i[ date exercise_key set_number ])
    else
      where(attributes).delete_all
    end
  end
end
