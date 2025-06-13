import 'package:chat_bot/bloc/auth/auth_bloc.dart';
import 'package:chat_bot/bloc/auth/auth_event.dart';
import 'package:chat_bot/bloc/auth/auth_state.dart';
import 'package:chat_bot/presentation/screens/chat_bot_scr.dart';
import 'package:chat_bot/presentation/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chatbot',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => AuthBloc()..add(IsAuthenticated()),
        child: BlocBuilder<AuthBloc,AuthState>(
          builder: (context, state) {
            
            if(state is AuthAuthenticated){

              return ChatbotScreen();
            }
            

            return LoginScreen();
          },
        ),
      ),
      // home: FutureBuilder<bool>(
      //   future: isLoggedIn(),
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //     return snapshot.data! ? const ChatbotScreen() : const LoginScreen();
      //   },
      // ),
    );
  }
}
