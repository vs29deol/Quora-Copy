class AddUserIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :user_id, :integer
    add_column :questions, :topic_id, :integer
    add_column :questions, :name, :string
  end
end
