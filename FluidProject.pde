
PShader fluidPass;
PShader displayPass;
PGraphics fluidBuffer;
PGraphics textBuffer;
float initialTime;

void setup() {
  initialTime = millis()/1000.0;
  size(480, 480, P3D);    
  //fullScreen(P3D);

  fluidBuffer = createGraphics(width, height, P2D);
  fluidBuffer.noSmooth();
  textBuffer = createGraphics(width, height, P2D);
  
  fluidPass = loadShader("strange-fluid.glsl");
  displayPass = loadShader("display.glsl");
  
  fluidPass.set("resolution", float(fluidBuffer.width), float(fluidBuffer.height));
}

void draw() {
  fluidPass.set("time", millis()/1000.0-initialTime);
  displayPass.set("time", millis()/1000.0-initialTime);
  float x = map(mouseX, 0, width, 0, 1);
  float y = map(mouseY, 0, height, 1, 0);
  
  textBuffer.beginDraw();
  textBuffer.textSize(width*0.35);
  textBuffer.textAlign(CENTER, CENTER);
  textBuffer.fill(0);
  textBuffer.rect(0, 0, textBuffer.width, textBuffer.height);
  textBuffer.fill(255);
  textBuffer.text("VOID", width/2, height/2);
  textBuffer.endDraw();
  
  fluidPass.set("textBuffer", textBuffer);
  fluidPass.set("mouse", x, y);
  fluidBuffer.beginDraw();
  fluidBuffer.background(0);
  fluidBuffer.shader(fluidPass);
  fluidBuffer.rect(0, 0, fluidBuffer.width, fluidBuffer.height);
  fluidBuffer.endDraw();
  
  displayPass.set("dataBuffer", fluidBuffer);
  shader(displayPass);
  image(fluidBuffer, 0, 0, width, height);
}
