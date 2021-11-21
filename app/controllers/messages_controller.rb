class MessagesController < ApplicationController
  def create
    @message = Message.new(strong_params)
    @chatroom = Chatroom.find(params[:chatroom_id])
    @user = current_user
    @message.user = @user
    @message.chatroom = @chatroom

    if @message.save
      redirect_to chatroom_path(@chatroom)
      ChatroomChannel.broadcast_to(
        @chatroom,
        render_to_string(partial: "message", locals: { message: @message })
      )
    else
      render 'chatrooms/show'
    end
  end

  private

  def strong_params
    params.require(:message).permit(:content)
  end
end
