class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  before_create :set_slug

  private

  def set_slug
    self.slug = self.username.gsub(' ', '-')
  end
end
