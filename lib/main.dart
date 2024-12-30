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
  static const String _dragonImageFilePath = 'asset/eto_tatsu_banzai.png';
  static const String _snakeImageFilePath = 'asset/hebi.png';

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
                                  icon: Image.asset(
                                    _isSnakeList[i * _columnCount + j]
                                        ? _snakeImageFilePath
                                        : _dragonImageFilePath,
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
