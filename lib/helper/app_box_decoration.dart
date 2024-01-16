import 'package:flutter/material.dart';

abstract class AppBoxDecoration {
  static BoxDecoration getBoxDecoration() {
    return const BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Color(0xffdfff57),
          blurRadius: 20,
          offset: Offset(0, 0),
        ),
      ],
      border: Border.fromBorderSide(BorderSide(color: Colors.black, width: 2)),
      color: Color(0xffdfff57),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    );
  }

  static ButtonStyle getElevatedButton() {
    return ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      backgroundColor: Colors.black,
      foregroundColor: const Color(0xffdfff57),
    );
  }
}
