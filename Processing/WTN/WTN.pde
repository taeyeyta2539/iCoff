import processing.serial.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

Serial myPort;  // Create object from Serial class


String val;     // Data received from the serial port
int myval;
float myval2;
String myval3;
String nfcval;
PImage bg;
PImage img;
PImage img2;
PImage img3;
PImage img4;
PImage img5;

void setup()
{
  size(640, 600);
  bg = loadImage("5.jpg");
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600);
  img = loadImage("ara.png");
  img2 = loadImage("ro.png");
  img3 = loadImage("Cm.png");
  img4 = loadImage("Gm.png");
  img5 = loadImage("loadicon.png");
}

void draw()
{
  //////////////////////////////
  //background(230, 172, 0);
  //////////////////////////////
  
  while ( myPort.available() > 0)  {  // If data is available,
    val = myPort.readStringUntil('\n');     // read it and store it in val
  if (val != null){
    background(bg);
  String split[] = val.split(",");
  myval = int(split[0]);
  myval2 = Math.abs(float(split[1]));
  myval3 = split[2].substring(1);
 
  //////////////////////////////////////////////NFC Dara
  String split1[] = myval3.split("-");
    
  text(split1[0]+ " " +split1[1]+ " " + split1[2],10,20);
  //text(myval3,10,20);
  
  //////////////////////////////////////////////Display Data from NFC
  if(int(split1[0]) == 1){image(img, 60, 60 ,width/4, height/4);textSize(20); text("Arabica",100,220);}
  else if(int(split1[0]) == 2){image(img2, 60, 60 ,width/4, height/4);textSize(20); text("Robusta",100,220);}
  
  if(int(split1[1]) == 1){image(img3, 400, 60 ,width/4, height/4);textSize(20);text("Milk",440,220);}
  else if(int(split1[1]) == 2){image(img4, 400, 60 ,width/4, height/4);textSize(20);text("Goat milk",440,220);}
  
  if(int(split1[2]) == 1){textSize(30);text("Sweetness : Low",180,300);}
  else if(int(split1[2]) == 2){textSize(30);text("Sweetness : Medium",180,300);}
  else if(int(split1[2]) == 3){textSize(30);text("Sweetness : High",180,300);}
  
  else{image(img5, 210, 150 ,width/3, height/3);}
  
  
  //else {textSize(50); text("งงจังเลย",100,250);}
  textSize(50); text(int(split1[0]),500,250);
  textSize(50); text(int(split1[1]),550,250);
  textSize(50); text(int(split1[2]),600,250);
  
  

  
  //////////////////////////////////////////////Display Weight and Temp
  /*myval = myval/100*height;
  rectMode(CENTER);
  rect(width/2, height-(myval/2), 100,myval);*/
  textSize(50);
  text(myval + "°C",450,500);
  textSize(50);
  text(myval2 + " Kg",50,500);
  //textSize(15);
  //text(myval3,10,20);

 
  /////////////////////////////////////////////////////////
  if(myval >= 45){
    textSize(20);
  text("It's so hot , Please drink carefully. ",300,550);}
  
  else if(myval <= 30){
     textSize(20);
    text("Your drink starts to cool.",380,550);
  }
    
  else{
     textSize(20);
    text("Enjoy !",480,550);
  }
  //////////////////////////////////////////////////////////
  

  
  }
 
  }
  println(val); //print it out in the console
}
