class GroupBookingsController < ApplicationController
  def new
    @group_booking = GroupBooking.new
  end
end
