class CatRentalRequest < ActiveRecord::Base
  attr_accessible :begin_date, :cat_id, :end_date, :status

  validates :cat_id, :begin_date, :end_date, :status, :presence => true
  STATUS = %w{undecided approved declined}
  validates :status, :inclusion => {:in => STATUS}
  validate :doesnt_overlap_times_and_is_approved

  belongs_to :cat, :class_name => "Cat", :foreign_key => :cat_id,
  :primary_key => :id

  def doesnt_overlap_times_and_is_approved
    unless self.status == 'declined'
      CatRentalRequest.all.each do |cat_request|
        if cat_request.status == "approved" && is_overlapping?(cat_request)
          errors.add(:begin_date,
          "cannot be between any approved rental dates")
        end
      end
    end
  end

  def approve
    self.status = "approved"
    if self.save
      CatRentalRequest.all.each do |cat_request|
       if self.is_overlapping?(cat_request) && self.id != cat_request.id
          p cat_request
          cat_request.status = "declined"
          p cat_request
          cat_request.save!
       end
     end
   end
 end

  def decline
    self.status = "declined"
    self.save!
  end

  protected
  def is_overlapping?(cat_request)
     (self.begin_date >= cat_request.begin_date &&
     self.begin_date <= cat_request.end_date) ||
     (self.end_date >= cat_request.begin_date &&
     self.end_date <= cat_request.end_date)
  end
end
