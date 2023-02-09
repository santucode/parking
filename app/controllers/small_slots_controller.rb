class SmallSlotsController < ApplicationController
    def index
        @small_slots = SmallSlot.all
    end
    
    def new
        @small_slot = SmallSlot.new
        @medium_slot = MediumSlot.new
    end

    def create
        if car_params.to_h.fetch_values(:car_size) == ["small_vehicle"]
            if SmallSlot.all.length < 5
                @small_slot = SmallSlot.new(car_params)
                @small_slot.save!
                redirect_to root_path
            elsif MediumSlot.all.length < 5
                @medium_slot = MediumSlot.new(car_params)
                @medium_slot.save!
                redirect_to root_path
            else
                render :new, status: :unprocessable_entity
                flash[:message] = "Try Again"
            end
        end
    end

    def destroy
        @small_slot = SmallSlot.find(params[:id])
        @small_slot.destroy
        flash[:alert] = "Unparked"
        redirect_back(fallback_location: root_path)
    end

    def car_params
        params.permit(:car_size)
    end


end


