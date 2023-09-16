import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Analog Clock'),
        ),
        body: const Center(
          child: Clock(),
        ),
      ),
    );
  }
}

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  ClockState createState() => ClockState();
}

class ClockState extends State<Clock> {
  DateTime _currentTime = DateTime.now();
  Timer? _timer;
  final double clockSize = 200.0;

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTime() {
    _currentTime = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: clockSize,
      height: clockSize,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 10.0,
            spreadRadius: 6.0,
            color: Colors.black.withOpacity(0.2),
          )
        ],
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.8), width: 2.0),
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              top: 10.0,
              bottom: 10.0,
              left: 0.0,
              right: 0.0,
              child: Center(
                child: Transform.rotate(
                  angle: _currentTime.second * 0.10472,
                  child: SizedBox(
                    width: 2.0,
                    height: constraints.maxHeight,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.red,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.red,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.transparent,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20.0,
              bottom: 20.0,
              left: 0.0,
              right: 0.0,
              child: Center(
                child: Transform.rotate(
                  angle: _currentTime.minute * 0.10472,
                  child: SizedBox(
                    width: 2.0,
                    height: constraints.maxHeight,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50.0,
              bottom: 50.0,
              left: 0.0,
              right: 0.0,
              child: Center(
                child: Transform.rotate(
                  angle: (_currentTime.hour + (_currentTime.minute / 60)) *
                      0.523599,
                  child: SizedBox(
                    width: 6.0,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              child: Center(
                child: CustomPaint(
                  painter: CircularNumbersPainter(12, 84),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class CircularNumbersPainter extends CustomPainter {
  final int numberOfNumbers;
  final double radius;

  CircularNumbersPainter(this.numberOfNumbers, this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final angleStep = 2 * pi / numberOfNumbers;

    for (int i = 0; i < numberOfNumbers; i++) {
      final angle = (i - 2) * angleStep;
      final textPainter = TextPainter(
        text: TextSpan(
          text: (i + 1).toString(),
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      final textX = centerX + radius * cos(angle) - textPainter.width / 2;
      final textY = centerY + radius * sin(angle) - textPainter.height / 2;

      textPainter.paint(canvas, Offset(textX, textY));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CircularDotsPainter extends CustomPainter {
  final int numberOfNumbers;
  final double radius;

  CircularDotsPainter(this.numberOfNumbers, this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final angleStep = 2 * pi / numberOfNumbers;

    for (int i = 0; i < numberOfNumbers; i++) {
      final angle = i * angleStep;
      final textPainter = TextPainter(
        text: const TextSpan(
          text: ".",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();
      final textX = centerX + radius * cos(angle) - textPainter.width / 2;
      final textY = centerY + radius * sin(angle) - textPainter.height / 2;

      textPainter.paint(canvas, Offset(textX, textY));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
