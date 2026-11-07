class CreateCompletedSets < ActiveRecord::Migration[8.1]
  def change
    create_table :completed_sets do |t|
      t.date :date, null: false
      t.string :exercise_key, null: false
      t.integer :set_number, null: false

      t.index %i[ date exercise_key set_number ], unique: true
    end
  end
end
