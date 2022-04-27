part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class Loading extends LoginState {}
class Loaded extends LoginState {
  final List<Verify> postList;
  Loaded(this.postList);
}
class Error extends LoginState {}
