import 'dart:math';
import 'package:flutter/material.dart';
import 'BasePainter.dart';
import 'IndicatorPainter.dart';
import 'DialSection.dart';

class CircularSlider extends StatefulWidget {
  CircularSlider({Key key, this.sections}) : super(key: key);

  final List<DialSection> sections;

  @override
  _CircularSliderState createState() => _CircularSliderState();
}

class _CircularSliderState extends State<CircularSlider> {
  static final double boxWidthHeight = 400;
  double angle = 0;
  bool isFirst = true;
  Offset cursorPosition = Offset(0, boxWidthHeight / 2);

  _identifyAndSetAngle(Offset localPosition) {
    double _calculatedAngle = _getAngle(localPosition);
    if (_calculatedAngle > 0) {
      setState(() {
        cursorPosition = localPosition;
        angle = _calculatedAngle;
      });
    }
  }

  _onPanUpdate(DragUpdateDetails dragUpdateDetails) {
    if (isFirst) {
      setState(() {
        isFirst = false;
      });
    }
    _identifyAndSetAngle(dragUpdateDetails.localPosition);
  }

  _onTapUp(TapUpDetails tapUpDetails) {
    if (isFirst) {
      setState(() {
        isFirst = false;
      });
    }
    _identifyAndSetAngle(tapUpDetails.localPosition);
  }

  double _getAngle(Offset position) {
    double angle = 0;
    angle = atan2(
        boxWidthHeight / 2 - position.dy, boxWidthHeight / 2 - position.dx);
    return angle;
  }

  int _identifySliceIndex() {
    double slice = 1;
    slice = (angle / 0.628319);
    return slice.floor();
  }

  Widget _buildPie() {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onTapUp: _onTapUp,
      child: CustomPaint(
        painter: BasePainter(
            dialSections: widget.sections,
            currentSliceIndex: this.isFirst ? -1 : _identifySliceIndex()),
        child: Container(
          child: CustomPaint(
            painter: IndicatorPainter(rotateAngle: angle),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                this.isFirst
                    ? ''
                    : widget.sections[_identifySliceIndex()].showText
                        .toUpperCase(),
                style: TextStyle(
                    color: Color(0xff009bd9),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 300,
        width: boxWidthHeight,
        child: _buildPie(),
      ),
    ));
  }
}
