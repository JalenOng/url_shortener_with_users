class CreateUsers < ActiveRecord::Migration
  def change
      create_table :users do |u|
      u.text :username
      u.text :password
      u.timestamp
    end
  end
end
