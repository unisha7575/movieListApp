import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'app_exceptions.dart';

class BaseClient {
  static const int timeOutDuration = 30;

//Get

  Future<dynamic> get(String baseurl, String api, {String bearerToken = ''}) async {
    final uri = Uri.parse(baseurl + api);
    String token = bearerToken;
    final headers = (token != '') ? {'Content-Type' :'Application/jason ','Authorizations' : 'Bearer $token'}:{'Content-Type':'Application /jason'};
    try {
      final response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    }
    on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    }
    on TimeoutException {
      throw ApiNotRespondingException(
          'API not responding this time', uri.toString());
    }
  }

//POST

  Future<dynamic> post(String baseUri, String api, dynamic payLoadObj, {String bearerToken = ''}) async {
    print("Line34: ${(baseUri + api)}");
    String token = bearerToken;
    final headers = (token != '') ? {'Content-Type' :'Application/json ','Authorizations' : 'Bearer $token'}:{'Content-Type':'Application/json'};
    final uri = Uri.parse(baseUri + api);
    final payload = jsonEncode(payLoadObj);
    try{
      final response = await http.post(uri, body: payload, headers: headers)
          .timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    }
    on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    }
    on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
    }

//PUT

  Future<dynamic> put(String baseUrl, String api, dynamic payloadObj,
      {String bearerToken = ''}) async {
    final String token = bearerToken;
    final headers = (token != '')
        ? {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'}
        : {'Content-Type': 'application/json'};
    final uri = Uri.parse(baseUrl + api);
    final payload = jsonEncode(payloadObj);
    try {
      final response = await http
          .put(uri, body: payload, headers: headers)
          .timeout(const Duration(seconds: timeOutDuration));
      return _processResponse(response);
    }
    on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    }
    on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

//Delete
  //Others

  dynamic _processResponse(http.Response response)
  {
    print("Line82: ${response.statusCode}");
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
        break;
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
        break;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 403:
      case 500:
      default:
        throw FetchDataException(
            'Error occurred with code: ${response.statusCode}',
            response.request!.url.toString());
    }
  }

  }



