boolean wkey, akey, skey, dkey, spacekey, shiftkey;
float eyeX, eyeY, eyeZ, focX, focY, focZ, tiltX, tiltY, tiltZ;

int focusDistance = 600;
int speed = 20;
float LRheadAngle, UDheadAngle;
float mouseSen = 0.01;
//

void setup() {
  size(1000, 800, P3D);
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
  LRheadAngle = radians(270);
  noCursor();
}

void draw() {
  background(0);
  camera(eyeX, eyeY, eyeZ, focX, focY, focZ, tiltX, tiltY, tiltZ);
  drawLine();
  drawFocalPoint();
  controlCamera();
}

void drawFocalPoint() {
  pushMatrix();
  translate(focX, focY, focZ);
  sphere(5);


  popMatrix();
}

void controlCamera() {
  camera(eyeX, eyeY, eyeZ, focX, focY, focZ, tiltX, tiltY, tiltZ);
  if (wkey) eyeZ +=speed;
  if (skey) eyeZ-=speed;
  if (akey) eyeX += speed;
  if (dkey) eyeX-= speed;
  if (spacekey) eyeY-= speed;
  if (shiftkey) eyeY+= speed;

  LRheadAngle = LRheadAngle + (mouseX - pmouseX)* mouseSen;
  UDheadAngle = UDheadAngle + (mouseY - pmouseY)* mouseSen;
  if (UDheadAngle > PI/2.5) UDheadAngle = PI/2.5;
  if (UDheadAngle < -PI/2.5) UDheadAngle = -PI/2.5;

  focX = eyeX + cos(LRheadAngle) * focusDistance;
  focY = eyeY + tan(UDheadAngle) * focusDistance;
  focZ = eyeZ + sin(LRheadAngle) * focusDistance;
  println(eyeX, eyeY, eyeZ, focX, focY, focZ);
}

void drawLine() {
  stroke(255);
  for (int i = -4000; i < 4000; i+= 100) {
    line(i, height, -4000, i, height, 4000);
    line(-4000, height, i, 4000, height, i);
  }
}
