class Rook extends Piece {
  Rook(String _c, String _path) {
    super(_c, "rook", _path);
  }
  
  Rook(Piece _piece) {
    super(_piece);
  }
  
  void calculatePossibleMoves(Board board, int x, int y) {
    this.possibleMoves.clear();
    
    // Left
    int i = 1;
    while (x-i >= 0) {
      if (board.getSlot(x-i, y).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x-i, y), 1);
      }
      else {
        if (!board.getSlot(x-i, y).getPiece().getTeam().equals(this.team)) {
          this.possibleMoves.put(new MoveEvent(this, x, y, x-i, y, board.getSlot(x-i, y).getPiece()), 1);
        }
        break;
      }
      i++;
    }
    
    // Right
    i = 1;
    while (x+i < board.getColumns()) {
      if (board.getSlot(x+i, y).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x+i, y), 1);
      }
      else {
        if (!board.getSlot(x+i, y).getPiece().getTeam().equals(this.team)) {
          this.possibleMoves.put(new MoveEvent(this, x, y, x+i, y, board.getSlot(x+i, y).getPiece()), 1);
        }
        break;
      }
      i++;
    }
    
    // Up
    i = 1;
    while (y-i >= 0) {
      if (board.getSlot(x, y-i).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x, y-i), 1);
      }
      else {
        if (!board.getSlot(x, y-i).getPiece().getTeam().equals(this.team)) {
          this.possibleMoves.put(new MoveEvent(this, x, y, x, y-i, board.getSlot(x, y-i).getPiece()), 1);
        }
        break;
      }
      i++;
    }
    
    // Down
    i = 1;
    while (y+i < board.getRows()) {
      if (board.getSlot(x, y+i).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x, y+i), 1);
      }
      else {
        if (!board.getSlot(x, y+i).getPiece().getTeam().equals(this.team)) {
          this.possibleMoves.put(new MoveEvent(this, x, y, x, y+i, board.getSlot(x, y+i).getPiece()), 1);
        }
        break;
      }
      i++;
    }
    
  }
}
