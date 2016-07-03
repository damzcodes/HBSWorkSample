class MessagesController < ApplicationController
  def index
    @messages = Message.all.order('created_at DESC')
    @message = Message.new
  end

  def create
    @message = Message.create!(message_params)
    respond_to do |format|
      if @message.save
        format.html do
          redirect_to messages_path, notice: 'Thank You For Signing!'
        end
      else
        render 'index'
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    redirect_to messages_path
  end

  private

  def message_params
    params.require(:message).permit(:text, :author)
  end
end
