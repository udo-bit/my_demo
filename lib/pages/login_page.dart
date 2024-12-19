import 'package:flutter/material.dart';
import 'package:my_demo/util/func_util.dart';
import 'package:my_demo/util/navigator_util.dart';
import 'package:my_demo/util/view_util.dart';
import 'package:my_demo/widgets/input_widget.dart';
import 'package:my_demo/widgets/login_widget.dart';

import '../dao/login_dao.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? username;
  String? password;
  bool? enabled;

  get _bg {
    return [
      Positioned.fill(
          child: Image.asset(
        'assets/loop_video.gif',
        fit: BoxFit.cover,
      )),
      Positioned.fill(
          child: Container(
        color: Colors.black12,
      ))
    ];
  }

  get _content => Positioned.fill(
      left: 30,
      right: 30,
      child: ListView(
        children: [
          hiHeight(height: 150),
          const Text(
            "账号密码登陆",
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
          ),
          hiHeight(height: 20),
          InputWidget(
            hint: '请输入用户名',
            onChanged: (value) {
              username = value;
              _validate();
            },
          ),
          hiHeight(height: 20),
          InputWidget(
            hint: '请输入密码',
            iconData: Icons.lock,
            obscureText: true,
            onChanged: (value) {
              password = value;
              _validate();
            },
          ),
          hiHeight(height: 10),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              '注册用户',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          hiHeight(height: 20),
          LoginWidget(
            isEnable: enabled,
            callback: _login,
          )
        ],
      ));

  _login() async {
    // 登陆
    try {
      await LoginDao.login(username!, password!);
      // 底部提示
      if (mounted) {
        NavigatorUtil.goToHome(context);
      }
      // 跳转页面
    } catch (e) {
      debugPrint(e.toString());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            clipBehavior: Clip.antiAlias,
            duration: Duration(seconds: 1),
            backgroundColor: Colors.blueGrey,
            content: Text(
              '登陆失败',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [..._bg, _content],
      ),
    );
  }

  void _validate() {
    if (isNotEmpty(username) && isNotEmpty(password)) {
      setState(() {
        enabled = true;
      });
    } else {
      setState(() {
        enabled = false;
      });
    }
  }
}
