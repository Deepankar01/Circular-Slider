import 'package:flutter/material.dart';

class RoundSliderThumbShapeWithShadow extends SliderComponentShape {
  /// Create a slider thumb that draws a circle.
  const RoundSliderThumbShapeWithShadow(
      {this.enabledThumbRadius = 10.0,
      this.disabledThumbRadius,
      this.borderColor,
      this.shadowColor = const Color(0xff000000),
      this.shadowElevation = 3.0,
      this.borderWidth = 1});

  /// The preferred radius of the round thumb shape when the slider is enabled.
  ///
  /// If it is not provided, then the material default of 10 is used.
  final double enabledThumbRadius;
  final Color borderColor;
  final double borderWidth;
  final Color shadowColor;
  final double shadowElevation;

  /// The preferred radius of the round thumb shape when the slider is disabled.
  ///
  /// If no disabledRadius is provided, then it is equal to the
  /// [enabledThumbRadius]
  final double disabledThumbRadius;
  double get _disabledThumbRadius => disabledThumbRadius ?? enabledThumbRadius;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(
        isEnabled == true ? enabledThumbRadius : _disabledThumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double> activationAnimation,
    @required Animation<double> enableAnimation,
    bool isDiscrete,
    TextPainter labelPainter,
    RenderBox parentBox,
    @required SliderThemeData sliderTheme,
    TextDirection textDirection,
    double value,
  }) {
    assert(context != null);
    assert(center != null);
    assert(enableAnimation != null);
    assert(sliderTheme != null);
    assert(sliderTheme.disabledThumbColor != null);
    assert(sliderTheme.thumbColor != null);

    final Canvas canvas = context.canvas;

    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );

    final borderStroke = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()..color = colorTween.evaluate(enableAnimation);

    Path path = Path();
    Rect pathCircle =
        new Rect.fromCircle(center: center, radius: enabledThumbRadius);
    path.addOval(pathCircle);
    canvas.drawShadow(path, shadowColor, shadowElevation, false);
    canvas.drawPath(path, borderStroke);
    canvas.drawPath(path, fillPaint);
    // canvas.drawCircle(
    //   Offset(
    //     center.dx + 1,
    //     center.dy + 2,
    //   ),
    //   radiusTweenShadow.evaluate(enableAnimation),
    //   fillColor,
    // );
    // canvas.drawCircle(
    //   center,
    //   radiusTween.evaluate(enableAnimation),
    //   fillPaint,
    // );
    // canvas.drawCircle(
    //   center,
    //   radiusTween.evaluate(enableAnimation),
    //   borderStroke,
    // );
  }
}
