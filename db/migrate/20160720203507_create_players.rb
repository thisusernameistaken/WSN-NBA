class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.float :rating
      t.integer :team_id

      t.timestamps
    end
  end
end
