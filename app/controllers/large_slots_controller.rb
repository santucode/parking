class LargeSlotsController < ApplicationController
    def destroy
        @large_slot = LargeSlot.find(params[:id])
        @large_slot.destroy
        flash[:alert] = "Unparked"
        redirect_back(fallback_location: root_path)
    end
end
