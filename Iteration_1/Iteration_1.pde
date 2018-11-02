// Press q to cycle through a number of different random triangle designs
// This sketch is documented in my folio as Iteration 1

boolean nextFrame = false;

float largeRadius = 150;
float mediumRadius = 100;
float smallRadius = 50;
int cx;
int cy;
int numPoints = 20;

float[] x1Array = new float[numPoints];
float[] y1Array = new float[numPoints];



void setup() {
  size(640, 360);
  pixelDensity(2);
  background(200);
  noStroke();
  cx = width/2;
  cy = height/2;

  
}


void draw() {
  
  if (nextFrame == true) {
    background(200);
  float angleOff = TWO_PI/numPoints;
  float angle = 0;
  fill(0, 0, 150, 50);

  beginShape(TRIANGLE_STRIP);

  for (int i = 0; i <= numPoints - 1; i = i+1) {

    float x1 = cx + largeRadius * cos(angle);
    x1Array[i] = x1;
    float y1 = cy + largeRadius * sin(angle);
    y1Array[i] = y1;
    angle += angleOff;


    ellipse(x1Array[i], y1Array[i], 7, 7);
  }

  endShape(CLOSE);
  stroke(0);

  int rand1, rand2, rand3, rand4, rand5, rand6, rand7, rand8, rand9;

  // ----- First Triangle Point Calculation -----

  rand1 = int(random(0, numPoints));
  rand2 = int(random(0, numPoints));
  while (rand2 == rand1) {
    rand2 = int(random(0, numPoints));
  }
  rand3 = int(random(0, numPoints));
  while (rand3 == rand1 || rand3 == rand2) {
    rand3 = int(random(0, numPoints));
  }

  // ----- Second Triangle Point Calculation -----

  rand4 = rand1;
  rand5 = int(random(0, numPoints));
  while (rand5 == rand4) {
    rand5 = int(random(0, numPoints));
  }

  rand6 = int(random(0, numPoints));
  while (rand6 == rand5 || rand6 == rand4) {
    rand6 = int(random(0, numPoints));
  }

  // ----- Third Triangle Point Calculation -----
  rand7 = int(random(0, numPoints));
  rand8 = int(random(0, numPoints));
  while (rand8 == rand7) {
    rand8 = int(random(0, numPoints));
  }

  rand9 = int(random(0, numPoints));
  while (rand9 == rand7 || rand9 ==rand8) {
    rand9 = int(random(0, numPoints));
  }




  noStroke();

  // ----- First Triangle Create Shape -----
  fill(59, 59, 152);
  beginShape();
  vertex(x1Array[rand1], y1Array[rand1]);
  vertex(x1Array[rand2], y1Array[rand2]);
  vertex(x1Array[rand3], y1Array[rand3]);
  endShape(CLOSE);

  // ----- Second Triangle Create Shape -----
  fill(27, 156, 252);
  beginShape();
  vertex(x1Array[rand4], y1Array[rand4]);
  vertex(x1Array[rand5], y1Array[rand5]);
  vertex(x1Array[rand6], y1Array[rand6]);
  endShape(CLOSE);

  // ----- Third Triangle Create Shape -----
  fill(37, 204, 247);
  beginShape();
  vertex(x1Array[rand7], y1Array[rand7]);
  vertex(x1Array[rand8], y1Array[rand8]);
  vertex(x1Array[rand9], y1Array[rand9]);
  endShape(CLOSE);
 
 // saveFrame("line-######.png");
  
  nextFrame = false;
  
  }
}
void keyPressed () {
  if (key=='q') {
    nextFrame=!nextFrame;
  }
}
