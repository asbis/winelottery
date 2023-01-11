import 'package:flutter/material.dart';
import 'package:winwine/lotterywheel/page.dart';
import 'package:winwine/main_menu/page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Vinlotteri🍾🍷',
        home: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 1000) {
              return const LotteryPage();
            } else {
              return const MainMenu();
            }
          },
        ));
  }
}
