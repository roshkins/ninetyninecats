class User < ActiveRecord::Base
  attr_accessible :password, :username, :session_token
  validates :username, :password, :presence => true
  validates :username, :uniqueness => true

  has_many :cats, :class_name => "Cat",
  :foreign_key => :user_id,
  :primary_key => :id,
  :dependent => :destroy

  def set_token
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
  end

end
