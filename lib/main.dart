import 'dart:math';

import 'package:flutter/material.dart';

import 'CircularSlider/CircularSlider.dart';
import 'CircularSlider/DialSection.dart';

void main() => runApp(MyApp());

final sections = [
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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData(primarySwatch: Colors.blue, backgroundColor: Colors.white),
      home: CircularSlider(
        sections: sections,
      ),
    );
  }
}
