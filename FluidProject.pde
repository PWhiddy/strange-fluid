
PShader fluidPass;
PGraphics fluidBuffer;
float initialTime;

void setup() {
  initialTime = millis()/1000.0;
  //size(800, 800, P3D);    
  fullScreen(P3D);
  fluidBuffer = createGraphics(width, height, P2D);
  fluidBuffer.noSmooth();
  fluidPass = loadShader("strange-fluid.glsl");
  fluidPass.set("resolution", float(fluidBuffer.width), float(fluidBuffer.height));
}

void draw() {
  fluidPass.set("time", millis()/1000.0-initialTime);
  float x = map(mouseX, 0, width, 0, 1);
  float y = map(mouseY, 0, height, 1, 0);
  fluidPass.set("mouse", x, y);  
  fluidBuffer.beginDraw();
  fluidBuffer.background(0);
  fluidBuffer.shader(fluidPass);
  fluidBuffer.rect(0, 0, fluidBuffer.width, fluidBuffer.height);
  fluidBuffer.endDraw();  
  image(fluidBuffer, 0, 0, width, height);
}
