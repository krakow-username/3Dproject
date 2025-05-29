import java.awt.Robot;

color white = #FFFFFF;
color blue = #00F4FF;

boolean wkey, akey, skey, dkey, spacekey, shiftkey, skipFrame;
float eyeX, eyeY, eyeZ, focX, focY, focZ, tiltX, tiltY, tiltZ;
Robot rbt;
PImage map, miku, diamond;


int blockSize = 50;

int focusDistance = 600;
int speed = 50;
float LRheadAngle, UDheadAngle;
float mouseSen = 0.01;

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

  try {
    rbt = new Robot();
  }
  catch (Exception e) {
    e.printStackTrace();
  }
}

void draw() {
  background(0);
  camera(eyeX, eyeY, eyeZ, focX, focY, focZ, tiltX, tiltY, tiltZ);
  drawLine();
  drawFocalPoint();
  controlCamera();
  drawMap();
}

void drawMap() {
  for (int i = 0; i < miku.width; i++) {
    for (int j = 0; j < miku.height; j++) {
      color c =miku.get(i, j);
      if ( c == blue) {
         pushMatrix();
        noStroke();
        cubeD(i * blockSize - 2000, height, j * blockSize - 2000,diamond);
        popMatrix();
      } else if (c != white) {
        pushMatrix();
        translate(blockSize/2,blockSize/2,blockSize/2);
        fill(c);
        stroke(100);
        noStroke();
        translate(i * blockSize - 2000, height, j * blockSize - 2000);
        box(blockSize, blockSize, blockSize);
        popMatrix();
      }
    }
  }
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
