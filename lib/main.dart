import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(const BatteryApp());
}

class BatteryApp extends StatefulWidget {
  const BatteryApp({super.key});

  @override
  State<BatteryApp> createState() => _BatteryAppState();
}

class _BatteryAppState extends State<BatteryApp> {
  double position = 1;

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(milliseconds: 20), (timer) {
      setState(() {
        if (position < 2) {
          position += 0.01;
        } else {
          position = 0.9;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: BatteryProgress(position),
          ),
        ),
      ),
    );
  }
}

class BatteryProgress extends CustomPainter {
  BatteryProgress(this.position);

  final double position;

  @override
  void paint(Canvas canvas, Size size) {
    double opacity = 1.0;

    if (position > 1) {
      opacity = 1.0 - (position - 1.0);

      if (opacity < 0) {
        opacity = 0;
      }
    }

    final paint = Paint()
      ..color = Colors.teal.withOpacity(opacity)
      ..filterQuality = FilterQuality.low;

    for (int a = 1; a <= 100; a++) {
      final path = Path();
      path.addOval(
        Rect.fromCircle(
          center: Offset(
            size.width / position,
            size.height / position,
          ),
          radius: 30 - position * 10,
        ),
      );

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_) => true;
}
