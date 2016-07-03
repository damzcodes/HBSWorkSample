class MessageController < ApplicationController

	def index
		@messages = Message.all.order('created_at DESC')
		@message = Message.new
	end


	def create
    @message = Message.create!(message_params)
    if @message.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private

  def message_params
    params.require(:message).permit(:text, :author)
  end
end
