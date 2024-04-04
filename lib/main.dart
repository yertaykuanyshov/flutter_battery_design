import 'dart:async';
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

    Timer.periodic(const Duration(milliseconds: 16), (timer) {
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
    final paint = Paint()
      ..color = Colors.red
      ..filterQuality = FilterQuality.low;

    final path = Path();

    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width / position, size.height / position),
        radius: 30 - position * 15,
      ),
    );

    var position2 = position - 0.5;

    path.addOval(
      Rect.fromCircle(
        center: Offset(
            (size.width / position2) + 10, (size.height / position2) + 10),
        radius: 30 - position2 * 15,
      ),
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => true;
}
