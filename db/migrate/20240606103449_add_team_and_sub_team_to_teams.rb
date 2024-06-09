class AddTeamAndSubTeamToTeams < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :team, :string
    add_column :teams, :sub_team, :string
  end
end
