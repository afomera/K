class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :login

  validate :validate_username
  # Only allow letter, number, underscore and punctuation.
  validates :username, format: {message: "can only contain letters, numbers, underscores or dashes.", with: /\A[A-Za-z0-9\-\_]+\z/ }


  private

   def validate_username
     if User.where(email: username).exists?
       errors.add(:username, :invalid)
     end
   end

   # Override find_for_database_authentication
     # If you're not using PostgreSQL you may run into some problems here
     def self.find_for_database_authentication(warden_conditions)
         conditions = warden_conditions.dup
         if login = conditions.delete(:login)
           where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
         else
           where(conditions.to_hash).first
         end
     end
end
