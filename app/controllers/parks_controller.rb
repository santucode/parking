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
                flash[:warning] = "Parking alloted"
                redirect_to root_path
            elsif MediumSlot.all.length < 5
                @medium_slot = MediumSlot.new(car_params)
                @medium_slot.save!
                redirect_to root_path
            elsif LargeSlot.all.length < 5
                @large_slot = LargeSlot.new(car_params)
                @large_slot.save!
                redirect_to root_path
            else
                render :new, status: :unprocessable_entity
                flash[:message] = "Try Again"
            end
        elsif car_params.to_h.fetch_values(:car_size) == ["medium_vehicle"]
            if MediumSlot.all.length < 5
                @medium_slot = MediumSlot.new(car_params)
                @medium_slot.save!
                redirect_to root_path
            elsif LargeSlot.all.length < 5
                @large_slot = LargeSlot.new(car_params)
                @large_slot.save!
                redirect_to root_path
            elsif MediumSlot.find_by(car_size:"small_vehicle").present? && SmallSlot.all.length < 5
                MediumSlot.find_by(car_size:"small_vehicle").delete
                @small_slot = SmallSlot.new(car_size:"small_vehicle")
                @small_slot.save!
                @medium_slot = MediumSlot.new(car_params)
                @medium_slot.save!
                redirect_to root_path
            else
                render :new, status: :unprocessable_entity
                flash[:message] = "Try Again"
            end
        elsif car_params.to_h.fetch_values(:car_size) == ["large_vehicle"]
            if LargeSlot.all.length < 5
                @large_slot = LargeSlot.new(car_params)
                @large_slot.save!
            else
                render :new, status: :unprocessable_entity
                flash[:message] = "Try Again"
            end

        end
    end

    def car_params
        params.permit(:car_size)
    end
  

end
