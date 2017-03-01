class Tweet < ApplicationRecord

	has_many :comments, dependent: :destroy

	validates :author, presence: true
	
end
