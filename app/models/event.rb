class Event < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :plans
  has_many :users_planned, through: :plans, source: :user
  validates :name, :location, :state, :date, presence: true
  validate :future_event

end

private
def future_event
  errors.add(:date, "Can't be in the past!") if :date < Time.now
end