import 'package:flutter/material.dart';
import 'models/game_logic.dart';
import 'widgets/game_board.dart';

void main() {
  runApp(const ConnectFourApp());
}

class ConnectFourApp extends StatelessWidget {
  const ConnectFourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connect Four',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ConnectFourScreen(),
    );
  }
}

class ConnectFourScreen extends StatefulWidget {
  const ConnectFourScreen({super.key});

  @override
  State<ConnectFourScreen> createState() => _ConnectFourScreenState();
}

class _ConnectFourScreenState extends State<ConnectFourScreen> {
  final GameLogic _gameLogic = GameLogic();

  void _handleColumnTapped(int colIndex) {
    setState(() {
      _gameLogic.dropPiece(colIndex);
    });
  }

  void _resetGame() {
    setState(() {
      _gameLogic.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    String statusText;
    Color statusColor;
    if (_gameLogic.winner != null) {
      statusText = '${_gameLogic.winner == Player.red ? 'Red' : 'Yellow'} Wins!';
      statusColor = _gameLogic.winner == Player.red ? Colors.red : Colors.yellow.shade800;
    } else if (_gameLogic.isDraw) {
      statusText = 'It\'s a Draw!';
      statusColor = Colors.grey;
    } else {
      statusText = 'Current Turn: ${_gameLogic.currentPlayer == Player.red ? 'Red' : 'Yellow'}';
      statusColor = _gameLogic.currentPlayer == Player.red ? Colors.red : Colors.yellow.shade800;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Connect Four POC'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                statusText,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
              const SizedBox(height: 20),
              Flexible(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: GameBoardWidget(
                    gameLogic: _gameLogic,
                    onColumnTapped: _handleColumnTapped,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetGame,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Restart Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
