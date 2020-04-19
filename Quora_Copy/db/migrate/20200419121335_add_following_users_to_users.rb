class AddFollowingUsersToUsers < ActiveRecord::Migration
  def change
    add_column :users, :following_users, :integer, array: true, default: []
  end
end
