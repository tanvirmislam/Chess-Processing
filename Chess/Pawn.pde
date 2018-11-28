class Pawn extends Piece {
  Pawn(String _c, String _path) {
    super(_c, "pawn", _path);
  }
  
  Pawn(Piece _piece) {
    super(_piece);
  }
  
  void calculatePossibleMoves(Board board, int x, int y) {
    this.possibleMoves.clear();
    
    if (this.team.equals("black")) {
      if (y == 1 && board.getSlot(x, y+1).isEmpty() && board.getSlot(x, y+2).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x, y+2), 1);
      }
      if (y+1 < board.getRows() && board.getSlot(x, y+1).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x, y+1), 1);
      }
      if (x-1 >= 0 && y+1 < board.getRows() && !board.getSlot(x-1, y+1).isEmpty() && board.getSlot(x-1, y+1).getPiece().getTeam().equals("white")) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x-1, y+1, board.getSlot(x-1,y+1).getPiece()), 1);
      }
      if (x+1 < board.getColumns() && y+1 < board.getRows() && !board.getSlot(x+1, y+1).isEmpty() && board.getSlot(x+1, y+1).getPiece().getTeam().equals("white")) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x+1, y+1, board.getSlot(x+1,y+1).getPiece()), 1);
      }
    }
    
    else {
      if (y == 6 && board.getSlot(x, y-1).isEmpty() && board.getSlot(x, y-2).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x, y-2), 1);
      }
      if (y-1 >= 0 && board.getSlot(x, y-1).isEmpty()) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x, y-1), 1);
      }
      if (x-1 >= 0 && y-1 >= 0 && !board.getSlot(x-1, y-1).isEmpty() && board.getSlot(x-1, y-1).getPiece().getTeam().equals("black")) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x-1, y-1, board.getSlot(x-1,y-1).getPiece()), 1);
      }
      if (x+1 < board.getColumns() && y-1 >= 0 && !board.getSlot(x+1, y-1).isEmpty() && board.getSlot(x+1, y-1).getPiece().getTeam().equals("black")) {
        this.possibleMoves.put(new MoveEvent(this, x, y, x+1, y-1, board.getSlot(x+1,y-1).getPiece()), 1);
      }
    }
  }
}
