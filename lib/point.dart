class BatteryPoint {
  BatteryPoint({
    required this.radius,
    required this.position,
    required this.timer,
  });

  final int radius;
  final double timer;

  final BatteryPointPosition position;
}

enum BatteryPointPosition {
  top,
  left,
  right,
  bottom,
  bottomLeft,
}
