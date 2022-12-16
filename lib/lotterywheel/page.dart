import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
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
  List<Player> randomPlayers = [];

  int WinnerIndex = 0;

  bool randomPlaced = false;

  @override
  void initState() {
    super.initState();
    players = [Player(0, "", 2, _randomColor())];
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
      items: randomPlaced
          ? randomPlayers
              .map((e) => FortuneItem(
                  style: FortuneItemStyle(
                    color: e.color,
                  ),
                  child: Text(e.name,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))))
              .toList()
          : [
              for (var i = 0; i < players.length; i++)
                for (var k = 0; k < players[i].number; k++)
                  FortuneItem(
                      style: FortuneItemStyle(
                          color: players[i].color,
                          borderColor: players[i].color),
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
      items: randomPlaced
          ? randomPlayers
              .map((e) => FortuneItem(
                  style: FortuneItemStyle(
                    color: e.color,
                  ),
                  child: Text(e.name,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))))
              .toList()
          : [
              for (var i = 0; i < players.length; i++)
                for (var k = 0; k < players[i].number; k++)
                  FortuneItem(
                      style: FortuneItemStyle(
                          color: players[i].color,
                          borderColor: players[i].color),
                      child: Text(players[i].name,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))),
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

  void generateArandomOrderOfPlayers() {
    randomPlayers.clear();
    for (var i = 0; i < players.length; i++) {
      for (var k = 0; k < players[i].number; k++) {
        randomPlayers.add(players[i]);
      }
    }
    randomPlayers.shuffle();
    setState(() {});
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
    double width = MediaQuery.of(context).size.width;
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
              child: width < 1000
                  ? Column(
                      children: [
                        Expanded(flex: 3, child: lykkehjul()),
                        Expanded(flex: 2, child: listOfPlayers()),
                      ],
                    )
                  : Row(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CupertinoSwitch(
                    activeColor: Colors.blueGrey,
                    value: randomPlaced,
                    onChanged: (value) {
                      setState(() {
                        randomPlaced = value;
                        generateArandomOrderOfPlayers();
                      });
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text("Shuffle",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.black54)),
                ),
              ],
            ),
          ),
          Row(
            children: [
              FloatingActionButton(
                onPressed: () => spinWheel(),
                tooltip: 'Spinn hjulet',
                child: const Text(
                  "SPINN",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ), //Icon(Icons.add),
              ),
              const SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                onPressed: _incrementPlayer,
                tooltip: 'Legg til spiller',
                child: const Icon(Icons.add),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
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
      height: 90,
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
          const SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 8,
            child: Container(
              height: 50,
              color: Colors.transparent,
              child: TextField(
                controller: TextController(text: player.name),
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
                  labelText: 'Navn',
                ),
              ),
            ),
          ),
          Container(
              width: 50,
              height: 50,
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _decrementerCountner(index, -1),
                child: const Icon(Icons.remove, color: Colors.white),
              )),
          Container(
            padding: const EdgeInsets.all(5),
            width: 50,
            height: 90,
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  players[index].number.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  "Lodd",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
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
    var randomNr = Fortune.randomInt(0, sumAllPlayersTicket());
    setState(() {
      selected.add(randomNr);
      selected2.add(randomNr);
    });
    Timer(const Duration(seconds: 9), () {
      _controllerTopCenter.play();
      findWinner(randomNr);
    }); //=> ;
  }

  void showPopUpOfWinnder(int RandomNr) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Vinneren er',
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
          content: Text(
              randomPlaced
                  ? randomPlayers[RandomNr].name
                  : players[RandomNr].name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center),
          actions: <Widget>[
            TextButton(
              child: Text('Lukk'),
              onPressed: () {
                setState(() {
                  randomPlaced
                      ? _decrementerCountner(-1, randomPlayers[RandomNr].id)
                      : _decrementerCountner(WinnerIndex, -1);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void findWinner(int randomNr) {
    int counter = 0;
    if (randomPlaced) {
      for (int i = 0; i < randomPlayers.length; i++) {
        if (counter == randomNr) {
          showPopUpOfWinnder(i);
        }
        counter++;
      }
    } else {
      for (var i = 0; i < players.length; i++) {
        for (var k = 0; k < players[i].number; k++) {
          if (counter == randomNr) {
            showPopUpOfWinnder(i);
            setState(() {
              WinnerIndex = i;
            });
            return;
          }
          counter++;
        }
      }
    }
  }

  void _decrementerCountner(int index, int id) {
    if (sumAllPlayersTicket() <= 2) {
      return;
    }
    if (id == -1) {
      setState(() {
        players[index].number--;
        generateArandomOrderOfPlayers();
      });
    } else {
      setState(() {
        int index2 = players.indexWhere((element) => element.id == id);
        players[index2].number--;
        generateArandomOrderOfPlayers();
      });
    }
  }

  void _incrementCounter(int index) {
    setState(() {
      if (sumAllPlayersTicket() < 2) {
        players[index].number = 2;
      } else {
        players[index].number++;
      }
      generateArandomOrderOfPlayers();
    });
  }

  void _incrementPlayer() {
    players.add(Player(players.last.id + 1, "", 0, _randomColor()));
    _listKey.currentState?.insertItem(players.length - 1);
    Timer(const Duration(milliseconds: 100), () => _scrollDown());
    generateArandomOrderOfPlayers();
  }

  Color _randomColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)]
        [Random().nextInt(9) * 100]!;
  }

  Widget listOfPlayers() {
    return AnimatedList(
      controller: _controller,
      key: _listKey,
      padding: const EdgeInsets.only(top: 10, bottom: 100),
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
      generateArandomOrderOfPlayers();
    } else {
      players.removeAt(index);
      generateArandomOrderOfPlayers();
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
