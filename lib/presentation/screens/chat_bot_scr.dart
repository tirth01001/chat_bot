import 'package:chat_bot/bloc/chat/chat_bloc.dart';
import 'package:chat_bot/bloc/chat/chat_event.dart';
import 'package:chat_bot/bloc/chat/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  // final List<String> _messages = [];
  final _controller = TextEditingController();

  void _sendMessage(ChatBloc bloc) {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      bloc.add(MessageSendEvent(_controller.text));
      bloc.add(AutoBotMessgeEvent(_controller.text));
      // setState(() {
      //   _messages.add("You: $text");
      //   _messages.add("Bot: I received your message.");
      // });
      _controller.clear();
    }
  } 

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => ChatBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Chatbot")),
        body: Column(
          children: [

            BlocBuilder<ChatBloc,ChatState>(
              builder: (context,state) {

                return Expanded(
                  child: ListView.builder(
                    itemCount: state.collectedMessage.length,
                    itemBuilder: (_, index) => ListTile(
                      title: Text(state.collectedMessage[index])
                    ),
                  ),
                );
              }
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Enter message...",
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                ),
                BlocBuilder<ChatBloc,ChatState>(
                  builder: (context,state) {

                    return IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: (){
                        _sendMessage(context.read<ChatBloc>());
                      },
                    );
                  }
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
