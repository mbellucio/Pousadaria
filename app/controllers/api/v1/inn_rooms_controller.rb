class Api::V1::InnRoomsController < ActionController::API
  def show
    begin
      inn_room = InnRoom.find(params[:id])
      render status: 200, json: inn_room.as_json(only: [:name, :size, :guest_limit, :daily_rate_cents])
    rescue
      render status: 404, json: {error: "Unable to find a room with the given id"}.to_json
    end
  end
end
