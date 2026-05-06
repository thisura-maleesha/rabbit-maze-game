// Global Variables
int timeLimit = 55;
int moveLimit = 75;
int finalTime = 0;
boolean failed = false, won = false;
int COLS = 10, ROWS = 10, CELL = 28;
int OFFSET_X = 50, OFFSET_Y = 50;
int[][] maze;
int startTime, moves = 0;

// Class Objects
GameEntity entities;
GameUI ui;

void setup() {
  size(400, 400);
  smooth();
  textFont(createFont("Georgia", 18));
  generateMaze();
  
  entities = new GameEntity();
  ui = new GameUI();
  startTime = millis();
}

void draw() {
  background(245, 242, 235); // bgColor
  
  drawMaze();
  entities.update();
  entities.display();

  int elapsed = (won || failed) ? finalTime : (millis() - startTime) / 1000;
  ui.drawHUD(moves, moveLimit, elapsed, timeLimit);

  if (won) ui.drawWinScreen(moves, finalTime);
  if (failed) ui.drawFailScreen();

  if (!won && !failed && (elapsed >= timeLimit || moves >= moveLimit)) {
    failed = true;
    finalTime = elapsed;
  }
}

void generateMaze() {
  maze = new int[ROWS][COLS];
  for (int r = 0; r < ROWS; r++) for (int c = 0; c < COLS; c++) maze[r][c] = 15;
  boolean[][] visited = new boolean[ROWS][COLS];
  int[] stackR = new int[ROWS * COLS], stackC = new int[ROWS * COLS];
  int top = 0;
  stackR[top] = 0; stackC[top] = 0; visited[0][0] = true;

  while (top >= 0) {
    int r = stackR[top], c = stackC[top];
    int[] dr = {-1, 0, 1, 0}, dc = {0, 1, 0, -1}, dirs = {0, 1, 2, 3};
    for (int i = 3; i > 0; i--) { int j = (int)random(i + 1); int tmp = dirs[i]; dirs[i] = dirs[j]; dirs[j] = tmp; }
    boolean moved = false;
    for (int d : dirs) {
      int nr = r + dr[d], nc = c + dc[d];
      if (nr >= 0 && nr < ROWS && nc >= 0 && nc < COLS && !visited[nr][nc]) {
        int[] wallBit = {1, 2, 4, 8}, oppWallBit= {4, 8, 1, 2};
        maze[r][c] &= ~wallBit[d]; maze[nr][nc] &= ~oppWallBit[d];
        visited[nr][nc] = true; top++; stackR[top] = nr; stackC[top] = nc;
        moved = true; break;
      }
    }
    if (!moved) top--;
  }
}

void drawMaze() {
  stroke(30); strokeWeight(2);
  for (int r = 0; r < ROWS; r++) {
    for (int c = 0; c < COLS; c++) {
      int x = OFFSET_X + c * CELL, y = OFFSET_Y + r * CELL, w = maze[r][c];
      if ((w & 1) != 0) line(x, y, x + CELL, y);
      if ((w & 2) != 0) line(x + CELL, y, x + CELL, y + CELL);
      if ((w & 4) != 0) line(x, y + CELL, x + CELL, y + CELL);
      if ((w & 8) != 0) line(x, y, x, y + CELL);
    }
  }
}

void keyPressed() {
  if (won || failed) { if (key == 'r' || key == 'R') resetGame(); return; }
  int r = entities.rabbitRow, c = entities.rabbitCol, w = maze[r][c];
  if ((keyCode == UP || key == 'w') && (w & 1) == 0) entities.rabbitRow--;
  else if ((keyCode == RIGHT || key == 'd') && (w & 2) == 0) entities.rabbitCol++;
  else if ((keyCode == DOWN || key == 's') && (w & 4) == 0) entities.rabbitRow++;
  else if ((keyCode == LEFT || key == 'a') && (w & 8) == 0) entities.rabbitCol--;
  else return;

  moves++;
  entities.setTarget();
  if (entities.rabbitRow == 9 && entities.rabbitCol == 9) {
    won = true;
    finalTime = (millis() - startTime) / 1000;
  }
}

void resetGame() {
  won = false; failed = false; moves = 0; startTime = millis(); finalTime = 0;
  generateMaze();
  entities.reset();
}

void mousePressed() {
  if ((won || failed) && ui.isButtonClicked()) resetGame();
}
