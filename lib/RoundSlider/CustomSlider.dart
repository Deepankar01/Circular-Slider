import 'package:flutter/material.dart';

import '../pallete.dart';
import 'RoundSliderThumbShapeWithShadow.dart';
import 'RoundSliderTrackShape.dart';

class CustomSlider extends StatelessWidget {
  final Slider sliderWidget;
  CustomSlider({this.sliderWidget});
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTickMarkColor: ThemeColors.mc_k_electric_blue,
        inactiveTickMarkColor:
            ThemeColors.slider_inactive_colour,
        activeTrackColor: ThemeColors.mc_k_electric_blue,
        inactiveTrackColor: ThemeColors.slider_inactive_colour.withOpacity(0.8),
        thumbColor: ThemeColors.speedo_tick,
        trackShape: RoundSliderTrackShape(),
        trackHeight: 8,
        thumbShape: RoundSliderThumbShapeWithShadow(
          enabledThumbRadius: 18,
          borderColor: ThemeColors.slider_thumb_border,
        ),
      ),
      child: this.sliderWidget,
    );
  }
}
