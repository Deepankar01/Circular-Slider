import 'dart:math';
import 'package:flutter/material.dart';
import 'package:slider_circular/CircularSlider/BasePainter.dart';
import 'package:slider_circular/CircularSlider/IndicatorPainter.dart';

class DialSection {
  double start;
  double sweep;
  Color dialColor;
  String showText;
  Color inactiveColor;
  DialSection(
      {@required this.start,
      @required this.sweep,
      @required this.dialColor,
      @required this.showText,
      this.inactiveColor = const Color(0xffe4e4e4)});
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final double boxWidthHeight = 400;
  double angle = 0;
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

  _onPanDown(DragDownDetails dragDownDetails) {}
  _onPanUpdate(DragUpdateDetails dragUpdateDetails) {
    _identifyAndSetAngle(dragUpdateDetails.localPosition);
  }

  _onTapUp(TapUpDetails tapUpDetails) {
    _identifyAndSetAngle(tapUpDetails.localPosition);
  }

  _onPanEnd(DragEndDetails dragEndDetails) {}

  final pieColors = [
    DialSection(
        dialColor: new Color(0xff005176),
        sweep: (pi / 5),
        start: pi,
        showText: 'Almost Never'),
    DialSection(
        dialColor: new Color(0xff007eb1),
        sweep: (pi / 5),
        start: 4 * (-pi / 5),
        showText: 'Seldom'),
    DialSection(
        dialColor: new Color(0xff009bd9),
        sweep: (pi / 5),
        start: 3 * (-pi / 5),
        showText: 'Sometimes'),
    DialSection(
        dialColor: new Color(0xff00bedb),
        sweep: (pi / 5),
        start: 2 * (-pi / 5),
        showText: 'Often'),
    DialSection(
        dialColor: new Color(0xff4fc9f0),
        sweep: (pi / 5),
        start: (-pi / 5),
        showText: 'Almost always'),
  ];

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
      onPanDown: _onPanDown,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      onTapUp: _onTapUp,
      child: CustomPaint(
        painter: BasePainter(
            dialSections: pieColors, currentSliceIndex: _identifySliceIndex()),
        child: Container(
          child: CustomPaint(
            painter: IndicatorPainter(rotateAngle: angle),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(pieColors[_identifySliceIndex()].showText),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SizedBox(
          height: 300,
          width: boxWidthHeight,
          child: _buildPie(),
        ),
      ),
    );
  }
}
