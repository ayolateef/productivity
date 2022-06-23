import 'package:flutter/material.dart';

typedef CallbackSetting = void Function(String, int);

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final VoidCallback onPressed;

  const ProductivityButton(
      {
        required this.color,
      required this.text,
      required this.size,
      required this.onPressed
      });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: this.onPressed,
      color: this.color,
      minWidth: (this.size !=null) ? this.size : 0,
    );
  }
}

void emptyMethod() {}

class SettingButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final int value;
  final String callback;
  final String setting;
   const SettingButton(this.color, this.text, this.value, this.size, this.callback, this.setting);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        this.text,
        style: const TextStyle(color: Colors.white),
      ),
      onPressed: () => callback ,
      color: color,
      minWidth: 5.0,
    );
  }
}

