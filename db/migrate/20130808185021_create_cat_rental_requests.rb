class CreateCatRentalRequests < ActiveRecord::Migration
  def change
    create_table :cat_rental_requests do |t|
      t.integer :cat_id, :null => false
      t.date :begin_date, :null => false
      t.date :end_date, :null => false
      t.string :status, :null => false

      t.timestamps
    end
  end
end
