import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_hi_cache/flutter_hi_cache.dart';
import 'package:http/http.dart' as http;
import 'package:my_demo/dao/header_util.dart';

class LoginDao {
  static const boardingPass = "boarding_pass";

  static login(String username, String password) async {
    Map<String, String> paramsMap = {};
    paramsMap['userName'] = username;
    paramsMap['password'] = password;
    var uri = Uri.https('api.geekailab.com', '/uapi/user/login', paramsMap);
    final response = await http.post(uri, headers: hiHeader());
    Utf8Decoder utf8decoder = const Utf8Decoder();
    String bodyString = utf8decoder.convert(response.bodyBytes);
    if (response.statusCode == 200) {
      debugPrint('登陆成功');
      var result = json.decode(bodyString);
      if (result['code'] == 0 && result['data'] != null) {
        setBoardingPass(result['data']);
      } else {
        if (response.statusCode == 401) {
          debugPrint('请先登陆');
          // todo 跳转登陆页
          throw Exception(bodyString);
        } else {
          throw Exception(bodyString);
        }
      }
    }
  }

  static setBoardingPass(String value) {
    HiCache.getInstance().setString(boardingPass, value);
  }

  static getBoardingPass() {
    return HiCache.getInstance().get(boardingPass);
  }

  static logout() {
    HiCache.getInstance().remove(boardingPass);
    //todo 跳转登陆页
  }
}
