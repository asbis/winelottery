import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Player {
  String name;
  int number;
  int numberDevidedByFive;
  Color color;

  Player(this.name, this.number, this.numberDevidedByFive, this.color);
}

class RoundedInputBoxWithAddMinus extends StatefulWidget {
  final double screenWidth;
  final Player player;
  final int index;

  const RoundedInputBoxWithAddMinus(
      {super.key,
      required this.screenWidth,
      required this.player,
      required this.index});
  @override
  State<StatefulWidget> createState() {
    return _RoundedInputBoxWithAddMinusState();
  }
}

class _RoundedInputBoxWithAddMinusState
    extends State<RoundedInputBoxWithAddMinus> {
  void _decrementerCountner(int index) {
    setState(() {
      widget.player.number--;
    });
  }

  void _incrementCounter(int index) {
    setState(() {
      widget.player.number++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB((widget.screenWidth / 4), 5,
          (widget.screenWidth / 4), 5), //EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: widget.player.color,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: widget.player.color.withOpacity(0.2),
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
              child: const TextField(
                style: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.white,
                  fontSize: 20,
                ),
                decoration: InputDecoration(
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
                onTap: () => _decrementerCountner(widget.index),
                child: const Icon(Icons.remove, color: Colors.white),
              )),
          Container(
            padding: const EdgeInsets.all(5),
            width: 50,
            height: 50,
            color: Colors.transparent,
            child: Text(
              widget.player.number.toString(),
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
                onTap: () => _incrementCounter(widget.index),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
