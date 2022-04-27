import 'package:bloc/bloc.dart';
import 'package:companies_items_a/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

import '../../models/company_model.dart';

part 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  CompanyCubit() : super(CompanyInitial());
  Future<void> companyInfo(String token) async {
    emit(CompanyLoading());
    Companies? pos = await AuthRepository().companyList(token);
    if(pos != null){
      emit(CompanyLoaded(pos));
    }
    else if(pos == null){
      emit(CompanyError("Error!"));
    }
  }
}
