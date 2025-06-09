void keyPressed() {
  if (key == 'A' || key == 'a')  akey = true;
  if (key == 'D' || key == 'd')  dkey = true;
  if (key == 'W' || key == 'w')  wkey = true;
  if (key == 'S' || key == 's')  skey = true;
  if (key == ' ' )  spacekey = true;
  if (keyCode == SHIFT )  shiftkey = true;
}

void keyReleased() {
  if (key == 'A' || key == 'a')  akey = false;
  if (key == 'D' || key == 'd')  dkey = false;
  if (key == 'W' || key == 'w')  wkey = false;
  if (key == 'S' || key == 's')  skey = false;
  if (key == ' ' )  spacekey = false;
  if (keyCode == SHIFT )  shiftkey = false;
}

boolean canMoveFoward(){
 pushMatrix();
  translate(eyeX,eyeY + blockSize,eyeZ);
  fill(0);
  box(blockSize);
  popMatrix();
  
  
 return true;
  
}
