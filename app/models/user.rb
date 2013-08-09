# require 'bcrypt'

class User < ActiveRecord::Base

	has_many :attendings
	has_many :subjects, through: :attendings

	# include BCrypt

	validates_confirmation_of :password
 	validates_presence_of :password, :on => :create
 	validates_presence_of :username
	validates_uniqueness_of :username

	def self.who_attending(name)		# pass subject name to receive list of students under it
	  Subject.find_by_name!(name).users
	end

	def self.subject_list
		
	end

	def self.authenticate(username, password)
	  user = find_by_username(username)
	  if user && user.password == password
	    user
	  else
	    nil
	  end
	end

# 	before_save :encrypt_password

# 	def encrypt_password
# 	    if password.present?
# 	      self.password_salt = BCrypt::Engine.generate_salt
# 	      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
# 	    end
#  	end
end
