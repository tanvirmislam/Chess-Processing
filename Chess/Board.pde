import java.util.Stack; 

class Board {
  int rows;
  int cols;
  int squareSize;
  
  ArrayList<ArrayList<Slot>> board;
  Stack<MoveEvent> history;

  boolean isBlackChecked;
  boolean isWhiteChecked;
  String  winner;
  
  Board(int _r, int _c, int _sz) {
    this.rows       = _r;
    this.cols       = _c;
    this.squareSize = _sz;
    
    initBoard();
    calculateAllPossibleMoves();
    history = new Stack<MoveEvent>();
  }
  
  // Copy constructor 
  Board(Board _gameBoard) {
    this.rows       = _gameBoard.getRows();
    this.cols       = _gameBoard.getColumns();
    this.squareSize = _gameBoard.getSquareSize();
    
    this.board = new ArrayList<ArrayList<Slot>>(this.rows);
    for (int i = 0; i < this.rows; i++) {
      ArrayList<Slot> row = new ArrayList<Slot>(this.cols);
      this.board.add(row);  
    }
    for (int y = 0; y < this.rows; y++) {
      for (int x = 0; x < this.cols; x++) {
        Slot s = new Slot(_gameBoard.getSlot(x,y));
        this.board.get(y).add(x, s);
      }
    }
    
    this.history        = (Stack<MoveEvent>)_gameBoard.getHistory().clone();
    this.isWhiteChecked = _gameBoard.isWhiteChecked();
    this.isBlackChecked = _gameBoard.isBlackChecked();
    this.winner         = _gameBoard.getWinner();
  }
  
  boolean isEmpty(int _xPos, int _yPos) {
    return this.getSlot(_xPos, _yPos).isEmpty();
  }
  
  Slot getSlot(int _xPos, int _yPos) {
    return this.board.get(_yPos).get(_xPos);
  }
  
  void pressSlot(int _xPos, int _yPos) {
    this.getSlot(_xPos, _yPos).select();
  }
  
  void calculateAllPossibleMoves() {
    this.isWhiteChecked = false;
    this.isBlackChecked = false;
    
    for (ArrayList<Slot> arr : board) {
      for (Slot s : arr) {
        if (!s.isEmpty()) {
          s.calculatePossibleMoves(this);
          
          // Scan if possbile moves are causing a check
          if (!isWhiteChecked || !isBlackChecked) {
            scanForCheck(s.getPiece());
          }
        }
      }
    }
    
  }
  
  boolean makeMove(int _fromX, int _fromY, int _toX, int _toY) {
    // Initiate move event
    MoveEvent move;
    Piece movingPiece = this.getSlot(_fromX, _fromY).getPiece();
    if (!this.getSlot(_toX, _toY).isEmpty()) {
      Piece killedPiece = this.getSlot(_toX, _toY).getPiece();
      move = new MoveEvent(movingPiece, _fromX, _fromY, _toX, _toY, killedPiece);
    }
    else {
      move = new MoveEvent(movingPiece, _fromX, _fromY, _toX, _toY);
    }
    
    // Make move
    if (this.getSlot(_fromX, _fromY).isValidMove(move)) {
      print("Making move.\n\n");
      
      this.getSlot(_fromX, _fromY).removePiece();
      this.getSlot(_toX, _toY).addPiece(movingPiece);
      
      // Add to history
      this.storeMove(move);
      
      // Move made. Calculate possible moves.
      // It also checks for check
      calculateAllPossibleMoves();
      if (this.isWhiteChecked) { print("White is checked!\n\n"); }
      else                     { print("White is Safe.\n\n");    }
      if (this.isBlackChecked) { print("Black is checked!\n\n"); }
      else                     { print("Black is Safe.\n\n");    }
      
      // Check for winner
      if (isBlackWinning()) {
        this.winner = "black";
      }
      else if (isWhiteWinning()) {
        this.winner = "white";
      }
      else {
        this.winner = "none";
      }
      print("Winner: " + this.winner + "\n\n");
      
      return true;
    }
    else {
      print("Invalid move.\n\n");
      return false;
    }
    
  }
  
  boolean isBlackWinning() {
    if (!isWhiteChecked) {
      return false;
    }
    
    //Board tempBoard = new Board(this);
    
    for (ArrayList<Slot> arr : this.board) {
      for (Slot s : arr) {
        if (!s.isEmpty() && s.getPiece().getTeam().equalsIgnoreCase("white")) {
          HashMap<MoveEvent, Integer> possibleMovesCopy = s.copyPossibleMoves();
          
          for (MoveEvent move : possibleMovesCopy.keySet()) {
            this.getSlot(move.getFromX(), move.getFromY()).removePiece();
            this.getSlot(move.getToX(), move.getToY()).addPiece(move.getMovingPiece());
            this.storeMove(move);
            this.calculateAllPossibleMoves();
            
            if (!isWhiteChecked) {
              this.undoMove();
              return false;
            }
            this.undoMove();
          }
          
        }
      }
    }
    
    return true;
  }
  
  boolean isWhiteWinning() {
    if (!isBlackChecked) {
      return false;
    }
    
    //Board tempBoard = new Board(this);
    
    for (ArrayList<Slot> arr : this.board) {
      for (Slot s : arr) {
        if (!s.isEmpty() && s.getPiece().getTeam().equalsIgnoreCase("black")) {
          HashMap<MoveEvent, Integer> possibleMovesCopy = s.copyPossibleMoves();
          
          for (MoveEvent move : possibleMovesCopy.keySet()) {
            this.getSlot(move.getFromX(), move.getFromY()).removePiece();
            this.getSlot(move.getToX(), move.getToY()).addPiece(move.getMovingPiece());
            this.storeMove(move);
            this.calculateAllPossibleMoves();
            
            if (!isBlackChecked) {
              this.undoMove();
              return false;
            }
            this.undoMove();
          }
          
        }
      }
    }
    
    return true;
  }
  
  
  void scanForCheck(Piece piece) {
    HashMap<MoveEvent, Integer> possibleMoves = piece.getPossibleMoves();
    for (MoveEvent move : possibleMoves.keySet()) {
      if (move.isCheckMove()) {
        if (piece.getTeam().equals("black")) {
          this.isWhiteChecked = true;
        }
        else {
          this.isBlackChecked = true;
        }
      }
    }
  }
  
  void storeMove(MoveEvent move) {
    this.history.push(move);
  }
  
  boolean undoMove() {
    if (history.isEmpty()) {
      return false;
    }
    return revertMove(history.pop());
  }
  
  boolean revertMove(MoveEvent move) {
    Slot fromSlot = this.getSlot(move.getFromX(), move.getFromY());
    Slot toSlot   = this.getSlot(move.getToX(), move.getToY());
    
    if (toSlot.isEmpty() || !fromSlot.isEmpty()) {
      return false;
    }
    
    Piece movingPiece = toSlot.getPiece();
    fromSlot.addPiece(movingPiece);
    toSlot.removePiece();
    if (move.getKilledPiece() != null) {
      toSlot.addPiece(move.getKilledPiece());
    }
    
    calculateAllPossibleMoves();
    
    return true;
  }
  
  
  
  
  int getRows() { return this.rows; }
  int getColumns() { return this.cols; }
  int getSquareSize() { return this.squareSize; }
  ArrayList<ArrayList<Slot>> getSlotBoard() { return this.board; }
  Stack<MoveEvent> getHistory() { return this.history; }
  MoveEvent getLastMadeMove() { 
    if (!this.history.isEmpty()) { 
      return this.history.peek(); 
    } 
    else { 
      return null; 
    } 
  }
  boolean isWhiteChecked() { return this.isWhiteChecked; }
  boolean isBlackChecked() { return this.isBlackChecked; }
  String getWinner() { return this.winner; }
 
  
  void initBoard() {
    this.board = new ArrayList<ArrayList<Slot>>(this.rows);
    for (int i = 0; i < this.rows; i++) {
      ArrayList<Slot> row = new ArrayList<Slot>(this.cols);
      this.board.add(row);  
    }
    
    
    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        if (i == 1) {
          Piece blackPawn = new Pawn("black", "images/BlackPawn.png");
          this.board.get(i).add(j, new Slot(j, i, blackPawn));
        }
        
        else if (i == 6) {
          Piece whitePawn = new Pawn("white", "images/WhitePawn.png");
          this.board.get(i).add(j, new Slot(j, i, whitePawn));
        }
        
        else if (i == 0) {
          if (j == 0 || j == 7) {
            Piece blackRook = new Rook("black", "images/BlackRook.png");
            this.board.get(i).add(j, new Slot(j, i, blackRook));
          }
          else if (j == 1 || j == 6) {
            Piece blackKnight = new Knight("black", "images/BlackKnight.png");
            this.board.get(i).add(j, new Slot(j, i, blackKnight));
          }
          else if (j == 2 || j == 5) {
            Piece blackBishop = new Bishop("black", "images/BlackBishop.png");
            this.board.get(i).add(j, new Slot(j, i, blackBishop));
          }
          else if (j == 3) {
            Piece blackKing = new King("black", "images/BlackKing.png");
            this.board.get(i).add(j, new Slot(j, i, blackKing));
          }
          else if (j == 4) {
            Piece blackQueen = new Queen("black", "images/BlackQueen.png");
            this.board.get(i).add(j, new Slot(j, i, blackQueen));
          }
        }
        
        else if (i == 7) {
          if (j == 0 || j == 7) {
            Piece whiteRook = new Rook("white", "images/WhiteRook.png");
            this.board.get(i).add(j, new Slot(j, i, whiteRook));
          }
          else if (j == 1 || j == 6) {
            Piece whiteKnight = new Knight("white", "images/WhiteKnight.png");
            this.board.get(i).add(j, new Slot(j, i, whiteKnight));
          }
          else if (j == 2 || j == 5) {
            Piece whiteBishop = new Bishop("white", "images/WhiteBishop.png");
            this.board.get(i).add(j, new Slot(j, i, whiteBishop));
          }
          else if (j == 3) {
            Piece whiteKing = new King("white", "images/WhiteKing.png");
            this.board.get(i).add(j, new Slot(j, i, whiteKing));
          }
          else if (j == 4) {
            Piece whiteQueen = new Queen("white", "images/WhiteQueen.png");
            this.board.get(i).add(j, new Slot(j, i, whiteQueen));
          }
        }
        
        else {
          this.board.get(i).add(j, new Slot(j, i));
        }
      }
    }
    
  }
  
  
}
