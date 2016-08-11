class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.integer :team1_votes
      t.integer :team2_votes
      t.integer :both_votes
      t.integer :neither_votes
      t.integer :quality

      t.timestamps
    end
  end
end
