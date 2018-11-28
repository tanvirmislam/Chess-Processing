abstract class Piece {
  protected String team;
  protected String type;
  protected PImage img;
  protected HashMap<MoveEvent, Integer> possibleMoves;
  
  Piece(String _c, String _n, String _path) {
    this.team  = _c;
    this.type  = _n;
    this.img = loadImage(_path);
    this.possibleMoves = new HashMap<MoveEvent, Integer>();
  }
  
  // Copy constructor
  Piece(Piece _piece) {
    this.team  = _piece.getTeam();
    this.type  = _piece.getType();
    this.img   = _piece.getImage();
    this.possibleMoves = (HashMap<MoveEvent, Integer>) _piece.getPossibleMoves().clone();
  }
  
  abstract void calculatePossibleMoves(Board board, int x, int y);
  
  boolean isValidMove(MoveEvent checkMove) {
    if (this.possibleMoves.containsKey(checkMove)) {
      return true;
    }
    else {
      return false;
    }
  } 
  
  String getTeam() {
    return this.team;
  }

  String getType() {
    return this.type;
  }
  
  String getName() {
    return this.team + " " + this.type;
  }
  
  PImage getImage() {
    return this.img;
  }
  
  HashMap<MoveEvent, Integer> getPossibleMoves() {
    return this.possibleMoves;
  }
  
  HashMap<MoveEvent, Integer> copyPossibleMoves() {
    HashMap<MoveEvent, Integer> moves = (HashMap<MoveEvent, Integer>) this.possibleMoves.clone();
    return moves;
  }

}
