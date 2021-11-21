class ChatroomsController < ApplicationController
  def show
    @chatroom = Chatroom.find params[:id]
    @message = Message.new # we create this for the simple_form
  end
end
