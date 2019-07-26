import 'dart:math';
import 'package:flutter/material.dart';

class IndicatorPainter extends CustomPainter {
  final double rotateAngle;
  static double circleWidth = 15;
  IndicatorPainter({@required this.rotateAngle});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Color(0xff3f3f3f)
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(size.width / 2 - circleWidth, (size.height / 2)),
        Offset(size.width / 4, (size.height / 2)), paint);
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), circleWidth, paint);
    canvas.save();
    canvas.rotate(rotateAngle);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
