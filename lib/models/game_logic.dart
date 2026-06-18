enum Player { none, red, yellow }

class GameLogic {
  static const int columns = 7;
  static const int rows = 6;
  
  List<List<Player>> board;
  Player currentPlayer;
  Player? winner;
  bool isDraw;

  GameLogic()
      : board = List.generate(columns, (_) => List.filled(rows, Player.none)),
        currentPlayer = Player.red,
        winner = null,
        isDraw = false;

  void reset() {
    board = List.generate(columns, (_) => List.filled(rows, Player.none));
    currentPlayer = Player.red;
    winner = null;
    isDraw = false;
  }

  bool dropPiece(int col) {
    if (winner != null || isDraw || col < 0 || col >= columns) return false;

    // The grid is typically represented with index 0 at the top, rows-1 at the bottom.
    // However, it's easier to think of pieces falling to the highest available y value.
    for (int row = rows - 1; row >= 0; row--) {
      if (board[col][row] == Player.none) {
        board[col][row] = currentPlayer;
        _checkWinCondition(col, row);
        if (winner == null) {
          _checkDrawCondition();
          if (!isDraw) {
            currentPlayer = currentPlayer == Player.red ? Player.yellow : Player.red;
          }
        }
        return true;
      }
    }
    return false; // Column is full
  }

  void _checkWinCondition(int col, int row) {
    if (_countConsecutive(col, row, 1, 0) + _countConsecutive(col, row, -1, 0) >= 3 || // Horizontal
        _countConsecutive(col, row, 0, 1) + _countConsecutive(col, row, 0, -1) >= 3 || // Vertical
        _countConsecutive(col, row, 1, 1) + _countConsecutive(col, row, -1, -1) >= 3 || // Diagonal \
        _countConsecutive(col, row, 1, -1) + _countConsecutive(col, row, -1, 1) >= 3) { // Diagonal /
      winner = currentPlayer;
    }
  }

  int _countConsecutive(int col, int row, int dirX, int dirY) {
    int count = 0;
    int c = col + dirX;
    int r = row + dirY;
    while (c >= 0 && c < columns && r >= 0 && r < rows && board[c][r] == currentPlayer) {
      count++;
      c += dirX;
      r += dirY;
    }
    return count;
  }

  void _checkDrawCondition() {
    for (int col = 0; col < columns; col++) {
      if (board[col][0] == Player.none) return; // Found an empty spot at the top
    }
    isDraw = true;
  }
}
