// Press q to cycle through a number of different random triangle designs
// This sketch is documented in my folio as Iteration 2

boolean nextFrame = false;

float largeRadius = 150;
float mediumRadius = 100;
float smallRadius = 50;
int cx;
int cy;
int numPoints = 20;
float minDist;

float[] xArray = new float[numPoints];
float[] yArray = new float[numPoints];
int[] randArray = new int[3];

// ----- Points on longest chord -----
float x0;
float y0;
float x1;
float y1;
float x2;
float y2;
float x3; // Random x point along longest side
float y3; // Corresponding random y point along longest side
float x4;
float y4;
float x5; // lerpDist2
float y5; // lerpDist2


void setup() {
  size(640, 360);
  pixelDensity(2);
}



void draw() {
  noStroke();
  if (nextFrame == true) {
    background(200);
    cx = width/2;
    cy = height/2;

    float angleOff = TWO_PI/numPoints;
    float angle = 0;

    // ----- Calculating the points around a circle -----

    for (int i = 0; i <= numPoints - 1; i = i+1) {

      float x1 = cx + largeRadius * cos(angle);
      xArray[i] = x1;
      float y1 = cy + largeRadius * sin(angle);
      yArray[i] = y1;
      angle += angleOff;

      fill(0, 0, 150, 50);
      ellipse(xArray[i], yArray[i], 7, 7);
    }


    // ----- Calculate minimum chord length -----
    minDist = dist(xArray[0], yArray[0], xArray[3], yArray[3]);


    // ----- Calculation of random values -----
    // The random values are used as the indexes to access the arrays containing the coordinates of the points on the circle
    // The random values generated are stored in the array 'randArray' 

    int r = 0; // Variable 'r' steps through the indexes of the array

    int r1 = int(random(0, numPoints)); // Picks a random value to correspond with a point on the circle 
    randArray[r]=r1; // Stores the random value in randArray



    r = r+1; // Increment 'r' to move along randArray

    int r2 = int(random(0, numPoints)); // Picks a random value to correspond with a point on the circle 
    // While statement prevents the value of r2 from equaling r1
    // While statement also ensures point selected by r2 is a minimum distance from r1
    while (dist(xArray[r1], yArray[r1], xArray[r2], yArray[r2])<=minDist) { 
      r2 = int(random(0, numPoints)); // A new random value is picked if the minimum distance requirement is not met
    }
    randArray[r] = r2; // Stores the random value in randArray



    r = r+1; // Increment 'r' to move along randArray

    int r3 = int(random(0, numPoints));
    // While statement prevents the value of r3 from equaling r2 or r1
    // While statement also ensures point selected by r3 is a minimum distance from r2 and r1
    while ((dist(xArray[r2], yArray[r2], xArray[r3], yArray[r3]) <= minDist || (dist(xArray[r3], yArray[r3], xArray[r1], yArray[r1])) <= minDist)) {
      r3 = int(random(0, numPoints)); // A new random value is picked if the minimum distance requirement is not met
    }

    randArray[r]=r3; // Stores the random value in randArray

  

    // ----- First Triangle Create Shape -----
    // The first trinagle is created by stepping through the random values stored in the randomArray with a 'for' loop
    // These random values are used as the index values for the arrays which store the co-ordinates of the points of the circle
    noStroke();
    fill(59, 59, 152);
    beginShape();
    for (int i = 0; i<=2; i++) {  
      vertex(xArray[randArray[i]], yArray[randArray[i]]);
    }
    endShape(CLOSE);


    // ----- Isolating the longest edge -----
    float longestSide = 0;
    float sideLength = 0; // Stores the chord length of every len
    int longestSideIndex1 = 0;
    int longestSideIndex2 = 0;
    int remainingSideIndex = 0;

    for (int i = 0; i<=2; i++) {
      for (int j = 0; j<=2; j++) {
        // Calculates the distance between every point of the triangle
        // For loop ensures all combinations of points are accounted for
        // The previously generatd random values are used as the indexes for the arrays containing the co-ordinates of the points on the circle
        sideLength = dist(xArray[randArray[i]], yArray[randArray[i]], xArray[randArray[j]], yArray[randArray[j]]);
     

        if (sideLength>longestSide) {
          // 'if' statement identifes the longest side length by updating the 'longestSide' variable when it finds a side length that is longer than the previous
          longestSide = sideLength;
          longestSideIndex1 = i; // Takes the index value of the randomArray corresponding to the first point of the longest side
          longestSideIndex2 = j; // Takes the index value of the randomArray corresponding to the second point of the longest side

          // Identifiy the remaining point of the triangle in terms of its index value in the randomArray
          remainingSideIndex = 3 - (i+j);
        }
      }
    }

    // ----- Turning the array data into points that are easier to write/understand -----
    // First point of the longest side
    x0 = xArray[randArray[longestSideIndex1]];
    y0 = yArray[randArray[longestSideIndex1]];
    // Second point of the longest side
    x1 = xArray[randArray[longestSideIndex2]];
    y1 = yArray[randArray[longestSideIndex2]];
    // Final point of the triangle
    x2 = xArray[randArray[remainingSideIndex]];
    y2 = yArray[randArray[remainingSideIndex]];



    // ----- Calculating a point along the length of the longest side -----

    float lerpDist1 = (random(0.4, 0.8));


    x3 = lerp(x0, x1, lerpDist1);
    y3 = lerp(y0, y1, lerpDist1);



    // ----- Select another random point on the circle -----
    int r4 = int(random(0, numPoints));


    // ----- Check the side ratio of new triangle -----
    // Checking the ratio eliminates long thin triangles

    float benchMark = dist(x3, y3, x0, y0);

    while (dist(xArray[r4], yArray[r4], x0, y0)/benchMark>2 || dist(xArray[r4], yArray[r4], x3, y3)/benchMark>2) {
      r4 = int(random(0, numPoints));
    }

    // ----- Draw second triangle -----
    x4 = xArray[r4];
    y4 = yArray[r4];
    noStroke();
    fill(27, 156, 252);
    beginShape();
    vertex(x0, y0);
    vertex(x3, y3);
    vertex(x4, y4);
    endShape(CLOSE);


    // ----- Calculating the next lerp point interecting the second triangle -----

    float lerpDist2 = (random(0.4, 0.8));

    x5 = lerp(x3, x4, lerpDist1);
    y5 = lerp(y3, y4, lerpDist1);

    // ----- Select another random point on the circle -----
    int r5 = int(random(0, numPoints));


    fill(37, 204, 247);


    // ----- Draw third triangle -----
    beginShape();
    vertex(x3, y3);
    vertex(x5, y5);
    vertex(xArray[r5], yArray[r5]);
    endShape(CLOSE);


    // ----- Save each frame -----       
    // saveFrame("line-######.png");


    // ----- Reset next frame variable -----
    nextFrame = false;
  }
}
void keyPressed () {
  if (key=='q') {
    nextFrame=!nextFrame;
  }
}
