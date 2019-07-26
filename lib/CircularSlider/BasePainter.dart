import 'dart:math';

import 'package:flutter/material.dart';
import 'package:slider_circular/HomePage.dart';

class BasePainter extends CustomPainter {
  final List<DialSection> dialSections;
  final int currentSliceIndex;
  BasePainter({@required this.dialSections, @required this.currentSliceIndex});

  _drawArc(Paint paint, Size size, Canvas canvas, DialSection dialSection) {
    Rect rect = new Rect.fromCircle(
        center: Offset(size.width / 2, size.width / 2), radius: size.width / 2);
    canvas.drawArc(rect, dialSection.start, dialSection.sweep, true, paint);
  }

  _drawOveraly(Paint paint, Size size, Canvas canvas, DialSection dialSection) {
    Rect rect = new Rect.fromCircle(
        center: Offset(size.width / 2, size.width / 2),
        radius: size.width / 2.3);
    canvas.drawArc(rect, dialSection.start, dialSection.sweep, true, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    dialSections.asMap().forEach((int index, DialSection dialSection) {
      Paint paint = Paint()
        ..color = currentSliceIndex >= index
            ? dialSection.dialColor
            : dialSection.inactiveColor
        ..style = PaintingStyle.fill;
      _drawArc(paint, size, canvas, dialSection);
    });
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    _drawOveraly(
        paint,
        size,
        canvas,
        DialSection(
            dialColor: Colors.white, start: 0, sweep: -pi, showText: ''));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
