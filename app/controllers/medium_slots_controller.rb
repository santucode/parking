class MediumSlotsController < ApplicationController
    def destroy
        @medium_slot = MediumSlot.find(params[:id])
        @medium_slot.destroy
        flash[:alert] = "Unparked"
        redirect_back(fallback_location: root_path)
    end
end
