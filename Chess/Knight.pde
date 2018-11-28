class Knight extends Piece {
  Knight(String _c, String _path) {
    super(_c, "knight", _path);
  }
  
  Knight(Piece _piece) {
    super(_piece);
  }
  
  void calculatePossibleMoves(Board board, int x, int y) {
    this.possibleMoves.clear();
    
    // Top-Left 1
    int ix = 1;
    int iy = 2;
    if (x-ix >= 0 && y-iy >= 0) {
      if (board.getSlot(x-ix, y-iy).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x-ix, y-iy), 1);
      }
      else if (!board.getSlot(x-ix, y-iy).getPiece().getTeam().equals(this.team)) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x-ix, y-iy, board.getSlot(x-ix, y-iy).getPiece()), 1);
      }
    }
    
    // Top-Left 2
    ix = 2;
    iy = 1;
    if (x-ix >= 0 && y-iy >= 0) {
      if (board.getSlot(x-ix, y-iy).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x-ix, y-iy), 1);
      }
      else if (!board.getSlot(x-ix, y-iy).getPiece().getTeam().equals(this.team)) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x-ix, y-iy, board.getSlot(x-ix, y-iy).getPiece()), 1);
      }
    }
    
    // Top-Right 1
    ix = 1;
    iy = 2;
    if (x+ix < board.getColumns() && y-iy >= 0) {
      if (board.getSlot(x+ix, y-iy).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x+ix, y-iy), 1);
      }
      else if (!board.getSlot(x+ix, y-iy).getPiece().getTeam().equals(this.team)) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x+ix, y-iy, board.getSlot(x+ix, y-iy).getPiece()), 1);
      }
    }
    
    // Top-Right 2
    ix = 2;
    iy = 1;
    if (x+ix < board.getColumns() && y-iy >= 0) {
      if (board.getSlot(x+ix, y-iy).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x+ix, y-iy), 1);
      }
      else if (!board.getSlot(x+ix, y-iy).getPiece().getTeam().equals(this.team)) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x+ix, y-iy, board.getSlot(x+ix, y-iy).getPiece()), 1);
      }
    }
    
    // Bottom-Left 1
    ix = 1;
    iy = 2;
    if (x-ix >= 0 && y+iy < board.getRows()) {
      if (board.getSlot(x-ix, y+iy).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x-ix, y+iy), 1);
      }
      else if (!board.getSlot(x-ix, y+iy).getPiece().getTeam().equals(this.team)) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x-ix, y+iy, board.getSlot(x-ix, y+iy).getPiece()), 1);
      }
    }
    
    // Bottom-Left 2
    ix = 2;
    iy = 1;
    if (x-ix >= 0 && y+iy < board.getRows()) {
      if (board.getSlot(x-ix, y+iy).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x-ix, y+iy), 1);
      }
      else if (!board.getSlot(x-ix, y+iy).getPiece().getTeam().equals(this.team)) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x-ix, y+iy, board.getSlot(x-ix, y+iy).getPiece()), 1);
      }
    }
    
    // Bottom-Right 1
    ix = 1;
    iy = 2;
    if (x+ix < board.getColumns() && y+iy < board.getRows()) {
      if (board.getSlot(x+ix, y+iy).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x+ix, y+iy), 1);
      }
      else if (!board.getSlot(x+ix, y+iy).getPiece().getTeam().equals(this.team)) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x+ix, y+iy, board.getSlot(x+ix, y+iy).getPiece()), 1);
      }
    }
    
    // Bottom-Right 2
    ix = 2;
    iy = 1;
    if (x+ix < board.getColumns() && y+iy < board.getRows()) {
      if (board.getSlot(x+ix, y+iy).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x+ix, y+iy), 1);
      }
      else if (!board.getSlot(x+ix, y+iy).getPiece().getTeam().equals(this.team)) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x+ix, y+iy, board.getSlot(x+ix, y+iy).getPiece()), 1);
      }
    }
  }
}
