import 'package:flutter/material.dart';

class GreenBall extends StatelessWidget {
  final double top;

  const GreenBall({super.key, required this.top});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 150,
      top: top,
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
