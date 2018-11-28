class King extends Piece {
  boolean canCastle;
  
  King(String _c, String _path) {
    super(_c, "king", _path);
    this.canCastle = true;
  }
  
  King(Piece _piece) {
    super(_piece);
  }
  
  void calculatePossibleMoves(Board board, int x, int y) {
    this.possibleMoves.clear();
    
    // Up
    if (y-1 >= 0) {
      if (board.getSlot(x, y-1).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x, y-1), 1);
      }
      else if (!board.getSlot(x, y-1).getPiece().getTeam().equals(this.team)) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x, y-1, board.getSlot(x, y-1).getPiece()), 1);
      }
    }
    
    // Down
    if (y+1 < board.getRows()) {
      if (board.getSlot(x, y+1).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x, y+1), 1);
      }
      else if (!board.getSlot(x, y+1).getPiece().getTeam().equals(this.team)) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x, y+1, board.getSlot(x, y+1).getPiece()), 1);
      }
    }
    
    // Left
    if (x-1 >= 0) {
      if (board.getSlot(x-1, y).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x-1, y), 1);
      }
      else if (!board.getSlot(x-1, y).getPiece().getTeam().equals(this.team)) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x-1, y, board.getSlot(x-1, y).getPiece()), 1);
      }
    }
    
    // Right
    if (x+1 < board.getColumns()) {
      if (board.getSlot(x+1, y).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x+1, y), 1);
      }
      else if (!board.getSlot(x+1, y).getPiece().getTeam().equals(this.team)) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x+1, y, board.getSlot(x+1, y).getPiece()), 1);
      }
    }
    
    // Top-Left
    if (x-1 >= 0 && y-1 >= 0) {
      if (board.getSlot(x-1, y-1).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x-1, y-1), 1);
      }
      else if (!board.getSlot(x-1, y-1).getPiece().getTeam().equals(this.team)) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x-1, y-1, board.getSlot(x-1, y-1).getPiece()), 1);
      }
    }
    
    // Top-Right
    if (x+1 < board.getColumns() && y-1 >= 0) {
      if (board.getSlot(x+1, y-1).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x+1, y-1), 1);
      }
      else if (!board.getSlot(x+1, y-1).getPiece().getTeam().equals(this.team)) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x+1, y-1, board.getSlot(x+1, y-1).getPiece()), 1);
      }
    }
    
    // Bottom-Left
    if (x-1 >= 0 && y+1 < board.getRows()) {
      if (board.getSlot(x-1, y+1).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x-1, y+1), 1);
      }
      else if (!board.getSlot(x-1, y+1).getPiece().getTeam().equals(this.team)) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x-1, y+1, board.getSlot(x-1, y+1).getPiece()), 1);
      }
    }
    
    // Bottom-Right
    if (x+1 < board.getColumns() && y+1 < board.getRows()) {
      if (board.getSlot(x+1, y+1).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x+1, y+1), 1);
      }
      else if (!board.getSlot(x+1, y+1).getPiece().getTeam().equals(this.team)) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x+1, y+1, board.getSlot(x+1, y+1).getPiece()), 1);
      }
    }

  }
}
