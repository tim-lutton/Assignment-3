
boolean nextFrame = false;

float radius = 100;
int numPoints = 20;
float minDist;

// ----- Variables to store the new positions of circle centres -----
float nextCentreX; 
float nextCentreY;


// ----- Variables used to calculate angles -----
PVector a = new PVector(150, 0);
PVector b = new PVector(-40, 0);
float angle, arcangle;
float angleReflex;
float angleObtuse;
float angleAcute;
float angleGenerated;


// ----- Arrays to store the x,y coords of points on circle -----
float[] xArray = new float[numPoints];
float[] yArray = new float[numPoints];

// ----- Array to store random numbers used to index xArray and yArray -----
int[] randArray = new int[3];

// ----- Points on longest chord -----
float x0;
float y0;
float x1;
float y1;
float x2;
float y2;


void setup() {
  size(640, 360);
  pixelDensity(2);

  background(200);
  translate(width/2, height/2);

  float angleOff = TWO_PI/numPoints;
  float angle = 0;

  // ----- Calculating the points around a circle -----

  for (int i = 0; i <= numPoints - 1; i = i+1) {

    float x1 =  radius * cos(angle);
    xArray[i] = x1;
    float y1 =  radius * sin(angle);
    yArray[i] = y1;
    angle += angleOff;

    fill(0, 0, 150, 50);
    ellipse(xArray[i], yArray[i], 3, 3);
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



  // ----- First Triangle Point Drawing -----

  fill(255, 0, 0, 50); 
  ellipse(xArray[r1], yArray[r1], 20, 20); 
  fill(0, 255, 0, 50); 
  ellipse(xArray[r2], yArray[r2], 20, 20);
  //fill(0, 0, 255, 50); 
  //ellipse(xArray[r3], yArray[r3], 20, 20); 

  line(xArray[r1], yArray[r1], xArray[r2], yArray[r2]);

  // ----- Calculate Midpoint -----
  float midPointX = lerp(xArray[r1], xArray[r2], 0.5); // Midpoint of chord x coordinate
  float midPointY = lerp(yArray[r1], yArray[r2], 0.5); // Midpoint of chord y coordinate
  float distCentre = dist(midPointX, midPointY, 0, 0);

  line(midPointX, midPointY, 0, 0);
  ellipse(midPointX, midPointY, 7, 7);

  // ----- Calculate angle between (midPointX, midPointY) -----
  b.set(midPointX, midPointY); // Change PVector b to location on midpoint of chord
  angleGenerated = PVector.angleBetween(a, b); // Calculate the angle btw the new location of PVector 'b' and PVector 'a' (which is at 0 degrees)

  float distBetweenCentres = 2*distCentre;
  fill(255, 255, 0);

  fill (255, 255, 0);
  if ( b.x >= 0 && b.y <= 0) {
    angleAcute = angleGenerated;
    nextCentreX = distBetweenCentres*cos(angleAcute);
    nextCentreY = -1*(distBetweenCentres*sin(angleAcute));
    ellipse (nextCentreX, nextCentreY, 10, 10);
  } else if (b.x <= 0 && b.y <= 0) {
    angleAcute = PI - angleGenerated;
    nextCentreX = -1*(distBetweenCentres*cos(angleAcute));
    nextCentreY = -1*(distBetweenCentres*sin(angleAcute));
  } else if (b.x <= 0 && b.y >= 0) {
    angleAcute = PI - angleGenerated;
    nextCentreX = -1*(distBetweenCentres*cos(angleAcute));
    nextCentreY = distBetweenCentres*sin(angleAcute);
  } else if (b.x >= 0 && b.y >= 0) {
    angleAcute = angleGenerated;
    nextCentreX = distBetweenCentres*cos(angleAcute);
    nextCentreY = distBetweenCentres*sin(angleAcute);
  }

  ellipse(nextCentreX, nextCentreY, 10, 10);
}
