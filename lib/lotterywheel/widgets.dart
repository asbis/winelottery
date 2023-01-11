import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

class WinnerPopup extends StatefulWidget {
  final String winner;

  WinnerPopup({super.key, required this.winner});

  @override
  _WinnerPopupState createState() => _WinnerPopupState();
}

class _WinnerPopupState extends State<WinnerPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConfettiWidget(
            confettiController: ConfettiController(
              duration: const Duration(seconds: 10),
            ),
            blastDirectionality: BlastDirectionality.explosive,
            numberOfParticles: 200,
            gravity: 0.9,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Congratulations ${widget.winner}!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
