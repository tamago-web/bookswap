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

ActiveRecord::Schema.define(version: 2024_12_09_054331) do

  create_table "book_swaps", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "offering_book_id", null: false
    t.bigint "requested_book_id", null: false
    t.bigint "user_id"
    t.string "status", default: "pending"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["offering_book_id"], name: "index_book_swaps_on_offering_book_id"
    t.index ["requested_book_id"], name: "index_book_swaps_on_requested_book_id"
    t.index ["user_id"], name: "index_book_swaps_on_user_id"
  end

  create_table "books", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "title", null: false
    t.string "author"
    t.text "description"
    t.string "genre"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "messages", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "book_swap_id"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_swap_id"], name: "index_messages_on_book_swap_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "reviews", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "book_id"
    t.integer "rating", default: 0, null: false
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_reviews_on_book_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "first_name"
    t.string "last_name"
    t.text "bio"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "book_swaps", "books", column: "offering_book_id"
  add_foreign_key "book_swaps", "books", column: "requested_book_id"
  add_foreign_key "book_swaps", "users"
  add_foreign_key "books", "users"
  add_foreign_key "messages", "book_swaps"
  add_foreign_key "messages", "users"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "users"
end
