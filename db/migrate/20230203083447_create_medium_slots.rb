class CreateMediumSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :medium_slots do |t|
      t.string :car_size

      t.timestamps
    end
  end
end
