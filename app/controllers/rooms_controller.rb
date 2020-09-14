class RoomsController < ApplicationController
  
  def create
  	room = Room.create
  	current_entry = Entry.create(user_id: current_user.id, room_id: room.id)
  	another_entry = Entry.create(user_id: params[:user_id], room_id: room.id)
  	redirect_to room_path(room)
  end

  def index
  	current_entries = current_user.current_entries
  	my_room_ids = []
  	current_entries.each do |entry|
  		my_room_ids << entry.room.id
  	end
  	@another_entries = Entry.where(room_id: my_room_ids).where.not(user_id: current_user.id)
  end

  def show
  	@room = Room.find(params[:id])
  	@message = Message.new
  	@another_entry = @room.entries.find_by('user_id != ?', current_user.id)
  end
end
