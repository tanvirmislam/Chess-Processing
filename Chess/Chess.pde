int canvasWidth  = 600;
int canvasHeight = 600;
int rows         = 8;
int cols         = 8;
int squareSize   = canvasWidth / rows;

boolean isPressed = false;
int     lastPressedX = -1;
int     lastPressedY = -1;

Board   board;
Printer printer;

void setup() {
  size(600,600);
  board   = new Board(rows, cols, squareSize);
  printer = new Printer(board);
}

void draw() {
  background(1);
  printer.updateBoard(board);
  printer.drawBoard();
  
  //printMouseLocation();
}

void printMouseLocation() {
  print("X: " + floor(mouseX/squareSize) + ", Y: " + floor(mouseY/squareSize) + "\n");
}

void mousePressed() {
  int x = floor(mouseX/squareSize);
  int y = floor(mouseY/squareSize);
  
  if (!isPressed) {
    board.pressSlot(x, y);
    print("Pressed Slot X: ", + x + ", Y: " + y + "\n");
    if (board.getSlot(x, y).isEmpty()) {
      print("This is an empty slot.\n\n");
    }
    else {
      print("The slot contains a " + board.getSlot(x, y).getPiece().getName() + "\n\n");
    }
    lastPressedX = x;
    lastPressedY = y;
    isPressed    = true;
  }
  else {
    board.pressSlot(lastPressedX, lastPressedY);
    //board.pressSlot(x, y);
    print("From Slot X: " + lastPressedX + ", Y: " + lastPressedY + " To Slot X: " + x + ", Y: " + y + "\n");
    board.makeMove(lastPressedX, lastPressedY, x, y);
    lastPressedX = x;
    lastPressedY = y;
    isPressed = false;
  }
}

void keyPressed() {
  if (key == 'U' || key == 'u') {
    board.undoMove();
  }
}
