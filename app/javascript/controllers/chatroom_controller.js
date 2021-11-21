import { Controller } from "stimulus"
import consumer from "../channels/consumer";

export default class extends Controller {
  connect() {
    this._initChatroomCable();
  }

  _initChatroomCable = () => {
    const messagesContainer = this.element;
    const id = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) {
        // console.log(data); // called when data is broadcast in the cable
        messagesContainer.insertAdjacentHTML('beforeend', data)
      },
    });
  }
}
