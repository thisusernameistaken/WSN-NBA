class Trade < ActiveRecord::Base
  has_and_belongs_to_many :teams
  belongs_to :user
  acts_as_votable

  def initialize
    super
    self.both_votes=0
    self.neither_votes=0
    self.team1_votes=0
    self.team2_votes=0
    self.quality=0
  end
end
