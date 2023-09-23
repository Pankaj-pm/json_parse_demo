import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpHelper {
  String baseUrl;

  HttpHelper._(this.baseUrl);

  // static final HttpHelper _singleton = HttpHelper._("pixabay.com");
  static final HttpHelper _singleton = HttpHelper._("api.restful-api.dev");

  factory HttpHelper(String baseUrl) {
    return _singleton;
  }

  Future<Map<String, dynamic>> httpGet(String endPoint, {Map<String, dynamic>? queryParam}) async {
    //https://jsonplaceholder.typicode.com/users
    var uri = Uri.https(baseUrl, "api/$endPoint", queryParam);
    print("uri $uri");
    http.Response respose = await http.get(uri);
    if (respose.statusCode == 200) {
      return jsonDecode(respose.body);
    } else {
      print(respose.statusCode);
      print(respose.body);
      return {};
    }
  }

  Future<Map<String, dynamic>> httpPost(String endPoint, dynamic body) async {
    //https://jsonplaceholder.typicode.com/users
    var uri = Uri.https(baseUrl, endPoint);
    print("Api Post Url => ${uri}");
    http.Response respose = await http.post(
      uri,
      body: body,
      headers: {
        'Content-Type': 'application/json'
      },
    );

    if (respose.statusCode == 200) {
      return jsonDecode(respose.body);
    } else {
      print(respose.statusCode);
      print(respose.body);
      return {};
    }
  }
}
