class ParksController < ApplicationController

    def index
        @small_slots = SmallSlot.all
        @medium_slots = MediumSlot.all
        @large_slots = LargeSlot.all
    end
    
    def new
        @small_slot = SmallSlot.new
        @medium_slot = MediumSlot.new
        @large_slot = LargeSlot.new
    end

    def create
        if car_params.to_h.fetch_values(:car_size) == ["small_vehicle"]
            if SmallSlot.all.length < 5
                @small_slot = SmallSlot.new(car_params)
                @small_slot.save!
                flash[:notice] = "Parking alloted in Small Parking Slot"
                redirect_back(fallback_location: root_path)
            elsif MediumSlot.all.length < 5
                @medium_slot = MediumSlot.new(car_params)
                @medium_slot.save!
                flash[:notice] = "Parking alloted in Medium Parking Slot"
                redirect_back(fallback_location: root_path)
            elsif LargeSlot.all.length < 5
                @large_slot = LargeSlot.new(car_params)
                @large_slot.save!
                flash[:notice] = "Parking alloted in Large Parking Slot"
                redirect_back(fallback_location: root_path)
            else
                redirect_back(fallback_location: root_path)
                flash[:alert] = "No Parking Space"
            end
        elsif car_params.to_h.fetch_values(:car_size) == ["medium_vehicle"]
            if MediumSlot.all.length < 5
                @medium_slot = MediumSlot.new(car_params)
                @medium_slot.save!
                flash[:notice] = "Parking alloted in Medium Parking Slot"
                redirect_back(fallback_location: root_path)
            elsif LargeSlot.all.length < 5
                @large_slot = LargeSlot.new(car_params)
                @large_slot.save!
                flash[:notice] = "Parking alloted in Large Parking Slot"
                redirect_back(fallback_location: root_path)
            elsif MediumSlot.find_by(car_size:"small_vehicle").present? && SmallSlot.all.length < 5
                MediumSlot.find_by(car_size:"small_vehicle").delete
                @small_slot = SmallSlot.new(car_size:"small_vehicle")
                @small_slot.save!
                @medium_slot = MediumSlot.new(car_params)
                @medium_slot.save!
                flash[:notice] = "Parking alloted in Medium Parking Slot"
                redirect_back(fallback_location: root_path)
            else
                render :new, status: :unprocessable_entity
                flash[:alert] = "No Parking Space"
            end
        elsif car_params.to_h.fetch_values(:car_size) == ["large_vehicle"]
            if LargeSlot.all.length < 5
                @large_slot = LargeSlot.new(car_params)
                @large_slot.save!
                redirect_back(fallback_location: root_path)
            elsif LargeSlot.find_by(car_size:"small_vehicle").present? && SmallSlot.all.length < 5
                LargeSlot.find_by(car_size:"small_vehicle").delete
                @small_slot = SmallSlot.new(car_size:"small_vehicle")
                @small_slot.save!
                @large_slot = LargeSlot.new(car_params)
                @large_slot.save!
                flash[:notice] = "Parking alloted in Large Parking Slot"
                redirect_back(fallback_location: root_path)
            elsif LargeSlot.find_by(car_size:"medium_vehicle").present? && MediumSlot.all.length < 5
                LargeSlot.find_by(car_size:"medium_vehicle").delete
                @medium_slot = MediumSlot.new(car_size:"medium_vehicle")
                @medium_slot.save!
                @large_slot = LargeSlot.new(car_params)
                @large_slot.save!
                flash[:notice] = "Parking alloted in Large Parking Slot"
                redirect_back(fallback_location: root_path)
            else
                render :new, status: :unprocessable_entity
                flash[:alert] = "No Parking Space"
            end

        end
    end

    def car_params
        params.permit(:car_size)
    end
  

end
