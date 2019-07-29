import 'package:flutter/material.dart';

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
