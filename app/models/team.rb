class Team < ApplicationRecord
  belongs_to :manager, class_name: 'User', optional: true
  belongs_to :parent_team, class_name: 'Team', optional: true
  has_many :sub_teams, class_name: 'Team', foreign_key: 'parent_team_id'
  has_many :memberships
  has_many :users, through: :memberships

  validates :name, presence: true, uniqueness: true


  # Additional logic to ensure parent teams do not have individual contributors
  before_save :check_parent_team

  private

  def check_parent_team
    if parent_team.present?
      self.individual_contributor = false
    end
  end
end