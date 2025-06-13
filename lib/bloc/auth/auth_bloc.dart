import 'package:bloc/bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLogin);
    on<SignupRequested>(_onSignup);
    on<LogoutRequested>(_onLogout);
    on<IsAuthenticated>(_handleAuth);
  }

  void _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1));
    if (event.email.isNotEmpty && event.password.isNotEmpty) {

      

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      emit(AuthAuthenticated());
    } else {
      emit(AuthFailure("Invalid email or password"));
    }
  }

  void _onSignup(SignupRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1));

    // Manage datybase 
    emit(AuthUnauthenticated());
  }

  void _onLogout(LogoutRequested event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    emit(AuthUnauthenticated());
  }

  void _handleAuth(IsAuthenticated event, Emitter<AuthState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    bool data = prefs.getBool('isLoggedIn') ??  false;
    emit(data ? AuthAuthenticated() : AuthFailure("User not authenticated !"));
  }
}
