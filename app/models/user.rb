class User < ActiveRecord::Base
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_secure_password
  has_many :organizations
  has_many :members
  validates :first_name, :last_name, :email, presence: true
  validates :email, format: {with: EMAIL_REGEX}, uniqueness: {case_sensitive: false}
end
