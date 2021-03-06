import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'cashe_keys.dart';

class AppConfig {
  static String activeUrl = "https://api.uracashback.uz";
}

class HttpResult {
  final bool isSuccess;
  final int status;
  final String body;

  HttpResult(this.isSuccess, this.status, this.body);
}

class ApiRequests {
  static HttpResult _result(response){
    dynamic body = response.body;

    int status = response.statusCode ?? 404;
    if(response.statusCode >= 200 && response.statusCode <= 299){
      return HttpResult(true, status, body);
    } else {
      return HttpResult(false, status, body);
    }
  }

  Future<HttpResult> get({required String slug, required Map<String, String> headerMap}) async {
    Uri url = Uri.parse("${AppConfig.activeUrl}/$slug");
    try{
      final response =  await http.get(
        url,
        headers: headerMap,
      );
      return _result(response);
    } on TimeoutException catch (error) {
      print("TimeOutException: $error");
      return _result({});
    } on SocketException catch (error) {
      print("SocketException: $error");
      return _result({});
    } catch (error) {
      return _result({});
    }
  }

  Future<HttpResult> post({
    required String slug,
    required Map body,
    required Map<String, String> header,
    bool needToken = true,
    bool needEncode = true
  }) async {
    Uri url = Uri.parse("${AppConfig.activeUrl}/$slug");
    try {
      final response = await http.post(
        url,
        headers: header,
        body: needEncode ? jsonEncode(body) : body,
      );
      print("HTTP result print qivoman");
      print(body);
      print(response.body);
      return _result(response);
    } on TimeoutException catch (error) {
      print("TimeOutException: $error");
      return _result({});
    } on SocketException catch (error) {
      print("SocketException: $error");
      return _result({});
    } catch (error) {
      return _result({});
    }
  }

}