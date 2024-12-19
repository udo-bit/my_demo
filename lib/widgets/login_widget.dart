import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  final bool? isEnable;
  final VoidCallback callback;
  const LoginWidget({super.key, this.isEnable = true, required this.callback});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      height: 50,
      color: Colors.teal,
      onPressed: isEnable ?? false ? callback : null,
      disabledColor: Colors.blueGrey,
      child: const Text(
        '登陆',
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
