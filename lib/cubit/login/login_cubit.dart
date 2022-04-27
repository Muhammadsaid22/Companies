import 'package:bloc/bloc.dart';
import 'package:companies_items_a/models/verify_model.dart';
import 'package:companies_items_a/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> loginInfo(Map<String,String> header,Map body)async {
    emit(Loading());
    List<Verify>? ver = (await AuthRepository().verify(header, body)) as List<Verify>?;
    if(ver != null){
      emit(Loaded(ver));
    }
    else{
      emit(Error());
    }
  }
}
