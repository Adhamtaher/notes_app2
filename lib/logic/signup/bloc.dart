import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app2/logic/signup/event.dart';
import 'package:notes_app2/logic/signup/state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final FirebaseAuth auth;

  SignUpBloc(this.auth) : super(SignUpInitial()) {
    on<createAccountEvent>((event, emit) async {
      emit(SignUpLoading());
      try {
        await auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(SignUpLoaded());
      } on FirebaseAuthException catch (e){
        emit(SignUpError(e.message ?? 'an error has occurred'));
      } catch (e) {
        emit(SignUpError("Something wrong happened"));
      }
    });
  }
}
