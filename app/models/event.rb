class Event < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :users
  has_many :plans
  has_many :users_planned, through: :plans, source: :user
  validate :future_event
  validates :name, :location, :state, :date, presence: true

end

private
def future_event
  errors.add(:date, "Can't be in the past!") if date < Time.now
end