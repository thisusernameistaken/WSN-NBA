class User < ActiveRecord::Base
  has_secure_password
  has_many :trades
  acts_as_voter

  validates_presence_of :name,:email
  validates_presence_of :password, :on => :create
  validates_length_of :password, :minimum => 6
  validates_uniqueness_of :name, :email
  validates_length_of :name, :minimum => 5, :maximum => 15
  validates_confirmation_of :password
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates_format_of :name,:with => /\A[a-zA-Z0-9]+\Z/

  def initialize(attributes = {})
    super(attributes)
    self.score=0
  end
end
