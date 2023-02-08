class CreateSmallSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :small_slots do |t|
      t.string :car_size

      t.timestamps
    end
  end
end
