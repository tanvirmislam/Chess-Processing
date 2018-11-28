class Slot {  
  int x;
  int y;
  private Piece   piece;
  private boolean isEmpty;
  private boolean isSelected;
  
  Slot(int _xPos, int _yPos) { 
    this.x          = _xPos;
    this.y          = _yPos;
    this.piece      = null; 
    this.isEmpty    = true;
    this.isSelected = false;
  }
  Slot(int _xPos, int _yPos, Piece _p) { 
    this.x          = _xPos;
    this.y          = _yPos;
    this.piece      = _p; 
    this.isEmpty    = false;
    this.isSelected = false;
  }
  
  // Copy constructor
  Slot(Slot _slot) {
    this.x          = _slot.getX();
    this.y          = _slot.getY();
    this.isEmpty    = _slot.isEmpty();
    this.isSelected = _slot.isSelected();
    if (!_slot.isEmpty()) {
      switch(_slot.getPiece().getType()) {
        case "pawn":
          this.piece = new Pawn(_slot.getPiece());
          break;
        case "rook":
          this.piece = new Rook(_slot.getPiece());
          break;
        case "bishop":
          this.piece = new Bishop(_slot.getPiece());
          break;
        case "knight":
          this.piece = new Knight(_slot.getPiece());
          break;
        case "queen":
          this.piece = new Queen(_slot.getPiece());
          break;
        case "king":
          this.piece = new King(_slot.getPiece());
          break;
      }
    }
    else {
      this.piece = null;
    }
  }
  
  void removePiece() { 
    this.piece   = null; 
    this.isEmpty = true;
  }
  
  void addPiece(Piece _p) {
    this.removePiece();
    this.piece   = _p;
    this.isEmpty = false;
  }
  
  void select() { 
    if (!isSelected) {
      this.isSelected = true;
    }
    else {
      this.isSelected = false;
    }
  }
  
  void calculatePossibleMoves(Board board) {
    if (this.piece != null) {
      this.piece.calculatePossibleMoves(board, this.x, this.y);
    }
  }
  
  boolean isValidMove(MoveEvent e) {
    if (this.piece != null) {
      return piece.isValidMove(e);
    }
    else {
      return false;
    }
  }
  
  boolean isEmpty()    { return this.isEmpty; }
  boolean isSelected() { return this.isSelected; }
  Piece getPiece()     { return this.piece; }
  int getX()           { return this.x; }
  int getY()           { return this.y; }
  HashMap<MoveEvent, Integer> getPossibleMoves()  { return this.piece.getPossibleMoves(); }
  HashMap<MoveEvent, Integer> copyPossibleMoves() { return this.piece.copyPossibleMoves(); }
}
