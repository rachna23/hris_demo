# frozen_string_literal: true

require 'csv'

namespace :one_time do
  task seed_human_resource_info_system_data: :environment do
    CSV.parse(File.read('./db/seed/hris.csv'), quote_char: '"', headers: true).each do |row|
      # Create or find the manager
      user = User.find_or_create_by!(email: row['Email']) do |u|
        u.name = row['Name']
        u.email = row['Email']
        u.manager = row['Manager email']
        u.start_date = row['Start Date']
      end

      team_name = [row['Department'], row['Team'], row['Sub Team']].compact.join(' - ')
      # Find or create the team
      team = Team.find_or_create_by!(name: team_name) do |t|
        t.department = row['Department']
        t.team = row['Team']
        t.sub_team = row['Sub Team']
        # Assign manager only if the user is indeed the manager
        t.manager = user if row['Manager email']
      end

      # Set parent team if needed
      if row['Team'].present?
        parent_team_name = [row['Department'], row['Team']].join(' - ')
        parent_team = Team.find_or_create_by!(name: parent_team_name) do |pt|
          pt.department = row['Department']
          pt.team = row['Team']
          pt.manager = team.manager
        end
        team.update!(parent_team:)
      end

      # Ensure parent teams cannot have individual contributors
      if team.parent_team.present?
        team.update!(individual_contributor: false)
      else
        team.update!(individual_contributor: true)
      end

      # Create or find the membership
      Membership.find_or_create_by!(user:, team:) do |m|
        m.role = (team.manager.present? ? 'manager' : 'member')
      end
    end
  end
end
