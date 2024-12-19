import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_demo/navigator/navigator_page.dart';
import 'package:my_demo/pages/login_page.dart';

class NavigatorUtil {
  static BuildContext? _context;

  static updateContext(BuildContext context) {
    _context = context;
  }

  static goToHome(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const NavigatorPage()));
  }

  static goToLogin(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static pop(BuildContext context) {
    try {
      Navigator.pop(context);
    } catch (e) {
      // 退出App
      SystemNavigator.pop();
    }
  }
}
