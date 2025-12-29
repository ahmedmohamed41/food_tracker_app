import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.title,
    required this.size,
    required this.fontWeight,
    this.color,
  });
  final String title;
  final double size;
  final FontWeight fontWeight;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: color, fontSize: size, fontWeight: fontWeight),
    );
  }
}
