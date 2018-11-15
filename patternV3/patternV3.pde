
import controlP5.*;
import processing.pdf.*;
ControlP5 cp5;


boolean saveOneFrame = false;

float patternWidth = 57;
float patternHeight = 50;
float scaleX =-2.5;
float scaleY = 1.5;
float verGap = 0;
float horzGap = 0;

void setup() {
  size(800, 800);

  //setup save button
  cp5 = new ControlP5(this);
 
  cp5.addButton("save")
    .setValue(0)
    .setPosition(25, 25)
    .setSize(150, 19)
    ;
}


void draw() {
  //begin PDF record
  if (saveOneFrame == true) {
    beginRecord(PDF, "design"+millis()+".pdf");
  }
  
  //set background to black
  background(0);

  //calculate x and y repeat count
  int xRepeat = max(100, ceil(width/(patternWidth+verGap)));
  int yRepeat =  max(100, ceil(height/(patternHeight+horzGap)));

  
  //nested loop
  for (int j=0; j<yRepeat; j++) {

    for (int i=0; i<xRepeat; i++) {
      float sw = max(1, horzGap/5);

      //begin matrix transformation
      pushMatrix();
     
      translate(i*(patternWidth+verGap), j*(patternHeight+horzGap));
      
      bezier(patternWidth, patternHeight, scaleX, scaleY, sw);
      bezier(-patternWidth, patternHeight, scaleX, scaleY, sw);
      
      noFill();
      
      strokeWeight(sw);

      line(0, (patternHeight+horzGap), width, (patternHeight+horzGap));
      popMatrix();
      //end matrix transformation
    }
  }

 
 //end PDF record
  if (saveOneFrame == true) {
    endRecord();
    saveOneFrame = false;
  }
}


//bezier pattern function
void bezier(float patternWidth, float patternHeight, float scaleX, float scaleY, float sw) {
  //calculate stroke weight
  strokeWeight(max(0.5, sw*0.25));
  
  //set stroke color
  stroke(255);
  noFill();
  
  //draw bezier curve
  bezier(0, 0, -patternWidth*scaleX, patternHeight*scaleY, patternWidth*scaleX, patternHeight*scaleY, 0, patternHeight*2);
}


void save(){
  print("save");
  saveOneFrame = true;
}
