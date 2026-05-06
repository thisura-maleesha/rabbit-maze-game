class GameEntity {
  int rabbitCol = 0, rabbitRow = 0;
  float rabbitX, rabbitY, targetX, targetY;
  float animSpeed = 0.25;

  GameEntity() { reset(); }

  void reset() {
    rabbitCol = 0; rabbitRow = 0;
    rabbitX = OFFSET_X + rabbitCol * CELL + CELL/2;
    rabbitY = OFFSET_Y + rabbitRow * CELL + CELL/2;
    targetX = rabbitX; targetY = rabbitY;
  }

  void setTarget() {
    targetX = OFFSET_X + rabbitCol * CELL + CELL/2;
    targetY = OFFSET_Y + rabbitRow * CELL + CELL/2;
  }

  void update() {
    rabbitX += (targetX - rabbitX) * animSpeed;
    rabbitY += (targetY - rabbitY) * animSpeed;
  }

  void display() {
    drawGoal();
    drawRabbit();
  }

  void drawRabbit() {
    float s = CELL * 0.85;
    pushMatrix();
    translate(rabbitX, rabbitY);
    // Body & Head
    fill(200, 200, 205); noStroke();
    ellipse(0, 3, s * 0.7, s * 0.75); 
    ellipse(0, -s * 0.22, s * 0.52, s * 0.48); 
    // Ears
    fill(200, 200, 205);
    ellipse(-s * 0.13, -s * 0.55, s * 0.18, s * 0.38);
    ellipse(s * 0.13, -s * 0.55, s * 0.18, s * 0.38);
    fill(255, 160, 180);
    ellipse(-s * 0.13, -s * 0.55, s * 0.09, s * 0.25);
    ellipse(s * 0.13, -s * 0.55, s * 0.09, s * 0.25);
    // Eyes & Nose
    fill(50); ellipse(-s * 0.1, -s * 0.26, s * 0.09, s * 0.09);
    ellipse(s * 0.1, -s * 0.26, s * 0.09, s * 0.09);
    fill(255, 160, 180); ellipse(0, -s * 0.16, s * 0.08, s * 0.06);
    popMatrix();
  }

  void drawGoal() {
    float cx = OFFSET_X + 9 * CELL + CELL/2;
    float cy = OFFSET_Y + 9 * CELL + CELL/2 + 2;
    float cs = CELL * 0.42;

    // Carrot Body
    fill(230, 100, 30); stroke(2);
    pushMatrix();
    translate(cx, cy + cs * 0.1);
    beginShape(); 
    vertex(-cs * 0.35, -cs * 0.5); vertex(cs * 0.35, -cs * 0.5);
    vertex(cs * 0.12, cs * 0.7); vertex(-cs * 0.12, cs * 0.7); 
    endShape(CLOSE);
    popMatrix();

    // Carrot Lines
    stroke(200, 80, 20); strokeWeight(1);
    line(cx - cs * 0.15, cy - cs * 0.1, cx + cs * 0.15, cy - cs * 0.1);

    // Leaves (Kola tika methana thiyenne)
    stroke(1);
    fill(60, 160, 60);
    pushMatrix();
    translate(cx, cy - cs * 0.38);
    for (int i = -1; i <= 1; i++) {
      pushMatrix();
      rotate(radians(i * 25));
      ellipse(0, -cs * 0.38, cs * 0.14, cs * 0.55);
      popMatrix();
    }
    popMatrix();
  }
}
