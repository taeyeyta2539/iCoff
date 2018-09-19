
import controlP5.*;
import processing.serial.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;



ControlP5 cp5;

Button on_button;
DropdownList d1, d2 , d3;
DropdownList ind[] = {};
char c = '0';
int cnt = 0;
Serial myPort; 
String val = "0";     // Data received from the serial port
////////////////////////////////////////////////////////////////
class Timer {
 
  int savedTime; // When Timer started
  int totalTime; // How long Timer should last
  
  Timer(int tempTotalTime) {
    totalTime = tempTotalTime;
  }
  
  // Starting the timer
  void start() {
    // When the timer starts it stores the current time in milliseconds.
    savedTime = millis(); 
  }
  
  // The function isFinished() returns true if 5,000 ms have passed. 
  // The work of the timer is farmed out to this method.
  boolean isFinished() { 
    // Check how much time has passed
    int passedTime = millis()- savedTime;
    if (passedTime > totalTime) {
      return true;
    } else {
      return false;
    }
  }
}
////////////////////////////////////////////////////////////////
Timer timer;

void setup() {
  timer = new Timer(3000);
  
  size(700, 400 );
  noStroke();
  cp5 = new ControlP5(this);
  
  
  
  
  
  // DropdownList is DEPRECATED, 
  // use ScrollableList instead, 
  // see example ControlP5scrollableList

  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  // create a DropdownList, 
  
          
  
  
  d3 = cp5.addDropdownList("myList-d3")
          .setPosition(400, 100)
          .setSize(100,100)
          .close();
          ;
  customize3(d3); // customize the second list
  
  d1 = cp5.addDropdownList("myList-d1")
          .setPosition(100, 100)
          .close();
          ;
          
  customize(d1); // customize the first list
  
  // create a second DropdownList
  d2 = cp5.addDropdownList("myList-d2")
          .setPosition(250, 100)
          .setSize(100,100)
          .close();
          ;
  customize2(d2); // customize the second list
  

          
  cp5.addButton("submit")
     .setValue(1)
     .setPosition(300,300)
     .setSize(100,19)
     ;
  
}



void customize(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.getCaptionLabel().set("Coffee Beans");
  ddl.addItem("Empty ",0);
  ddl.addItem("Arabica ",1);
  ddl.addItem("Robusta ",2);
  ddl.addItem("Thai ",3);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}

void customize2(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.getCaptionLabel().set("Milk");
  ddl.addItem("Empty ",0);
  ddl.addItem("Milk ",1);
  ddl.addItem("Goat milk ",2);
  ddl.addItem("Creamer ",3);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}

void customize3(DropdownList ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.getCaptionLabel().set("Sweetness");
  ddl.addItem("No sugar ",0);
  ddl.addItem("Low ",1);
  ddl.addItem("Medium ",2);
  ddl.addItem("High ",3);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}



void keyPressed() {
  // some key events to change the properties of DropdownList d1
  if (key=='1') {
    // set the height of a pulldown menu, should always be a multiple of itemHeight
    d1.setHeight(210);
  } 
  else if (key=='2') {
    // set the height of a pulldown menu, should always be a multiple of itemHeight
    d1.setHeight(120);
  }
  else if (key=='3') {
    // set the height of a pulldown menu item, should always be a fraction of the pulldown menu
    d1.setItemHeight(30);
  } 
  else if (key=='4') {
    // set the height of a pulldown menu item, should always be a fraction of the pulldown menu
    d1.setItemHeight(12);
    d1.setBackgroundColor(color(255));
  } 
  else if (key=='5') {
    // add new items to the pulldown menu
    int n = (int)(random(100000));
    d1.addItem("item "+n, n);
  } 
  else if (key=='6') {
    // remove items from the pulldown menu  by name
    d1.removeItem("item "+cnt);
    cnt++;
  }
  else if (key=='7') {
    d1.clear();
  }
}

int seed = 1;
int milk;
String data[]=  {"0","0","0"};
String dataInd[] = {"0","0","0"};
String percentInd[]= {"0","0","0"};

String data1;
String data2;
String data3;
String dataAll2 = "";


void controlEvent(ControlEvent theEvent) {
  
  
String dataAll = "";

  
  // DropdownList is of type ControlGroup.
  // A controlEvent will be triggered from inside the ControlGroup class.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message thrown by controlP5.

  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    //println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  } 
  else if (theEvent.isController()) {
    //println("event from controller : "+int(theEvent.getController().getValue())+" from "+theEvent.getController());
  }
  
  //if(theEvent.getController() == d1){ println("This is d1");}
  //else if(theEvent.getController() == d2){ println("This is d2");}
  
  if(theEvent.getController() == d1){data[0] = Integer.toString(int(theEvent.getController().getValue()));}
  else if(theEvent.getController() == d2){data[1] = Integer.toString(int(theEvent.getController().getValue()));}
  else if(theEvent.getController() == d3){data[2] = Integer.toString(int(theEvent.getController().getValue()));}
  
  //println("Data1 : "+ data[0]);
  //println("Data2 : "+ data[1]);
  
  for(int i=0; i<3 ;i++){dataAll += data[i]+"-";}
  //println("All : " + dataAll);
  
  if(dataAll.length()<=10){
  dataAll2 = "0"+dataAll.length()+dataAll;}
  else{dataAll2 = dataAll+dataAll.length();}
}



public void submit() {
  c = val.charAt(0);
  myPort.write(dataAll2);      
  println("Send Data :" + dataAll2);  
  println("val : " + val);

  println("Wait.");
  //println(int(val));
  //println(val.length());
  
  if(c == '1'){
    timer.start();
  }
  
 val = "0";

}

void draw() {
  background(128);
  
  if ( myPort.available() > 0) 
  {  // If data is available,
    val = myPort.readStringUntil('\n');         // read it and store it in val
  } 
  /*if(timer.isFinished()){//println("5555");
  setup();
  }*/
  if(c == '1'){
    textSize(10); text("Complete!",333,335); 
    
      if(timer.isFinished())
      {
        submit();
      }
    }
    
}
