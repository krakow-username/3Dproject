import java.awt.Robot;

color white = #FFFFFF;
color blue = #00F4FF;
color top = color(229, 134, 37);
color sky =#A0F1F7;

Gif hatsune;

boolean wkey, akey, skey, dkey, spacekey, shiftkey, skipFrame;
float eyeX, eyeY, eyeZ, focX, focY, focZ, tiltX, tiltY, tiltZ;
Robot rbt;
PImage map, miku, diamond, depthMap;

float sunAngle = 3;
int blockSize = 100;
int gridSize = 8000;

int lastBlock = height;

int gravityAcc = 10;
int vy = 0;

int jumpCD = 0;
int jumpCDLimit = 20;

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
  hatsune = new Gif("ezgif-split/frame_", "_delay-0.03s.gif", 80, 100, 400, 600, 600, 1);
  wkey = akey = skey = dkey = false;
  eyeX = 0;
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
  lightSpecular(0, 0, 0);
  ambientLight(0, 0, 0);
  lightSpecular(255, 255, 255);

  map = loadImage("map.png");
  miku = loadImage("hatsune_miku_pixelart_by_magnet_crayon-d5v6fpj.png");
  diamond = loadImage("Diamond.png");
  depthMap = loadImage("output-onlinepngtools.png");

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
  background(sky);
  camera(eyeX, eyeY, eyeZ, focX, focY, focZ, tiltX, tiltY, tiltZ);
  drawLine();
  drawFocalPoint();
  controlCamera();
  sun();
  drawMap();
  // cord();
  gravity();
  hatsune.show();
}


void sun() {
  //lights();
  sunAngle = sunAngle + 0.005;
  ambientLight(50, 50, 50);
  //directionalLight(50, 50, 50, 0, -1, 0);

  pushMatrix();
  translate( sin(sunAngle)*8000, cos(sunAngle)*8000, 0);
  fill(#FFEA43);
  sphere(500);
  pointLight(255, 255, 255, 0, 510, 0);
  popMatrix();
  //println(suny);
  if (cos(sunAngle)*8000< -1000) {
    sky = lerpColor(#4334F5, #A0F1F7, map(cos(sunAngle)*8000, -1000, -8000, 0, 1));
  } else if (cos(sunAngle)*8000< height && cos(sunAngle)*8000 > -1000) {
    sky = lerpColor(#F54565, #4334F5, map(cos(sunAngle)*8000, height, -1000, 0, 1));
  } else {
    sky = lerpColor(#F54565, 0, map(cos(sunAngle)*8000, height, 8000, 0, 1));
  }
  //colorMode(HSB);
  //ambientLight(0, 255, 0);
  //colorMode(RGB);
  //spotLight(255,255,255,sunx + sin(sunAngle)*8000,suny + cos(sunAngle)*8000,0,0,0,0,90,0);

  //sky(eyeX,eyeY,eyeZ);

  //
  stroke(255);
  strokeWeight(10);
  line(0, height, 0, sin(sunAngle)*8000, cos(sunAngle)*8000, 0);
  strokeWeight(1);
}



void drawMap() {
  pushMatrix();
  //translate(blockSize/2, blockSize/2, blockSize/2);
  //translate(0, -blockSize, 0);
  for (int i = 0; i < depthMap.width; i++) {
    for (int j = 0; j < depthMap.height; j++) {
      color c =depthMap.get(i, j);
      color depth = depthMap.get(i, j);
      int y = lastBlock;
      //if (depth == color(229, 134, 37)) y = height - 5*blockSize;
      //if (depth ==  color(240, 174, 53)) y = height - 4*blockSize;
      //if (depth == color (249, 218, 70)) y = height - 3*blockSize;
      //if (depth == color(165, 224, 54)) y = height - 2*blockSize;
      //if (depth == color(83, 197, 116)) y = height - 1*blockSize;
      //if (depth == color(0, 138, 254))y = height ;
      if (depth == color(230, 138, 39)) y = height - 5*blockSize;
      if (depth ==  color(240, 175, 53)) y = height - 4*blockSize;
      if (depth == color (246, 218, 69)) y = height - 3*blockSize;
      if (depth == color(166, 224, 54)) y = height - 2*blockSize;
      if (depth == color(124, 210, 84)) y = height - 2*blockSize;
      if (depth == color(83, 197, 117)) y = height - 1*blockSize;
      if (depth == color(4, 141, 247))y = height ;
      lastBlock = y;

      if ( c == blue) {
        pushMatrix();
        noStroke();
        cubeD(i * blockSize, y, j * blockSize, diamond);
        popMatrix();
      } else if (c != white) {
        pushMatrix();
        translate(blockSize/2, blockSize/2, blockSize/2);
        fill(c);
        stroke(100);
        noStroke();
        translate(i * blockSize, y, j * blockSize );
        box(blockSize, blockSize, blockSize);
        popMatrix();
      }
    }
  }
  popMatrix();
}

void gravity() {
  //watch video
  //float fx, fy, fz;
  int mapx, mapy;
  int y = lastBlock;

  mapx = int(eyeX / blockSize);
  mapy = int(eyeZ/blockSize);

  color depth = depthMap.get((int)mapx, (int)mapy);
  //if (depth == color(229, 134, 37)) y = height - 5*blockSize;
  //if (depth ==  color(240, 174, 53)) y = height - 4*blockSize;
  //if (depth == color (249, 218, 70)) y = height - 3*blockSize;
  //if (depth == color(165, 224, 54)) y = height - 2*blockSize;
  //if (depth == color(83, 197, 116)) y = height - 1*blockSize;
  //if (depth == color(0, 138, 254))y = height ;

  if (depth == color(230, 138, 39)) y = height - 5*blockSize;
  if (depth ==  color(240, 175, 53)) y = height - 4*blockSize;
  if (depth == color (246, 218, 69)) y = height - 3*blockSize;
  if (depth == color(166, 224, 54)) y = height - 2*blockSize;
  if (depth == color(124, 210, 84)) y = height - 2*blockSize;
  if (depth == color(83, 197, 117)) y = height - 1*blockSize;
  if (depth == color(4, 141, 247))y = height ;
  //println(eyeY + " y " + y);
  //println(eyeX + " " + eyeZ);
  lastBlock = y;
  y-= blockSize*3;

  if (eyeY-blockSize < y ) {
    vy += gravityAcc;
  } else {
    eyeY = y + blockSize;
    vy=0;
  }
  eyeY+= vy;
}


void drawFocalPoint() {
  pushMatrix();
  translate(focX, focY, focZ);
  sphere(5);


  popMatrix();
}

void controlCamera() {
  camera(eyeX, eyeY, eyeZ, focX, focY, focZ, tiltX, tiltY, tiltZ);
  if (wkey && canMoveFoward()) {
    eyeZ += sin(LRheadAngle) *speed;
    eyeX += cos(LRheadAngle) * speed;
  }
  if (skey && canMoveFoward()) {
    eyeZ -= sin(LRheadAngle) *speed;
    eyeX -= cos(LRheadAngle) * speed;
  }
  if (akey && canMoveFoward()) {
    eyeZ += sin(LRheadAngle - PI/2) *speed;
    eyeX += cos(LRheadAngle - PI/2 ) * speed;
  }
  if (dkey && canMoveFoward() ) {
    eyeZ += sin(LRheadAngle + PI/2) *speed;
    eyeX += cos(LRheadAngle + PI/2 ) * speed;
  }
  if (spacekey && jumpCD <= 0) {
    eyeY -= 10;
    vy = -60;
    jumpCD = jumpCDLimit;
    
  }
  jumpCD--;
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

void cord() {
  stroke(#F23D3D);
  strokeWeight(10);
  line(0, 0, 0, 0, 5000, 0);
  sphere(10);
}


void drawLine() {
  stroke(255);
  strokeWeight(1);
  for (int i = -8000; i < 8000; i+= blockSize) {
    line(i, height, -8000, i, height, 8000);
    line(-8000, height, i, 8000, height, i);
  }
  noStroke();
}
