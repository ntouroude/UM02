Table table;
StringList iName;
FloatList iScore;
int nbBars = 20;
Bar[] bars = new Bar[nbBars];

float graphWidth = width*0.7;
float barWidth = graphWidth/(nbBars*2);
float space = 2*barWidth;
float ymax = -1;

boolean showName;
color defaultColor = color(255);
color highlightColor = color(220,20,60);

void setup() {
  graphWidth = width*0.7;
  barWidth = graphWidth/(nbBars*2);
  space = 2*barWidth;
  fullScreen();
  loadData();
  float x = width*0.1 - barWidth;
  float h;
  float score;
  String name;
  for(int i=0 ; i<nbBars; i++) {
    x = x+space;
    h = iScore.get(i)*(height*0.8-height*0.1)/ymax;
    name = iName.get(i);
    score = iScore.get(i);
    bars[i] = new Bar(i * space + width*0.1, h, name, score);
  }
}

void loadData() {
  table = loadTable("GOT.csv", "header");
  // Sort the table into score order
  table.sortReverse("score");
  iName = new StringList();
  iScore = new FloatList();
  // For the first 20
  for(int i=0; i<nbBars; i++) {
    iName.append(table.getRow(i).getString("short_name"));
    iScore.append(table.getRow(i).getFloat("score")*10);
    if(ymax<iScore.get(i)) {
      ymax = iScore.get(i);
    }
  }
  ymax=int(ymax)+5;
}

void draw() {
  background(0);
  for(int i=0; i<iScore.size(); i++) {
      // Name, score and change of color
      bars[i].drawBars();
      bars[i].displayDetails();
  }
  drawAxes();
}

void drawAxes() {
  stroke(255);
  strokeWeight(3);
  fill(255);
  // X axe
  line(width*0.1, height*0.8, width*0.8, height*0.8);
  textSize(16);
  text("GOT Characters",width*0.4, height*0.8+40);
  triangle(width*0.8, height*0.8-10, width*0.8+10, height*0.8, width*0.8, height*0.8+10);
  // Y axe
  line(width*0.1, height*0.8, width*0.1, height*0.1);
  textSize(16);
  text("Score",width*0.09, height*0.07);
  triangle(width*0.1-10, height*0.1, width*0.1, height*0.1-10, width*0.1+10, height*0.1);
  textSize(14);
  text("0", width*0.1-20, height*0.8);
  
}

class Bar {
  color fillColor;
  color strokeColor;
  float xBar;
  float barHeight;
  String name;
  float score;
  
  Bar(float x, float h, String n, float s) {
    fillColor = defaultColor;
    strokeColor = defaultColor;
    xBar = x;
    barHeight = h;
    name = n;
    score = s;
  }
  
  boolean barOver(float x, float y, float w, float h) {
    if (mouseX >= x && mouseX <= x+w && mouseY >= h && mouseY <= y) {
      return true;
    } 
    else {
      return false;
    }  
  }
  
  void drawBars() {
    strokeWeight(1);
    stroke(strokeColor);
    fill(fillColor);
    rect(xBar, height*0.8, barWidth, -barHeight);
  }
  
  void displayDetails() {
    if (barOver(xBar, height*0.8, barWidth, barHeight)) {
      strokeColor = highlightColor;
      fillColor = highlightColor;
      scoreLine();
      text(name, width*0.85-180, height*0.8-barHeight-10);
    }
    else {
      strokeColor = defaultColor;
      fillColor = 0;
    }
  }
  
  void scoreLine() {
    strokeWeight(2);
    stroke(highlightColor);
    line(width*0.1-90, height*0.8-barHeight+1, width*0.85, height*0.8-barHeight+1);
    fill(highlightColor);
    textSize(14);
    text(score, width*0.1-90, height*0.8-barHeight-10);
  }
}
