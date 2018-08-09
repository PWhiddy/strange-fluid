
PShader fluidPass;
PShader displayPass;
PGraphics fluidBuffer;
PGraphics displayBuffer;
float initialTime;

void setup() {
  initialTime = millis()/1000.0;
  size(400, 400, P3D);    
  //fullScreen(P3D);
  fluidBuffer = createGraphics(400,400,P2D);//width, height, P2D);
  fluidBuffer.noSmooth();
  displayBuffer = createGraphics(400,400,P2D);//width, height, P2D);
  displayBuffer.noSmooth();
  
  fluidPass = loadShader("strange-fluidFrag.glsl");
  displayPass = loadShader("displayFrag.glsl");
  
  fluidPass.set("resolution", float(fluidBuffer.width), float(fluidBuffer.height));
  displayPass.set("resolution", float(displayBuffer.width), float(displayBuffer.height));
  
}

void draw() {
  //background(0);
  fluidPass.set("time", millis()/1000.0-initialTime);
  displayPass.set("time", millis()/1000.0-initialTime);
  float x = map(mouseX, 0, width, 0, 1);
  float y = map(mouseY, 0, height, 1, 0);
  
  fluidPass.set("mouse", x, y);
  fluidBuffer.beginDraw();
  fluidBuffer.shader(fluidPass);
  fluidBuffer.rect(0, 0, fluidBuffer.width, fluidBuffer.height);
  fluidBuffer.endDraw();  
  
  displayPass.set("mouse", x, y);
  displayBuffer.beginDraw();
  displayBuffer.shader(displayPass);
  displayBuffer.image(fluidBuffer, 0, 0);
  displayBuffer.endDraw();
  
  image(displayBuffer, 0, 0, width, height);
}
