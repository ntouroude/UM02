int nbBalls = 20;
int minDistance = 110;
Ball[] balls;
Table table;

void setup() {
  size(1200,800);
  loadData();
}

void loadData() {
  table = loadTable("GOT.csv", "header");
  // Sort the table into score order
  table.sortReverse("score");
  balls = new Ball[nbBalls]; 

  // Iterate on the number of balls
  for(int i=0; i<nbBalls; i++) {
    Float score = table.getRow(i).getFloat("score");
    String name = table.getRow(i).getString("short_name");
    //println(name + " has a score of " + degree);
    // Make a Ball object out of the data
    balls[i] = new Ball(name, score*100);
  }
}

void draw() {
  background(0,0,0);
  
  for(int i=0 ; i<nbBalls ; i++) {
    balls[i].bounce();
    balls[i].display();
    // collect all balls with the mouse when its pressed
    balls[i].collect();
  }
}

class Ball {
  float posX, posY;
  float diam;
  float speedX, speedY;
  float r, g, b;
  String name;
  
 Ball(String n, float d) {
    posX = random(width);
    posY = random(height);
    diam = d;
    name = n;
    speedX = random(1,2);
    speedY = random(1,2);
    r = 65;
    g = 105;
    b = 225;
  }
  
  void bounce() {
    // update position : go left/right or top/down
    posX = posX + speedX;
    posY = posY + speedY;
    // bounce : if end of the canvas change direction
    if(posX > width-diam/2 || posX < 0) {
      speedX = speedX*-1;
    }
    if(posY > height-diam/2 || posY < 0) {
      speedY = speedY*-1;
    }
  }
 

  void collect() {
    if(mousePressed == true) {
      if(dist(mouseX, mouseY, posX, posY) < 40) {
      posX = mouseX;
      posY = mouseY;
      }
    }
  }
  
  void display() {
    stroke(255,255,255,100);
    fill(r,g,b,120);
    circle(posX,posY,diam);
    fill(255);
    textAlign(CENTER);
    text(name, posX, posY);  
  }
}
