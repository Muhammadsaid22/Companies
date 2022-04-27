import '../models/company_model.dart';
import '../models/verify_model.dart';
import '../services/http_service.dart';

class AuthRepository{
  Future<String?> login(Map<String, String> headerMap, Map bodyMap) async {
    final result = await ApiRequests().post(
        slug: "security/send-verification", body: bodyMap, header: headerMap);
    if (result.isSuccess) {
      try {
        print("login");
        print(result.status);
        print(result.body);
        return result.body;
      } catch (error) {
        print("loginModelFromJson error in login: $error");
        return null;
      }
    } else {
      print("login error: ${result.status}");
        return null;
      }
    }


  Future<Verify?> verify(Map<String, String> headerMapVerify,
      Map bodyVerify) async {
    final result = await ApiRequests().post(
        slug: "security/verify-login", body: bodyVerify, header: headerMapVerify);
    if (result.isSuccess) {
      try {
        return verifyFromJson(result.body);
      }
      catch (error) {
        print("VerifyModel has a error ${error}");
        return null;
      }
    }
    else {
      print(result.status);
      print(" Verify error : ${result.body}");
      return null;
    }
  }

  Future<Companies?> companyList(String token,) async {
    final result = await ApiRequests().get(
        slug: "companies",
        headerMap: {
          'Authorization' :'Bearer $token'
        });

     companiesFromJson(result.body);
     print("Modeldigi error");
     print(result.body);
    if (result.isSuccess) {
      try {
        return companiesFromJson(result.body);
      }
      catch (error) {
        print("Company has a error ${error}");
        return null;
      }
    }
    else {
      print(result.status);
      print(" Companies List error : ${result.body}");
      return null;
    }
  }
}