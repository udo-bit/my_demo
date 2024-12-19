import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String? hint;
  final ValueChanged<String>? onChanged;
  final TextInputType? textInputType;
  final bool? obscureText;
  final IconData? iconData;

  const InputWidget(
      {super.key,
      this.hint,
      this.onChanged,
      this.textInputType,
      this.obscureText = false,
      this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          keyboardType: textInputType,
          onChanged: onChanged,
          obscureText: obscureText ?? false,
          style: const TextStyle(color: Colors.white, fontSize: 20),
          decoration: InputDecoration(
              icon: Icon(
                iconData ?? Icons.person,
                color: Colors.white,
              ),
              border: InputBorder.none,
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white, fontSize: 20)),
        ),
        const Divider(
          indent: 0.8,
          height: 1,
        )
      ],
    );
  }
}
