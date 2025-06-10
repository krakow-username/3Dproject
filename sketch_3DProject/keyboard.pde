void keyPressed() {
  if (key == 'A' || key == 'a')  akey = true;
  if (key == 'D' || key == 'd')  dkey = true;
  if (key == 'W' || key == 'w' )  wkey = true;
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

boolean canMoveFoward() {
  int mapx, mapy;
  int y = lastBlock;
  mapx = int(eyeX / blockSize);
  mapy = int(eyeZ/blockSize);
  color depth = depthMap.get((int)mapx, (int)mapy);
  if (depth == color(229, 134, 37)) y = height - 5*blockSize;
  if (depth ==  color(240, 174, 53)) y = height - 4*blockSize;
  if (depth == color (249, 218, 70)) y = height - 3*blockSize;
  if (depth == color(165, 224, 54)) y = height - 2*blockSize;
  if (depth == color(83, 197, 116)) y = height - 1*blockSize;
  if (depth == color(0, 138, 254))y = height ;
   y-= blockSize*3;
  if (eyeY-blockSize > y ) {
    return false;
  }
  return true;
}
