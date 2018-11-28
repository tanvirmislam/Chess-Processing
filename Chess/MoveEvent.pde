class MoveEvent {
  private Piece   movingPiece;
  private Piece   killedPiece;
  private int     fromX;
  private int     fromY;
  private int     toX;
  private int     toY;
  private boolean isCheckMove;
  
  MoveEvent(Piece _p, int _x1, int _y1, int _x2, int _y2) {
    this.movingPiece = _p;
    this.fromX       = _x1;
    this.fromY       = _y1;
    this.toX         = _x2;
    this.toY         = _y2;
    this.killedPiece = null;
    this.isCheckMove = false;
  }
  
  MoveEvent(Piece _p, int _x1, int _y1, int _x2, int _y2, Piece _k) {
    this.movingPiece = _p;
    this.fromX       = _x1;
    this.fromY       = _y1;
    this.toX         = _x2;
    this.toY         = _y2;
    this.killedPiece = _k;
    if (_k != null && !_k.getTeam().equalsIgnoreCase(_p.getTeam()) && _k.getType().equalsIgnoreCase("king")) {
      this.isCheckMove = true;
    }
    else {
      this.isCheckMove = false;
    }
  }
  
  @Override
  public int hashCode() {
      final int prime = 31;
      
      int from               = fromX*fromY;
      int to                 = toX*toY;
      int moving             = 0;
      int killed             = 0;
      String movingPieceName = movingPiece.getName();
      for (int i = 0; i < movingPieceName.length(); i++) {
        moving += movingPieceName.charAt(i);
      }
      if (this.killedPiece != null) {
        String killedPieceName = killedPiece.getName();
        for (int i = 0; i < killedPieceName.length(); i++) {
          killed += killedPieceName.charAt(i);
        }
      }
      
      int result = 1;
      result = (prime * result) + from;
      result = (prime * result) + to;
      result = (prime * result) + moving + killed;
      
      return result;
  }
  
  @Override
  public boolean equals(Object obj) {
    if (obj == null) { return false; }
    if (this == obj) { return true; }
    if (this.getClass() != obj.getClass()) { return false; }
    
    MoveEvent check = (MoveEvent) obj;
    if (this.movingPiece.getName().equals(check.getMovingPiece().getName()) &&
        this.fromX == check.getFromX() && this.fromY == check.getFromY()    &&
        this.toX   == check.getToX()   && this.toY   == check.getToY()) {    
      if (this.killedPiece == null && check.getKilledPiece() == null) {
        return true;
      }
      else if ((this.killedPiece != null && check.getKilledPiece() == null) ||
               (this.killedPiece == null && check.getKilledPiece() != null)) {
        return false;
      }
      else {
        if (this.killedPiece.getName().equals(check.getKilledPiece().getName())) {
          return true;
        }
      }
    }
    
    return false;
  }
  
  Piece getMovingPiece() { return this.movingPiece; }
  Piece getKilledPiece() { return this.killedPiece; }
  int getFromX()         { return this.fromX; }
  int getToX()           { return this.toX; }
  int getFromY()         { return this.fromY; }
  int getToY()           { return this.toY; }
  boolean isCheckMove()  { return this.isCheckMove; }
}
