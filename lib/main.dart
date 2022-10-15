import 'package:flutter/material.dart';
import 'package:winwine/lotterywheel/page.dart';
import 'package:winwine/main_menu/page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Vinlotteri🍾🍷',
      home: LotteryPage(),
    );
  }
}
