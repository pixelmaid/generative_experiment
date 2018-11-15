
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

Controller scaleYSlider;
Controller scaleXSlider;
Controller patternWidthSlider;
Controller patternHeightSlider;
Controller verGapSlider;
Controller horzGapSlider;

void setup() {
  size(800, 800);

  //setup sliders
  cp5 = new ControlP5(this);

  patternWidthSlider =  cp5.addSlider("patternWidth")
    .setPosition(25, 25)
    .setRange(15, 200)
    ;
  patternWidthSlider.lock();

  patternHeightSlider = cp5.addSlider("patternHeight")
    .setPosition(25, 25*2)
    .setRange(15, 200)
    ;
  patternHeightSlider.lock();

  horzGapSlider =  cp5.addSlider("horzGap")
    .setPosition(25, 25*3)
    .setRange(-10, 100)
    ;

  horzGapSlider.lock();

  verGapSlider =  cp5.addSlider("verGap")
    .setPosition(25, 25*4)
    .setRange(-10, 100)
    ;

  verGapSlider.lock();

  scaleXSlider =  cp5.addSlider("scaleX")
    .setPosition(25, 25*5)
    .setRange(-10, 10)
    ;

  scaleXSlider.lock();

  scaleYSlider =    cp5.addSlider("scaleY")
    .setPosition(25, 25*6)
    .setRange(-10, 10)
    ;

  scaleYSlider.lock();

  // create a new button with name 'buttonA'
  cp5.addButton("generate")
    .setValue(0)
    .setPosition(25, 25*7)
    .setSize(150, 19)
    ;

  cp5.addButton("save")
    .setValue(0)
    .setPosition(25, 25*8)
    .setSize(150, 19)
    ;
}


void save() {
  saveOneFrame = true;
}

void generate() {

  patternWidth = random(15, 200);//57;
  patternWidthSlider.setValue(patternWidth);
  patternHeight =  random(15, 200);//50;
  patternHeightSlider.setValue(patternHeight);

  scaleX = random(-10, 10);//-2.4;
  scaleXSlider.setValue(scaleX);
  scaleY = random(-10, 10);
  scaleYSlider.setValue(scaleY);

  verGap =  random(-10, 100);
  verGapSlider.setValue(verGap);
  horzGap =  random(-10, 100);
  horzGapSlider.setValue(horzGap);
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

  noStroke();
  fill(0);
 
 //end PDF record
  if (saveOneFrame == false) {
    rect(10, 10, 200, 240);
  } else {
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
