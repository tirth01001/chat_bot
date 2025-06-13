


abstract class ChatState {

  final List<String> collectedMessage;

  ChatState({
    this.collectedMessage = const[],
  });

}

class ChatStateInit extends ChatState {
  ChatStateInit():super(collectedMessage: []);
}


class ChatStateUpdate extends ChatState {
  ChatStateUpdate(List<String> msg): super(
    collectedMessage: msg
  );
}


