class CreateJoinTableTeamTrade < ActiveRecord::Migration
  def change
    create_join_table :teams, :trades do |t|
      # t.index [:team_id, :trade_id]
      # t.index [:trade_id, :team_id]
    end
  end
end
