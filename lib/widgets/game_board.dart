import 'package:flutter/material.dart';
import '../models/game_logic.dart';

class GameBoardWidget extends StatelessWidget {
  final GameLogic gameLogic;
  final Function(int) onColumnTapped;

  const GameBoardWidget({
    super.key,
    required this.gameLogic,
    required this.onColumnTapped,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: GameLogic.columns / GameLogic.rows,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.blue[700],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            GameLogic.columns,
            (colIndex) => Expanded(
              child: GestureDetector(
                onTap: () => onColumnTapped(colIndex),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    GameLogic.rows,
                    (rowIndex) => Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _getPieceColor(gameLogic.board[colIndex][rowIndex]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getPieceColor(Player player) {
    switch (player) {
      case Player.red:
        return Colors.red;
      case Player.yellow:
        return Colors.yellow;
      case Player.none:
        return Colors.white;
    }
  }
}
