class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|
      t.string   "email"
      t.string   "hashed_password",  :limit => 40
      t.string   "remember_token"
      t.datetime "remember_token_expires_at"
      t.string   "first_name"
      t.string   "last_name"
      t.boolean  "is_admin",  :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
