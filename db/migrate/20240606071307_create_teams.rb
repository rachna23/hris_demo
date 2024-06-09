# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :department
      t.integer :parent_team_id
      t.integer :manager_id

      t.timestamps
    end
  end
end
