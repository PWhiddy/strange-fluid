
PShader bufferA;
PGraphics pg;
float initialTime;

void setup() {
  /// test
  initialTime = millis()/1000.0;
  //size(800, 800, P3D);    
  fullScreen(P3D);
  pg = createGraphics(width, height, P2D);
  pg.noSmooth();
  bufferA = loadShader("strange-fluid.glsl");
  bufferA.set("resolution", float(pg.width), float(pg.height));  
}

void draw() {
  bufferA.set("time", millis()/1000.0-initialTime);
  float x = map(mouseX, 0, width, 0, 1);
  float y = map(mouseY, 0, height, 1, 0);
  bufferA.set("mouse", x, y);  
  pg.beginDraw();
  pg.background(0);
  pg.shader(bufferA);
  pg.rect(0, 0, pg.width, pg.height);
  pg.endDraw();  
  image(pg, 0, 0, width, height);
}
