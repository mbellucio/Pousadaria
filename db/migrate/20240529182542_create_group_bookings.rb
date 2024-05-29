class CreateGroupBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :group_bookings do |t|
      t.string :name
      t.date :check_in
      t.date :check_out

      t.timestamps
    end
  end
end
