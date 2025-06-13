

abstract class ChatEvent {}

class MessageReciveEvent extends ChatEvent {

  final String messgae;

  MessageReciveEvent(this.messgae);

}


class MessageSendEvent extends ChatEvent {

  final String message;

  MessageSendEvent(this.message);

}

class AutoBotMessgeEvent extends ChatEvent {

  final String lastMsg;

  AutoBotMessgeEvent(this.lastMsg);

}