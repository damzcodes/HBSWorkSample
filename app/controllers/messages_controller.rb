class MessagesController < ApplicationController
  def index
    @messages = Message.all.order('created_at DESC')
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to messages_path, notice: 'Thank You For Signing!'
    else
      render 'new'
    end
  end

  def destroy
    @message = Message.find(params[:id])
    respond_to do |format|
      if @message.destroy
        format.html do
          redirect_to messages_path, notice: 'Your message has been deleted!'
        end
      else
        redirect_to messages_path
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:text, :author)
  end
end
