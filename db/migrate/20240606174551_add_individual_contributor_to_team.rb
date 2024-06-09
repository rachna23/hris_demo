# frozen_string_literal: true

class AddIndividualContributorToTeam < ActiveRecord::Migration[7.1]
  def change
    add_column :teams, :individual_contributor, :boolean
  end
end
