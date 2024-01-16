import 'package:flutter/material.dart';

import 'colors.dart';

abstract class AppBoxDecoration {
  static TextStyle getButtonTextStyle() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle textColor() {
    return const TextStyle(
      color: AppColors.yellow,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }
}
