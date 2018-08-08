
PShader fluidPass;
PShader displayPass;
PGraphics fluidBuffer;
PGraphics displayBuffer;
float initialTime;

void setup() {
  initialTime = millis()/1000.0;
  //size(800, 800, P3D);    
  fullScreen(P3D);
  fluidBuffer = createGraphics(width, height, P2D);
  fluidBuffer.noSmooth();
  displayBuffer = createGraphics(width, height, P2D);
  displayBuffer.noSmooth();
  
  fluidPass = loadShader("strange-fluid.glsl");
  displayPass = loadShader("display.glsl");
  
  fluidPass.set("resolution", float(fluidBuffer.width), float(fluidBuffer.height));
  displayPass.set("resolution", float(displayPass.width), float(displayPass.height));
}

void draw() {
  fluidPass.set("time", millis()/1000.0-initialTime);
  displayPass.set("time", millis()/1000.0-initialTime);
  float x = map(mouseX, 0, width, 0, 1);
  float y = map(mouseY, 0, height, 1, 0);
  fluidPass.set("mouse", x, y);
  fluidBuffer.beginDraw();
  fluidBuffer.background(0);
  fluidBuffer.shader(fluidPass);
  fluidBuffer.rect(0, 0, fluidBuffer.width, fluidBuffer.height);
  fluidBuffer.endDraw();  
  
  displayBuffer.beginDraw();
  displayBuffer.image(fluidBuffer, 0, 0);
  //displayBuffer.background(0);
  displayBuffer.shader(displayPass);
  //displayBuffer.rect(0,0, displayBuffer.width, displayBuffer.height);
  displayBuffer.endDraw();
  
  image(displayBuffer, 0, 0, width, height);
}
