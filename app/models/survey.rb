class Survey < ActiveRecord::Base

	has_many :users
	has_many :answers
	has_one :experience
end
