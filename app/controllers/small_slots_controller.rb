class SmallSlotsController < ApplicationController
   

  

    def destroy
        @small_slot = SmallSlot.find(params[:id])
        @small_slot.destroy
        flash[:alert] = "Unparked"
        redirect_back(fallback_location: root_path)
    end

  


end


