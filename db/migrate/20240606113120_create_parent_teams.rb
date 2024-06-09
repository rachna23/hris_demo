class CreateParentTeams < ActiveRecord::Migration[7.1]
  def change
    create_table :parent_teams do |t|
      t.string :name
      t.timestamps
    end
  end
end
