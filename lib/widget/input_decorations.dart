import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration loginInputDecoration({
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.purple,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Colors.purple,
        ),
      ),
      labelStyle: TextStyle(color: Colors.grey),
      labelText: labelText,
      prefixIcon: (prefixIcon != null)
          ? Icon(
              prefixIcon,
              color: Colors.purple,
            )
          : null,
    );
  }
}
