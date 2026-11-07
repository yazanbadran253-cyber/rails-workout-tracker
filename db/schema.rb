# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_11_07_000000) do
  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.integer "pages"
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "completed_sets", force: :cascade do |t|
    t.date "date", null: false
    t.string "exercise_key", null: false
    t.integer "set_number", null: false
    t.index ["date", "exercise_key", "set_number"], name: "index_completed_sets_on_date_and_exercise_key_and_set_number", unique: true
  end
end
