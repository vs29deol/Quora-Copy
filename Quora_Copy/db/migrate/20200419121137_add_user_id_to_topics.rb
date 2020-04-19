class AddUserIdToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :user_id, :integer
    add_column :topics, :following_users, :integer, array: true, default: []
    add_column :topics, :name, :string
  end
end
