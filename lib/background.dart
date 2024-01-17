import 'dart:math';
import 'package:flutter/material.dart';

class ThermometerBackground extends StatelessWidget {
  final double temperature;
  final double maxHeight;

  ThermometerBackground({required this.temperature, required this.maxHeight});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: maxHeight,
      width: 10.0,  // Set a width value
      child: Container(
        constraints: BoxConstraints.expand(height: double.infinity),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: getColorGradient(temperature),
            stops: [0.0, 0.1, 0.2, 0.3, 0.4],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: SizedBox(
          height: maxHeight * getFillPercentage(temperature),
          child: Container(
            height: 200,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

List<Color> getColorGradient(double temperature) {
  if (temperature < 0) {
    return [Colors.blue];
  } else if (temperature <= 10) {
    return [Colors.blue, Colors.green];
  } else if (temperature <= 20) {
    return [Colors.green, Colors.yellow];
  } else if (temperature <= 30) {
    return [Colors.yellow, Colors.orange];
  } else {
    return [Colors.orange, Colors.red];
  }
}


  double getFillPercentage(double temperature) {
    return max(0.0, min(1.0, (temperature + 10) / 40));
  }
}
