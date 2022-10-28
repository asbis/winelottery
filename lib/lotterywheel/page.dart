import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:winwine/widgets.dart';

class LotteryPage extends StatefulWidget {
  const LotteryPage({super.key});

  @override
  State<LotteryPage> createState() => _LotteryPageState();
}

class _LotteryPageState extends State<LotteryPage> {
  StreamController<int> selected = StreamController<int>();
  StreamController<int> selected2 = StreamController<int>();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final ScrollController _controller = ScrollController();
  late ConfettiController _controllerTopCenter;
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
    Colors.teal,
    Colors.amber.shade200,
    Colors.blue.shade200,
    Colors.red.shade200,
    Colors.yellow.shade200,
    Colors.brown.shade200,
    Colors.blueGrey.shade200,
    Colors.redAccent.shade200,
    Colors.pink.shade200
  ];

  @override
  void initState() {
    super.initState();
    players = [Player("", 2, _randomColor())];
    _controllerTopCenter =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _controllerTopCenter.dispose();
    super.dispose();
  }

  Widget lykkehjul() {
    return FortuneWheel(
      selected: selected.stream,
      duration: const Duration(seconds: 10),
      items: [
        for (var i = 0; i < players.length; i++)
          for (var k = 0; k < players[i].number; k++)
            FortuneItem(
                style: FortuneItemStyle(
                    color: players[i].color, borderColor: players[i].color),
                child: Text(players[i].name,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))),
      ],
    );
  }

  Widget lykkebar() {
    return FortuneBar(
      selected: selected2.stream,
      duration: const Duration(seconds: 10),
      items: [
        for (var i = 0; i < players.length; i++)
          for (var k = 0; k < players[i].number; k++)
            FortuneItem(
                style: FortuneItemStyle(
                    color: Colors.black, borderColor: players[i].color),
                child: Text(players[i].name,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black))),
      ],
    );
  }

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
  }

  int sumAllPlayersTicket() {
    int sum = 0;
    for (var i = 0; i < players.length; i++) {
      sum += players[i].number;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vinlotteri',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ),
      body: Container(
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
        child: Column(
          children: [
            confetti(),
            lykkebar(),
            Expanded(
              child: Row(
                children: [
                  Expanded(flex: 3, child: lykkehjul()),
                  Expanded(flex: 2, child: listOfPlayers()),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => spinWheel(),
            tooltip: 'Increment',
            child: const Text(
              "SPIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ), //Icon(Icons.add),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: _incrementPlayer,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Align confetti() {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: _controllerTopCenter,
        blastDirectionality: BlastDirectionality.explosive,
        blastDirection: pi / 2,
        emissionFrequency: 0.05,
        numberOfParticles: 10,
        gravity: 0.05,
      ),
    );
  }

  Container roundedInputBoxWithAddMinus(Player player, int index) {
    return Container(
      margin: const EdgeInsets.all(5),
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
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 10), //all(10),
      width: 520,
      height: 75,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: TextButton(
              onPressed: () => _decrementPlayer(index),
              child: const Icon(
                Icons.remove_circle_outline_rounded,
                color: Colors.black45,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 8,
            child: Container(
              height: 50,
              color: Colors.transparent,
              child: TextField(
                onChanged: (value) => {
                  setState(() {
                    players[index].name = value;
                  })
                },
                style: const TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.white,
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 5,
                        color: Colors.white,
                        style: BorderStyle.solid),
                  ),
                  labelText: 'Name',
                ),
              ),
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
              players[index].number.toString(),
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

  Container roundedInputBoxWithAddMinus2(int index) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: players[index].color,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: players[index].color.withOpacity(0.2),
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
            flex: 1,
            child: TextButton(
              onPressed: () => _decrementPlayer(index),
              child: const Icon(
                Icons.remove_circle_outline_rounded,
                color: Colors.black45,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 50,
              color: Colors.transparent,
              child: TextField(
                onChanged: (value) => {
                  setState(() {
                    players[index].name = value;
                  })
                },
                style: const TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.white,
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 5,
                        color: Colors.white,
                        style: BorderStyle.solid),
                  ),
                  labelText: 'Name',
                ),
              ),
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
              players[index].number.toString(),
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

  void spinWheel() {
    setState(() {
      var randomNr = Fortune.randomInt(0, sumAllPlayersTicket());
      selected.add(randomNr);
      selected2.add(randomNr);
    });
    Timer(const Duration(seconds: 9), () => _controllerTopCenter.play());
  }

  void _decrementerCountner(int index) {
    setState(() {
      if (sumAllPlayersTicket() <= 2) {
        return;
      }
      players[index].number--;
    });
  }

  void _incrementCounter(int index) {
    setState(() {
      if (sumAllPlayersTicket() < 2) {
        players[index].number = 2;
      } else {
        players[index].number++;
      }
    });
  }

  void _incrementPlayer() {
    players.add(Player("", 0, _randomColor()));
    _listKey.currentState?.insertItem(players.length - 1);
    Timer(const Duration(milliseconds: 100), () => _scrollDown());
  }

  Color _randomColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)]
        [Random().nextInt(9) * 100]!;
  }

  Widget listOfPlayers() {
    return AnimatedList(
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
            child: roundedInputBoxWithAddMinus(players[index], index));
      },
    );
  }

  void _decrementPlayer(int index) {
    if ((sumAllPlayersTicket() - players[index].number) < 2) {
      return;
    }
    Player player = players[index];
    if (index == players.length - 1) {
      Timer(const Duration(milliseconds: 100), () => players.removeAt(index));
    } else {
      players.removeAt(index);
    }
    Timer(
        const Duration(milliseconds: 20),
        () => (_listKey.currentState?.removeItem(
            index,
            (context, animation) => SlideTransition(
                position: CurvedAnimation(
                  curve: Curves.easeIn,
                  parent: animation,
                ).drive((Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: const Offset(0, 0),
                ))),
                child: roundedInputBoxWithAddMinus(player, index)))));
  }
}
