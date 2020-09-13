class MessagesController < ApplicationController

	def create
		message = Message.new(message_params)
		message.user_id = current_user.user_id
		if message.save
			redirect_to room_path(message.room)
		else
			redirect_back(falllback_location: room_path)
		end
	end

	def destroy
		message - Message.find(params[:id])
		message.destroy
		redirect_back(fallback_location: room_path)
	end

	private

	def message_params
		params.require(:message).permit(:room_id, :body)
	end
end
