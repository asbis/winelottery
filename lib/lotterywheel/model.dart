import 'package:flutter/material.dart';

class LotteryPageModel {}

class TextController extends TextEditingController {
  TextController({required String text}) {
    this.text = text;
  }

  set text(String newText) {
    value = value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
        composing: TextRange.empty);
  }
}
