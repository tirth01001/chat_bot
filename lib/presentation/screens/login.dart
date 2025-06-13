

import 'package:chat_bot/bloc/auth/auth_bloc.dart';
import 'package:chat_bot/bloc/auth/auth_event.dart';
import 'package:chat_bot/bloc/auth/auth_state.dart';
import 'package:chat_bot/presentation/screens/chat_bot_scr.dart';
import 'package:chat_bot/presentation/screens/singup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() async {
    if (_formKey.currentState!.validate()) {

      context.read<AuthBloc>().add(LoginRequested(
        email: _emailController.text, 
        password: _passwordController.text
      ));

      if(context.read<AuthBloc>().state == AuthFailure){
        
      }

      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (_) => const ChatbotScreen()),
      );
      
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) {

                  final RegExp emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

                  if(!emailRegex.hasMatch(value??"") && value!.isNotEmpty){
                    
                    return "Please Enter valid email!";
                  }

                  return value!.isEmpty ? "Please enter email" : null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (value) =>
                    value!.isEmpty ? "Please enter password" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login, child: const Text("Login")),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SignupScreen()),
                  );
                },
                child: const Text("Don't have an account? Sign up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
