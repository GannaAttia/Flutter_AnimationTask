import 'package:flutter/material.dart';

class YellowBall extends StatelessWidget {
  final double left;

  const YellowBall({super.key, required this.left});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: 150,
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.yellow,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
