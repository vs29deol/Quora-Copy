class Question < ActiveRecord::Base
	has_many :answers, dependent: :destroy
	belongs_to :user
	belongs_to :topic
	validates :name, presence: true
end
