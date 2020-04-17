class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
end
