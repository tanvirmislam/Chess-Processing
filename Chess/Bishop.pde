class Bishop extends Piece {
  Bishop(String _c, String _path) {
    super(_c, "bishop", _path);
  }
  
  Bishop(Piece _piece) {
    super(_piece);
  }
  
  void calculatePossibleMoves(Board board, int x, int y) {
    this.possibleMoves.clear();
    
    // Top-Left
    int i = 1;
    while (x-i >= 0 && y-i >= 0) {
      if (board.getSlot(x-i, y-i).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x-i, y-i), 1);
      }
      else {
        if (!board.getSlot(x-i, y-i).getPiece().getTeam().equals(this.team)) {
          this.possibleMoves.put(new MoveEvent(this, x, y, x-i, y-i, board.getSlot(x-i, y-i).getPiece()), 1);
        }
        break;
      }
      i++;
    }
    
    // Top-Right
    i = 1;
    while (x+i < board.getColumns() && y-i >= 0) {
      if (board.getSlot(x+i, y-i).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x+i, y-i), 1);
      }
      else {
        if (!board.getSlot(x+i, y-i).getPiece().getTeam().equals(this.team)) {
          this.possibleMoves.put(new MoveEvent(this, x, y, x+i, y-i, board.getSlot(x+i, y-i).getPiece()), 1);
        }
        break;
      }
      i++;
    }
    
    // Bottom-Left
    i = 1;
    while (x-i >= 0 && y+i < board.getRows()) {
      if (board.getSlot(x-i, y+i).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x-i, y+i), 1);
      }
      else {
        if (!board.getSlot(x-i, y+i).getPiece().getTeam().equals(this.team)) {
          this.possibleMoves.put(new MoveEvent(this, x, y, x-i, y+i, board.getSlot(x-i, y+i).getPiece()), 1);
        }
        break;
      }
      i++;
    }
    
    
    // Bottom-Right
    i = 1;
    while (x+i < board.getColumns() && y+i < board.getRows()) {
      if (board.getSlot(x+i, y+i).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x+i, y+i), 1);
      }
      else {
        if (!board.getSlot(x+i, y+i).getPiece().getTeam().equals(this.team)) {
          this.possibleMoves.put(new MoveEvent(this, x, y, x+i, y+i, board.getSlot(x+i, y+i).getPiece()), 1);
        }
        break;
      }
      i++;
    }

  }
}
