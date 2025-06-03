 import java.awt.Robot;

color white = #FFFFFF;
color blue = #00F4FF;
color top = color(229, 134, 37);

boolean wkey, akey, skey, dkey, spacekey, shiftkey, skipFrame;
float eyeX, eyeY, eyeZ, focX, focY, focZ, tiltX, tiltY, tiltZ;
Robot rbt;
PImage map, miku, diamond, depthMap;

float sunAngle;
int blockSize = 50;
int gridSize = 4000;

int focusDistance = 600;
int speed = 50;
float LRheadAngle, UDheadAngle;
float mouseSen = 0.01;

  int sunx = 0;
  int suny = 0 ;

void setup() {
  fullScreen(P3D);
  //size(1000, 800, P3D);
  textureMode(NORMAL);
  wkey = akey = skey = dkey = false;
  eyeX = width/2;
  eyeY = 500;
  eyeZ = 0;
  focX = width/2;
  focY = height/2;
  focZ = focusDistance;
  tiltX = 0;
  tiltY = 1;
  tiltZ = 0;
  skipFrame = false;
  LRheadAngle = radians(270);
  noCursor();

  map = loadImage("map.png");
  miku = loadImage("hatsune_miku_pixelart_by_magnet_crayon-d5v6fpj.png");
  diamond = loadImage("Diamond.png");
  depthMap = loadImage("R.png");

  try {
    rbt = new Robot();
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

void draw() {
  //lights();
  //pointLight(255,255,255,eyeX,eyeY,eyeZ);
  background(0);
  camera(eyeX, eyeY, eyeZ, focX, focY, focZ, tiltX, tiltY, tiltZ);
  drawLine();
  drawFocalPoint();
  controlCamera();
  drawMap();
  sun();
}


void sun(){
  lights();
  sunAngle = sunAngle + 0.05;

  
  pushMatrix();
  translate(sunx + sin(sunAngle)*8000,suny + cos(sunAngle)*8000,0);
  sphere(500);
  //pointLight(255,255,255,0,0 ,0);
  popMatrix();
  
  //spotLight(255,255,255,sunx + sin(sunAngle)*8000,suny + cos(sunAngle)*8000,0,0,0,0,90,0);
  
}



void drawMap() {
  pushMatrix();
  translate(0,-blockSize,0);
  for (int i = 0; i < miku.width; i++) {
    for (int j = 0; j < miku.height; j++) {
      color c =miku.get(i, j);
      color depth = depthMap.get(i,j);
      int y = height;
      if (depth == color(229, 134, 37)) y = height - 5*blockSize/2;
      if (depth ==  color(240,174,53)) y = height - 4*blockSize/2;
      if (depth == color (249,218,70)) y = height - 3*blockSize/2;
      if (depth == color(165,224,54)) y = height - 2*blockSize/2;
      if (depth == color(83,197,116)) y = height - 1*blockSize/2;
      if (depth == color(0,138,254))y = height ;
      
      if ( c == blue) {
         pushMatrix();
        noStroke();
        cubeD(i * blockSize - gridSize, y, j * blockSize - gridSize,diamond);
        popMatrix();
      } else if (c != white) {
        pushMatrix();
        translate(blockSize/2,blockSize/2,blockSize/2);
        fill(c);
        stroke(100);
        noStroke();
        translate(i * blockSize - gridSize, y, j * blockSize - gridSize);
        box(blockSize, blockSize, blockSize);
        popMatrix();
      }
    }
  }
  popMatrix();
}

void drawFocalPoint() {
  pushMatrix();
  translate(focX, focY, focZ);
  sphere(5);


  popMatrix();
}

void controlCamera() {
  camera(eyeX, eyeY, eyeZ, focX, focY, focZ, tiltX, tiltY, tiltZ);
  if (wkey) {
    eyeZ += sin(LRheadAngle) *speed;
    eyeX += cos(LRheadAngle) * speed;
  }
  if (skey) {
    eyeZ -= sin(LRheadAngle) *speed;
    eyeX -= cos(LRheadAngle) * speed;
  }
  if (akey) {
    eyeZ += sin(LRheadAngle - PI/2) *speed;
    eyeX += cos(LRheadAngle - PI/2 ) * speed;
  }
  if (dkey) {
    eyeZ += sin(LRheadAngle + PI/2) *speed;
    eyeX += cos(LRheadAngle + PI/2 ) * speed;
  }
  if (spacekey) eyeY-= speed;
  if (shiftkey) eyeY+= speed;

  if (!skipFrame) {
    LRheadAngle = LRheadAngle + (mouseX - pmouseX)* mouseSen;
    UDheadAngle = UDheadAngle + (mouseY - pmouseY)* mouseSen;
  }
  if (UDheadAngle > PI/2.5) UDheadAngle = PI/2.5;
  if (UDheadAngle < -PI/2.5) UDheadAngle = -PI/2.5;

  focX = eyeX + cos(LRheadAngle) * focusDistance;
  focY = eyeY + tan(UDheadAngle) * focusDistance;
  focZ = eyeZ + sin(LRheadAngle) * focusDistance;
  //println(eyeX, eyeY, eyeZ, focX, focY, focZ);

  if (mouseX < 2) {
    rbt.mouseMove(width-3, mouseY);
    skipFrame= true;
  } else if (mouseX > width - 2) {
    rbt.mouseMove(3, mouseY);
    skipFrame = true;
  } else {
    skipFrame = false;
  }
}

void drawLine() {
  stroke(255);
  for (int i = -4000; i < 4000; i+= blockSize) {
    line(i, height, -4000, i, height, 4000);
    line(-4000, height, i, 4000, height, i);
  }
}
