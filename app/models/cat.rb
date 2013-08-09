class Cat < ActiveRecord::Base
  attr_accessible :birth_date, :color, :name, :sex, :user_id
  validates :user_id, :presence => true
  CAT_COLORS = %w{red yellow black blue purple neon-green chartruse}
  validates :color, inclusion: { in: CAT_COLORS }

  def age
    Time.new.year - birth_date.year if birth_date
  end

  has_many :requests, :class_name => "CatRentalRequest",
  :foreign_key => :cat_id,
  :primary_key => :id,
  :dependent => :destroy

  belongs_to :user, :class_name => "User",
  :foreign_key => :user_id,
  :primary_key => :id

end
