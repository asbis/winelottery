import 'dart:async';

import 'package:flutter/material.dart';
import 'package:winwine/lotterywheel/page.dart';
import 'package:winwine/widgets.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final _listItems = <Widget>[];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    players = [Player("", 0, 0, itemColors.first)];
  }

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
  }

  List<Player> players = [];

  List<Color> itemColors = [
    Colors.amber,
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.brown,
    Colors.blueGrey,
    Colors.redAccent,
    Colors.pink,
    Colors.amber,
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.brown,
    Colors.blueGrey,
    Colors.redAccent,
    Colors.pink
  ];

  void _incrementPlayer() {
    players.add(Player("", 0, 0, itemColors[players.length]));
    _listKey.currentState?.insertItem(players.length - 1);
    Timer(const Duration(milliseconds: 100), () => _scrollDown());
  }

/*
  void _decrementerCountner(int index) {
    setState(() {
      players[index].number--;
    });
  }

  void _incrementCounter(int index) {
    setState(() {
      players[index].number++;
    });
  }
*/
  void pushedStart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LotteryPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _build(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementPlayer,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('Vinlotteri'),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            pushedStart();
          },
          child: const Text(
            "Start",
            style: TextStyle(fontSize: 25),
          ),
        ),
        const SizedBox(
          width: 50,
        )
      ],
    );
  }

  Container _build() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 25, 178, 238),
            Color.fromARGB(255, 21, 236, 229)
          ],
        ),
      ),
      child: AnimatedList(
        controller: _controller,
        key: _listKey,
        padding: const EdgeInsets.only(top: 10),
        initialItemCount: players.length,
        itemBuilder: (context, index, animation) {
          return SlideTransition(
              position: CurvedAnimation(
                curve: Curves.easeOut,
                parent: animation,
              ).drive((Tween<Offset>(
                begin: const Offset(1, 0),
                end: const Offset(0, 0),
              ))),
              child: RoundedInputBoxWithAddMinus(
                  index: index,
                  player: players[index],
                  screenWidth: MediaQuery.of(context).size.width));
        },
      ),
    );
  }
/*
  TextField inputBoks() {
    return const TextField(
      style: TextStyle(
        color: Colors.white,
        decorationColor: Colors.white,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(
              width: 5, color: Colors.white, style: BorderStyle.solid),
        ), // OutlineInputBorder( borderSide: BorderSide(color: Colors.white)),
        labelText: 'Name',
      ),
    );
  }
  */
/*
  Container roundedInputBoxWithAddMinus2(Player player, int index) {
    double screenWidth = MediaQuery.of(context).size.width;
    double paddingWidth = screenWidth / 4;
    if (screenWidth < 700) {
      paddingWidth = 5;
    }
    return Container(
      margin: EdgeInsets.fromLTRB(
          paddingWidth, 5, paddingWidth, 5), //EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: player.color,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: player.color.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      width: 520,
      height: 75,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              color: Colors.transparent,
              child: inputBoks(),
            ),
          ),
          Container(
              width: 50,
              height: 50,
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _decrementerCountner(index),
                child: const Icon(Icons.remove, color: Colors.white),
              )),
          Container(
            padding: const EdgeInsets.all(5),
            width: 50,
            height: 50,
            color: Colors.transparent,
            child: Text(
              player.number.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 35,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
              width: 50,
              height: 50,
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _incrementCounter(index),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
    
  }
  */
}
/*
class Player {
  String name;
  int number;
  Color color;

  Player(this.name, this.number, this.color);
}
*/