


import 'package:chat_bot/bloc/chat/chat_event.dart';
import 'package:chat_bot/bloc/chat/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef BotCommand =  String Function();


class ChatBloc  extends Bloc<ChatEvent,ChatState> {
  
  ChatBloc() : super(ChatStateInit()){
    on<MessageReciveEvent>(_handleMessageRecive);
    on<MessageSendEvent>(_handleSendMessge);
    on<AutoBotMessgeEvent>(_handleBot);
  }

  
  final Map<String, BotCommand> autoCommands = {
    "hello": () => "Hello, I'm your friendly chatbot. How can I assist you today?",
    "hi": () => "Hi there! How can I help you?",
    "how are you": () => "I'm just a bot, but I'm running perfectly fine. Thanks for asking!",
    "time": () {
      final now = DateTime.now().toLocal();
      return "The current time is: ${now.hour}:${now.minute}:${now.second}";
    },
    "date": () {
      final today = DateTime.now().toLocal();
      return "Today's date is: ${today.year}-${today.month}-${today.day}";
    },
    "thanks": () => "You're most welcome! 😊",
    "bye": () => "Goodbye! Have a great day!",
    "help": () => "You can ask me about 'time', 'date', greetings like 'hello', 'hi', or say 'thanks', 'bye'.",
    "your name": () => "I'm your Flutter powered chatbot 🤖"
  };

  String getBotResponse(String userInput) {
    final input = userInput.toLowerCase().trim();
    return autoCommands[input]?.call() ?? "I'm sorry, I didn't understand that. You can type 'help' to see what I can do.";
  }

  void _handleMessageRecive(MessageReciveEvent event,Emitter<ChatState> emit){
    //Save message database 
  }


  void _handleSendMessge(MessageSendEvent event,Emitter<ChatState> emit){
    //Save message database 
    // List<String> currantMsg = List.from(state.collectedMessage)..add(event.message);
    emit(ChatStateUpdate(getModifyListAdd(event.message)));
  }

  List<String> getModifyListAdd(String msg) => List.from(state.collectedMessage)..add(msg);

  void _handleBot(AutoBotMessgeEvent event,Emitter<ChatState> emit) async {

    await Future.delayed(const Duration(seconds: 1),(){});
    emit(ChatStateUpdate(getModifyListAdd(getBotResponse(event.lastMsg))));

    //Save message database 
  }
 
}