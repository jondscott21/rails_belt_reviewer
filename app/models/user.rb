class User < ApplicationRecord
  has_secure_password
  has_many :events
  has_many :comments
  has_many :plans
  has_many :events_planned, through: :plans, source: :event

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :location, presence: true
  validates :password, length: {minimum: 8}
  validates :state, presence: true, length: {is:2}
  validates :email, presence:  true, uniqueness: {case_sensitive: false}, format: {with: EMAIL_REGEX}
  before_save :downcase_email, :first_name_uppercase, :last_name_uppercase
end
private
def downcase_email
  self.email.downcase!
end
def first_name_uppercase
  first_name.capitalize!
end
def last_name_uppercase
  last_name.capitalize!
end