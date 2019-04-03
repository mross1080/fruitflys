
import processing.video.*;

Capture ourVideo;                                 // variable to hold the video object
void setup() {
  size(1280, 720);
  frameRate(120);
  ourVideo = new Capture(this, width, height);    // open the capture in the size of the window
  ourVideo.start();                               // start the video
}

void draw() {
  if (ourVideo.available())  ourVideo.read();      // get a fresh frame as often as we can
  image(ourVideo,0,0);                            // we will be bluring just a circle of pixels, so draw the whole video to the screen
                                    //  must call updatePixels oce were done messing with pixels[]
    int fillAmount = 220;
    int  cellSize = 80;
      loadPixels();                 
int blurAmount = 800;
//int blurAmount = mouseX;
  // load the pixels array of the window 
  
    for (int x = 0; x<width; x++) {
    for (int y = 0; y<height; y++) {
      PxPGetPixel(x,y,ourVideo.pixels, width);                 // get the RGB of our pixel
      R+=blurAmount-width/2;                              // add the same amount to R,G,B to adjuast the brightness
      G+=blurAmount-width/2;
      B+=blurAmount-width/2;
      R= constrain(R,0,255);                          // make sure the values of R,G, are between 0-255
      G= constrain(G,0,255);
      B= constrain(B,0,255);
      
      //PxPSetPixel(x,y, R, G, B, 255, pixels, width);    // sets the R,G,B values to the window
    }
  }
  updatePixels();                                    //  must call updatePixels oce were done messing with pixels[]
  

    for (int x = 0; x < width/2 ; x+=cellSize/2){
     for (int y = 0; y < height; y+=cellSize/2){
       
       PxPGetPixel(x,y,ourVideo.pixels, width);    
       R+=blurAmount-width/2;                              // add the same amount to R,G,B to adjuast the brightness
      G+=blurAmount-width/2;
      B+=blurAmount-width/2;
      R= constrain(R,0,255);                          // make sure the values of R,G, are between 0-255
      G= constrain(G,0,255);
      B= constrain(B,0,255);
        
       fill(R, G, B,constrain(fillAmount,0,255));
              stroke(R,G,B);

       ellipse(x, y, cellSize, cellSize);
     }
  }  
  
  
  int ellipseSize = cellSize/2;
  println(fillAmount);

      for (int x = width-cellSize/2; x > width/2 - ellipseSize; x-=cellSize/2){
     for (int y = height-cellSize/2; y > 0 ; y-=cellSize/2){
       PxPGetPixel(x,y,ourVideo.pixels, width);    
       R+=blurAmount-width/2;                              // add the same amount to R,G,B to adjuast the brightness
      G+=blurAmount-width/2;
      B+=blurAmount-width/2;
      R= constrain(R,0,255);                          // make sure the values of R,G, are between 0-255
      G= constrain(G,0,255);
      B= constrain(B,0,255);
        
       fill(R, G, B,constrain(fillAmount,0,255));
       stroke(R,G,B);
       ellipse(x, y, cellSize, cellSize);
     }
  }  


  
}



// our function for getting color components , it requires that you have global variables
// R,G,B   (not elegant but the simples way to go, see the example PxP methods in object for 
// a more elegant solution
int R, G, B, A;          // you must have these global varables to use the PxPGetPixel()
void PxPGetPixel(int x, int y, int[] pixelArray, int pixelsWidth) {
  int thisPixel=pixelArray[x+y*pixelsWidth];     // getting the colors as an int from the pixels[]
  A = (thisPixel >> 24) & 0xFF;                  // we need to shift and mask to get each component alone
  R = (thisPixel >> 16) & 0xFF;                  // this is faster than calling red(), green() , blue()
  G = (thisPixel >> 8) & 0xFF;   
  B = thisPixel & 0xFF;
}


//our function for setting color components RGB into the pixels[] , we need to efine the XY of where
// to set the pixel, the RGB values we want and the pixels[] array we want to use and it's width

void PxPSetPixel(int x, int y, int r, int g, int b, int a, int[] pixelArray, int pixelsWidth) {
  a =(a << 24);                       
  r = r << 16;                       // We are packing all 4 composents into one int
  g = g << 8;                        // so we need to shift them to their places
  color argb = a | r | g | b;        // binary "or" operation adds them all into one int
  pixelArray[x+y*pixelsWidth]= argb;    // finaly we set the int with te colors into the pixels[]
}
