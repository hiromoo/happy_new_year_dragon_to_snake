import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '年越し',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const int _rowCount = 3;
  static const int _columnCount = 3;
  static const String _dragonImageUrl =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEha5wpu5v4qbr6eK6hypAd3LiuXjCaO_JAU3Ts7g49lhqTLBXD0l6d7n1sXgicDD5-v7eIx3owuJ0ahyKcnR9SfM878pL-Uw5QLCm5nkqgCPHgExhbqfzl00JU4Z7EoT-gd5Oo1c8v-ujAhaF3jZvOZtdUG8hSLXOnwpn8HI4cGk56HKpt2vvU9gcCOkfxX/s929/eto_tatsu_banzai.png';
  static const String _snakeImageUrl =
      'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEib_aNImB4YeHc74m6gzwDrVWWWWQG5fBmB_pP_Q1yq1GMuM9vyEJMB7dyCQT-UxQYfw986zxut2N3HewrDOuBw4XM5E45nV_-zSSAqsJ4AG6EEUV7jesvxb-LoBXywW9Yhxx5JkSs2Ttg/s800/hebi.png';

  final _confettiController = ConfettiController(
    duration: const Duration(seconds: 3),
  );

  final List<bool> _isSnakeList =
      List.generate(_rowCount * _columnCount, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('年を越そう！'),
      ),
      body: Column(
        children: [
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirection: pi / 2,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Table(
                  children: [
                    for (var i = 0; i < _rowCount; i++)
                      TableRow(
                        children: [
                          for (var j = 0; j < _columnCount; j++)
                            TableCell(
                              child: SizedBox(
                                width: 160,
                                height: 160,
                                child: IconButton(
                                  onPressed: () {
                                    _onIconButtonPressed(i * _columnCount + j);
                                  },
                                  icon: Image.network(
                                    _isSnakeList[i * _columnCount + j]
                                        ? _snakeImageUrl
                                        : _dragonImageUrl,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onIconButtonPressed(int index) {
    _isSnakeList[index] = true;
    if (_isSnakeList.reduce((value, element) => value && element)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('明けましておめでとうございます🎍'),
            content: const Text('2025年は巳年です🐍\n良いお年をお過ごしください！'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('閉じる'),
              ),
            ],
          );
        },
      );
      _confettiController.play();
    }
    setState(() {});
  }
}
