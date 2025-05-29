

void cubeD (float x, float y, float z, PImage texture){
  pushMatrix();
  translate(x, y, z);
  scale(blockSize);
  noStroke();
  
  beginShape(QUADS);
  texture(texture);
  //top
  vertex(0,0,0,0,0);
  vertex(1,0,0,1,0);
  vertex(1,0,1,1,1);
  vertex(0,0,1,0,1);
  //bottom
  vertex(0,1,0,0,0);
  vertex(1,1,0,1,0);
  vertex(1,1,1,1,1);
  vertex(0,1,1,0,1);
  //left
  vertex(0,0,0,0,0);
  vertex(0,0,1,1,0);
  vertex(0,1,1,1,1);
  vertex(0,1,0,0,1);
  //right
  vertex(1,0,0,0,0);
  vertex(1,0,1,1,0);
  vertex(1,1,1,1,1);
  vertex(1,1,0,0,1);
  //front
  vertex(0,0,1,0,0);
  vertex(1,0,1,1,0);
  vertex(1,1,1,1,1);
  vertex(0,1,1,0,1);
  //back
  vertex(0,0,0,0,0);
  vertex(1,0,0,1,0);
  vertex(1,1,0,1,1);
  vertex(0,1,0,0,1);
  
  endShape();
  popMatrix(); 
  
}
