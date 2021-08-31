color WHITE = #FFFFFF;
color GREY = #747474;

int numSquares;
float rectSize;

int antColumn;
int antRow;
int antDirection;

color[][] gridColorHistory;

void setup() {
  size(550, 550);
  
  // slow down animation with a lower frame rate
  frameRate(60);
  numSquares = 55;
  rectSize = width / numSquares;

  gridColorHistory = new int [numSquares][numSquares];
  initializeGrid();

  antColumn = antRow = numSquares / 2;
  antDirection = LEFT;
}

void draw() {
  drawGrid();
  gameLoop();
}

void gameLoop() {
  color currentGridColor = gridColorHistory[antRow][antColumn];
  // Uncomment/Comment the line below to toggle display of a red triangle representing an ant
  drawAnt(antRow, antColumn, antDirection);
  if (currentGridColor == WHITE) {
    antDirection = turnClockWise(antDirection);
    gridColorHistory[antRow][antColumn] = GREY;
  } else if (currentGridColor == GREY) {
    antDirection = turnAntiClockWise(antDirection);
    gridColorHistory[antRow][antColumn] = WHITE;
  }

  moveAntForward(antDirection);
}

// Utility Functions for the grid
void initializeGrid() {
  for (int i = 0; i < numSquares; i++) {
    for (int j = 0; j < numSquares; j++) {
      gridColorHistory[i][j] = WHITE;
    }
  }
}

void drawGrid() {
  for (int i = 0; i < numSquares; i++) {
    for (int j = 0; j < numSquares; j++) {
      drawRect(i, j, gridColorHistory[i][j]);
    }
  }
}

void drawRect(int row, int column, color rectColor) {
  // columns and rows are 0 indexed
  rectMode(CORNER);
  stroke(0);
  fill(rectColor);
  rect(column * rectSize, row * rectSize, rectSize, rectSize);
}

// Utility Functions for the ant
void drawAnt(int row, int column, int direction) {
  fill(255, 0, 0);
  if (direction == UP) {
    triangle(column * rectSize, (row + 1) * rectSize, (column + 1) * rectSize, (row + 1) * rectSize, (column + 0.5) * rectSize, row * rectSize);
  } else if (direction == DOWN) {
    triangle(column * rectSize, row * rectSize, (column + 1) * rectSize, row * rectSize, (column + 0.5) * rectSize, (row + 1) * rectSize);
  } else if (direction == LEFT) {
    triangle(column * rectSize, (row + 0.5) * rectSize, (column + 1) * rectSize, row * rectSize, (column + 1) * rectSize, (row + 1) * rectSize);
  } else if (direction == RIGHT) {
    triangle(column * rectSize, row * rectSize, column * rectSize, (row + 1) * rectSize, (column + 1) * rectSize, (row + 0.5) * rectSize);
  }
}

void moveAntForward(int direction) {
  if (direction == UP) {
    antRow--;
  } else if (direction == DOWN) {
    antRow++;
  } else if (direction == LEFT) {
    antColumn--;
  } else if (direction == RIGHT) {
    antColumn++;
  }
}
int turnClockWise(int direction) {
  int newDirection = direction + 1;
  return newDirection > DOWN? LEFT:newDirection;
}

int turnAntiClockWise(int direction) {
  int newDirection = direction - 1;
  return newDirection < LEFT? DOWN:newDirection;
}
