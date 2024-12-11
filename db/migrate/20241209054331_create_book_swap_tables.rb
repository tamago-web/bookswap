class CreateBookSwapTables < ActiveRecord::Migration[6.1]
  def change
    # Users テーブル
    create_table :users do |t|
      t.string :username, null: false, unique: true
      t.string :email, null: false, unique: true
      t.string :password_digest, null: false
      t.string :first_name
      t.string :last_name
      t.text :bio
      t.timestamps
    end

    # Books テーブル
    create_table :books do |t|
      t.string :title, null: false
      t.string :author
      t.text :description
      t.string :genre
      t.references :user, foreign_key: true
      t.timestamps
    end

    # BookSwaps テーブル
    create_table :book_swaps do |t|
      t.references :offering_book, foreign_key: { to_table: :books }, null: false
      t.references :requested_book, foreign_key: { to_table: :books }, null: false
      t.references :user, foreign_key: true
      t.string :status, default: 'pending'  # 交換リクエストのステータス ('pending', 'accepted', 'completed')
      t.timestamps
    end

    # Messages テーブル
    create_table :messages do |t|
      t.references :user, foreign_key: true
      t.references :book_swap, foreign_key: true
      t.text :content
      t.timestamps
    end

    # Reviews テーブル
    create_table :reviews do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.integer :rating, null: false, default: 0  # 例：1〜5の評価
      t.text :comment
      t.timestamps
    end
  end
end