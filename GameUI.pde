class GameUI {
  
  void drawHUD(int m, int mL, int t, int tL) {
    fill(#060BCB); textSize(18); textAlign(LEFT);
    text("Moves: " + m + " / " + mL, 50, 20);
    text("Time: " + t + " / " + tL, 200, 20);
  }

  void drawWinScreen(int m, int fT) {
    overlay();
    card(" You Win! ", color(50, 160, 80));
    fill(80); textSize(15);
    text("Moves: " + m + " Time: " + fT + "s", width/2, height/2 - 8);
    drawButton("Play Again [R]");
  }

  void drawFailScreen() {
    overlay();
    card(" Mission Failed", color(200, 50, 50));
    fill(80); textSize(14);
    text("You ran out of time or moves!", width/2, height/2 - 10);
    drawButton("Try Again [R]");
  }

  void overlay() {
    fill(0, 0, 0, 150); noStroke();
    rect(0, 0, width, height);
  }

  void card(String msg, color c) {
    fill(255, 252, 240); stroke(200, 160, 60); strokeWeight(3);
    rect(width/2 - 160, height/2 - 90, 320, 180, 18);
    fill(c); noStroke(); textAlign(CENTER); textSize(28);
    text(msg, width/2, height/2 - 42);
  }

  void drawButton(String label) {
    boolean hover = isButtonClicked();
    fill(hover ? color(100, 180, 240) : color(60, 140, 220));
    rect(width/2 - 70, height/2 + 18, 140, 38, 10);
    fill(255); textSize(14);
    text(label, width/2, height/2 + 42);
  }

  boolean isButtonClicked() {
    return mouseX >= width/2 - 70 && mouseX <= width/2 + 70 &&
           mouseY >= height/2 + 18 && mouseY <= height/2 + 56;
  }
}
