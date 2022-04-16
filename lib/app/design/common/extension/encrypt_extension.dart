import 'dart:ui';
import 'package:flutter/material.dart';

extension EncryptExtension on String {
  String get toIVString {
    return codeUnitAt(lerpDouble(0, length, 0.5)?.floor() ?? 0).toString();
  }

  String get to32Length {
    int need = 0;
    String comp = '';
    String str = this;
    if (str.length != 32) {
      need = 32 - str.length;
      if (need > 0) {
        comp = str.substring(0, need);
        comp = comp.characters.toList().reversed.join();
        str += comp;
      } else if (need < 0) {
        comp = str.substring(0, 32);
        comp = comp.characters.toList().reversed.join();
        str = comp;
      }
    }
    return str;
  }
}
