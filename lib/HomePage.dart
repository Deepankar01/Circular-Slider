import 'dart:math';
import 'package:flutter/material.dart';
import 'package:slider_circular/CircularSlider/BasePainter.dart';
import 'package:slider_circular/CircularSlider/IndicatorPainter.dart';

class DialSection {
  double start;
  double sweep;
  Color dialColor;
  String showText;
  DialSection(
      {@required this.start,
      @required this.sweep,
      @required this.dialColor,
      @required this.showText});
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final double boxWidthHeight = 400;
  Offset cursorPosition = Offset(0, boxWidthHeight / 2);

  _onPanDown(DragDownDetails dragDownDetails) {}
  _onPanUpdate(DragUpdateDetails dragUpdateDetails) {
    Offset value = dragUpdateDetails.localPosition;

    print(value.direction * (180 / pi));
    setState(() {
      cursorPosition = dragUpdateDetails.localPosition;
    });
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

  double _getAngle() {
    double angle = 0;
    angle = atan2(200 - cursorPosition.dy, 200 - cursorPosition.dx);
    return angle;
  }

  String _identifySlice() {
    double slice = 1;
    slice = (_getAngle() / 0.628319);
    return pieColors[slice.floor()].showText;
  }

  Widget _buildPie() {
    return GestureDetector(
      onPanDown: _onPanDown,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: CustomPaint(
        painter: BasePainter(dialSections: pieColors),
        child: Container(
          child: CustomPaint(
            painter: IndicatorPainter(rotateAngle: _getAngle()),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(_identifySlice()),
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
          height: boxWidthHeight,
          width: boxWidthHeight,
          child: _buildPie(),
        ),
      ),
    );
  }
}
