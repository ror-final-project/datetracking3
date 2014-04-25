class Relationship < ActiveRecord::Base
	belongs_to :user
	belongs_to :datee, :class_name => 'User', :foreign_key => 'datee_id'

end
