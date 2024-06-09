class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :team
  validates :role, presence: true
  validates :user_id, uniqueness: { scope: :team_id, message: "should be assigned to only one team" }
end
