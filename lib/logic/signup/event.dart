abstract class SignUpEvent{}

class createAccountEvent extends SignUpEvent{
  final String email;
  final String password;

  createAccountEvent({required this.email, required this.password});
}