part of 'company_cubit.dart';

@immutable
abstract class CompanyState {}

class CompanyInitial extends CompanyState {}
class CompanyLoading extends CompanyState {}
class CompanyLoaded extends CompanyState {
  final Companies companyList;
  CompanyLoaded(this.companyList,);
}
class CompanyError extends CompanyState {
  final String? error;
  CompanyError(this.error);
}
