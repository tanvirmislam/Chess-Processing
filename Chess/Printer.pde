class Printer {
  Board board;
  
  Printer(Board _gameBoard) {
    board = _gameBoard;
  }
  
  void updateBoard(Board _gameBoard) {
    this.board = _gameBoard;
  }
  
  void drawBoard() {
    noStroke();
    for (int i = 0; i < board.rows; i++) {
      for (int j = 0; j < board.cols; j++) {
        // Square Color
        if ((i+1)%2 != 0) {
          if ((j+1)%2 != 0) {
            fill(232, 227, 194);
          }
          else {
            fill(155, 100, 63);
          }
        }
        else {
          if ((j+1)%2 != 0) {
            fill(155, 100, 63);
          }
          else {
            fill(232, 227, 194);
          }
        }
        // Square color
        rect(j*squareSize, i*squareSize, squareSize, squareSize);
        
        // Color the last made move
        MoveEvent lastMadeMove = this.board.getLastMadeMove();
        if (lastMadeMove != null) {
          if ((i == lastMadeMove.getFromY() && j == lastMadeMove.getFromX()) || (i == lastMadeMove.getToY() && j == lastMadeMove.getToX())) {
            fill(90, 206, 123, 110);
            rect(j*squareSize, i*squareSize, squareSize, squareSize);
          }
        }
        
        // Draw pieces
        Slot currentSlot = board.getSlot(j, i);
        // Draw piece
        if (!currentSlot.isEmpty()) {
          Piece drawPiece = currentSlot.getPiece();
          image(drawPiece.getImage(), currentSlot.getX()*board.getSquareSize(), currentSlot.getY()*board.getSquareSize());
        }
        
        // If selected, mark it red on it
        if (currentSlot.isSelected()) {
          fill(220, 0, 0, 110);
          rect(j*squareSize, i*squareSize, squareSize, squareSize);
        }
      }
    }
    
    // Draw circles on moveable squares of the selected piece
    for (int i = 0; i < board.rows; i++) {
      for (int j = 0; j < board.cols; j++) {
        Slot currentSlot = board.getSlot(j, i);
        
        if (currentSlot.isSelected()) {
          if (!currentSlot.isEmpty()) {
            int r = floor(board.getSquareSize() / 2);
            //print("r = " + r + "\n");
            HashMap<MoveEvent, Integer> possibleMoves = currentSlot.getPossibleMoves();
            for (MoveEvent e : possibleMoves.keySet()) {
              //print("Drawing circle at: (" + e.getToX() + "," + e.getToY() + "), At pixels: (" + ((e.getToX()*board.getSquareSize())+r) + "," + ((e.getToY()*board.getSquareSize())+r) + ")\n\n");
              if (currentSlot.getPiece().getTeam().equals("white")) {
                fill(246, 247, 220, 110);
              }
              else {
                fill(154, 161, 173, 110);
              }
              ellipse((e.getToX()*board.getSquareSize())+r, (e.getToY()*board.getSquareSize())+r, 20, 20);
            }
          }
        }
      } 
      
    }
    
  }
}
