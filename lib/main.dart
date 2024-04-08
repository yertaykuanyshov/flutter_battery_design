import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_battery_design/point.dart';

void main() {
  runApp(const BatteryApp());
}

class BatteryApp extends StatefulWidget {
  const BatteryApp({super.key});

  @override
  State<BatteryApp> createState() => _BatteryAppState();
}

class _BatteryAppState extends State<BatteryApp> {
  final StreamController<int> _controller = StreamController();

  double _position = 1;

  @override
  void initState() {
    super.initState();

    _controller.sink.add(1);

    Timer.periodic(const Duration(microseconds: 1000000), (timer) {
      setState(() {
        if (_position < 2) {
          _position += (2 / 100);
        } else {
          _position = 1;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: BatteryProgress([
              BatteryPoint(
                radius: 10,
                timer: _position,
                position: BatteryPointPosition.top,
              ),
              BatteryPoint(
                radius: 50,
                timer: _position,
                position: BatteryPointPosition.bottom,
              ),
              BatteryPoint(
                radius: 20,
                timer: _position,
                position: BatteryPointPosition.right,
              ),
              BatteryPoint(
                radius: 30,
                timer: _position,
                position: BatteryPointPosition.left,
              ),
              BatteryPoint(
                radius: 30,
                timer: _position,
                position: BatteryPointPosition.bottomLeft,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class BatteryProgress extends CustomPainter {
  BatteryProgress(this.points);

  final List<BatteryPoint> points;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.teal;

    final path = Path();

    for (BatteryPoint point in points) {
      final percent = (point.timer - 1) * 100;
      final radius = point.radius - (point.radius / 100) * percent;

      if (point.position == BatteryPointPosition.left) {
        final width = size.width - size.width - 50;
        final centerOffset = size.width / 2 + 50;

        final offset = width + (centerOffset / 100) * percent.toInt();

        path.addOval(Rect.fromCircle(
          center: Offset(offset, size.height / 2),
          radius: radius,
        ));
      }

      if (point.position == BatteryPointPosition.bottom) {
        path.addOval(Rect.fromCircle(
          center: Offset(
            size.width / 2,
            size.height / point.timer,
          ),
          radius: radius,
        ));
      }

      if (point.position == BatteryPointPosition.right) {
        path.addOval(Rect.fromCircle(
          center: Offset(
            size.width / point.timer,
            size.height / 2,
          ),
          radius: radius,
        ));
      }

      if (point.position == BatteryPointPosition.bottomLeft) {
        path.addOval(Rect.fromCircle(
          center: Offset(
            size.width / point.timer,
            size.height / point.timer,
          ),
          radius: radius,
        ));
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(oldDelegate) => true;
}
