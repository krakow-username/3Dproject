class Gif {

  String a, b;
  public PImage[] gif;
  int NumOfFrames, f, x, y, Sw, Sh, speed;

  Gif(String _a, String _b, int _NumOfFrames, int _x, int _y, int _Sw, int _Sh, int _speed) {
    a = _a;
    b = _b;
    NumOfFrames = _NumOfFrames;
    x = _x;
    y = _y;
    Sw = _Sw;
    Sh = _Sh;
    f=0;
    speed = _speed;

    gif = new PImage [NumOfFrames];
    for (int i =0; i <NumOfFrames; i++) {
      if (i<10) {
        gif[i] = loadImage(a+"0"+i+b);
        gif[i].resize(Sw, Sh);
      } else {
        gif[i] = loadImage(a+i+b);
        gif[i].resize(Sw, Sh);
      }
    }
  }

  void show() {
    imageMode(CENTER);
    pushMatrix();
    translate(x, y,100);
    lights();
    scale(blockSize*3);
    beginShape(QUADS);
    texture(gif[f]);
    vertex(0, 0, 1, 0, 0);
    vertex(1, 0, 1, 1, 0);
    vertex(1, 1, 1, 1, 1);
    vertex(0, 1, 1, 0, 1);
    endShape();
    popMatrix();
    if (frameCount % speed == 0) f++;
    if (f > NumOfFrames -1) {
      f = 0;
    }
  }
}
