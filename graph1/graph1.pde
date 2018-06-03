import controlP5.*;
import grafica.*;



ControlP5  cp5;
DropdownList d1,d2,d3;
Slider     S1,S2,S3;
int        cnt=0;
int        NumberPoints=400; //Number of points
float      Xintital=-10.0;
float      Delta=1.0;                        //linespace between each point
float[]    X=new float[NumberPoints];       
float[]    Y=new float[NumberPoints];
float      xSpace=0.01;
FloatList  xPoints;
FloatList  yPoints;
int        sliderValue = 100;
int        sliderTicks1 = 100;
int        sliderTicks2 = 30;
int        Delaytime=40;
boolean    flag=false;
boolean    run=false;
float      scale=          5;
int lastStepTime=          0;    
boolean    clockwise=      true;
// Graph details
static final float RADIUS=15;      // Size of animated discs in pixels.
static final int graphSize = 400;  // Width and height of graph in pixels.
float      px=0.1, py=0.1;
GPlot      lineChart;
int        ChartOffset=0;
PVector    origin = new PVector(0,0);
Slider     abc;
int        step=0;
int        stepsPerCycle=100;


void setup(){
  size(1000,600,P2D);
  origin.set(width/3,height/8);
  textFont(loadFont("Crimson-Italic-24.vlw"));
  textAlign(RIGHT,TOP);
  cp5=new ControlP5(this);
  xPoints=new FloatList();
  yPoints=new FloatList();
  lastStepTime=millis();

  
  d1=cp5.addDropdownList("Graph lists")
       .setPosition(100,100);
       customize(d1); // customize the first list
       
  S1=cp5.addSlider("sliderValue")
     .setPosition(100,200)
     .setRange(0,255)
     .setSize(200,20)
     .setValue(128)
     //.setNumberOfTickMarks(7)
     .setSliderMode(Slider.FLEXIBLE)
     ;
     
     
    // create a new button with name 'buttonA'
  cp5.addButton("RUN")
     .setValue(0)
     .setPosition(100,300)
     .setSize(200,19)
     .setColorBackground(color(20,200,0))
     ;
  
  // and add another 2 buttons
  cp5.addButton("STOP")
     .setValue(100)
     .setPosition(100,320)
     .setSize(200,19)
     .setColorBackground(color(200,12,0))
     ;
  Xvalues();
  Yvalues(X);
  Graphing(X,Y);
  flag=true;
}
void customize(DropdownList d1) {
  // a convenience function to customize a DropdownList
  d1.setBackgroundColor(color(190));
  d1.setItemHeight(60);
  d1.setBarHeight(30);
  d1.setWidth(200);
  //.captionLabel().set("dropdown");
  //ddl.captionLabel().style().marginTop = 3;
  //ddl.captionLabel().style().marginLeft = 3;
  //ddl.valueLabel().style().marginTop = 3;
  for (int i=1;i<6;i++) {
    d1.addItem("item "+i, i);
  }
  //ddl.scroll(0);
  d1.setColorBackground(color(204,102,40));
  d1.setColorActive(color(80, 220,100));
}

void keyPressed() {
  // some key events to change the properties of DropdownList d1

}

void controlEvent(ControlEvent theEvent) {
  // DropdownList is of type ControlGroup.
  // A controlEvent will be triggered from inside the ControlGroup class.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message thrown by controlP5.
  //println(S1.getValue());
  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  } 
  else if (theEvent.isController()) {
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
  }
}

void draw() {
  background(255);
  lineChart.beginDraw();
  lineChart.drawBackground();
  lineChart.drawBox();
  lineChart.drawXAxis();
  lineChart.drawYAxis();
  lineChart.drawTopAxis();
  lineChart.drawRightAxis();
  lineChart.drawTitle();
  lineChart.getMainLayer().drawPoints();
  lineChart.endDraw();

  if (run){
      if (millis() - lastStepTime > Delaytime) {
        if (clockwise) {
          if (step<NumberPoints){
          // Add the point at the end of the array
              lineChart.addPoint(0,calculatePoint(X[step],Y[step]));
              println(step,X[step],Y[step]);
    
              step++;
          }
          // Remove the first point
          //lineChart.removePoint(0);
        }
        else {
         // if (step>0&&step<400){
          // Add the point at the beginning of the array
         // lineChart.addPoint(0, calculatePoint(X[step],Y[step]));
            step--;
            if (step>0){
              println(step);
            }
          //}
          // Remove the last point
         // lineChart.removePoint(lineChart.getPointsRef().getNPoints() - 1);
        }
    
        lastStepTime = millis();
      }
  }
      //lineChart.getLayer("surface").drawFilledContour(GPlot.HORIZONTAL, 0);
  //}
     //if (run){
     //  step=0;
     //  run=false;
     //}
     //Graphing(X,Y);
}

//void mouseClicked() {
  // Change the movement sense
//  clockwise = !clockwise;

//  if (clockwise) {
  //  step=0;
//    //step += lineChart.getPointsRef().getNPoints() + 1;
//    lineChart.setTitleText("Clockwise movement");
//  } 
//  else {
//    step=400;
//    //step -= lineChart.getPointsRef().getNPoints() + 1;
//    lineChart.setTitleText("Anti-clockwise movement");
//  }
//}

GPoint calculatePoint(float i, float n) {
//  float delta = 0.1*cos(TWO_PI*10*i/n);
//  float ang = TWO_PI*i/n;
  return new GPoint(i, n);
}

public void Graphing(float[] X,float[] Y)
{
  lineChart = new GPlot(this);
  println(origin.x);
  lineChart.setPos(origin.x, origin.y);
  lineChart.setDim(graphSize*1.3, graphSize);
  // or all in one go
  // plot = new GPlot(this, 25, 25, 300, 300);

  // Set the plot limits (this will fix them)
  //lineChart.setXLim(-1.2*scale, 1.2*scale);
  //lineChart.setYLim(-1.2*scale, 1.2*scale);
  lineChart.activateZooming(1.3, CENTER, CENTER);
  // Set the plot title and the axis labels
  lineChart.setTitleText("Clockwise movement");
  lineChart.getXAxis().setAxisLabelText("x axis");
  lineChart.getYAxis().setAxisLabelText("y axis");

  // Activate the panning effect
  lineChart.activatePanning();

  // Add the two set of points to the plot
  GPointsArray Xpoints=new GPointsArray(NumberPoints);
  //Xpoints.add(X);
  //lineChart.setPoints(X);
  //lineChart.addLayer("surface", Y);

  // Change the second layer line color
  //lineChart.getLayer("surface").setLineColor(color(100, 255, 100));
    lineChart.activateReset();

}
void Xvalues(){
  X[0]=Xintital;
  for(int i=1;i<NumberPoints;i++){
     X[i]=xSpace+X[i-1];
  }
  
}


void Yvalues(float[] X){
 for (int x = 0; x < X.length; x++) {
   Y[x]=sin(2*3.4*X[x]);
 }
}

public void RUN(){

  if (flag){
        delay(100);
        Graphing(X,Y);
        step=0;
        run=true;
   }
}

public void STOP(){
  Graphing(X,Y);
  run=false;
}
