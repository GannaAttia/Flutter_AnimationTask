import 'package:flutter/material.dart';
import 'package:animation_task/components/green_ball.dart';
import 'package:animation_task/components/yellow_ball.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> with TickerProviderStateMixin {
  late AnimationController _greenController;
  late AnimationController _yellowController;
  late Animation<double> _greenAnimation;
  late Animation<double> _yellowAnimation;

  double greenY = 0;
  double yellowX = 0;

  @override
  void initState() {
    super.initState();

    _greenController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _greenAnimation = Tween<double>(begin: 0, end: 300).animate(_greenController)
      ..addListener(() {
        setState(() {
          greenY = _greenAnimation.value;
        });
        _checkCollision();
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _greenController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _greenController.forward();
        }
      });

    _yellowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _yellowAnimation = Tween<double>(begin: 0, end: 300).animate(_yellowController)
      ..addListener(() {
        setState(() {
          yellowX = _yellowAnimation.value;
        });
        _checkCollision();
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _yellowController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _yellowController.forward();
        }
      });

    _startAnimations();
  }

  void _startAnimations() {
    _greenController.forward();
    _yellowController.forward();
  }

  void _pauseAnimations() {
    _greenController.stop();
    _yellowController.stop();
  }

  void _resumeAnimations() {
    _greenController.forward();
    _yellowController.forward();
  }

  void _restartAnimations() {
    _greenController.reset();
    _yellowController.reset();
    _startAnimations();
  }

  void _checkCollision() {
    const double greenX = 150;
    const double yellowY = 150;

    if ((greenX - yellowX).abs() < 50 && (greenY - yellowY).abs() < 50) {
      _reverseBoth();
    }
  }

  void _reverseBoth() {
    if (_greenController.status == AnimationStatus.forward) {
      _greenController.reverse();
    } else if (_greenController.status == AnimationStatus.reverse) {
      _greenController.forward();
    }

    if (_yellowController.status == AnimationStatus.forward) {
      _yellowController.reverse();
    } else if (_yellowController.status == AnimationStatus.reverse) {
      _yellowController.forward();
    }
  }

  @override
  void dispose() {
    _greenController.dispose();
    _yellowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ball Collision Animation")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              width: 400,
              height: 400,
              child: Stack(
                children: [
                  GreenBall(top: greenY),
                  YellowBall(left: yellowX),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _pauseAnimations,
                icon: const Icon(Icons.pause),
                label: const Text("Pause"),
              ),
              const SizedBox(width: 15),
              ElevatedButton.icon(
                onPressed: _resumeAnimations,
                icon: const Icon(Icons.play_arrow),
                label: const Text("Resume"),
              ),
              const SizedBox(width: 15),
              ElevatedButton.icon(
                onPressed: _restartAnimations,
                icon: const Icon(Icons.replay),
                label: const Text("Restart"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
