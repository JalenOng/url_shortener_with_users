class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |url|
      url.text :long_url
      url.text :short_url
      url.integer :user_id
      url.integer :click_count
      url.timestamp
    end
  end
end
