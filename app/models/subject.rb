class Subject < ActiveRecord::Base
	has_many :attendings
	has_many :users, through: :attendings
end
