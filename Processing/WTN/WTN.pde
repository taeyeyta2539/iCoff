import processing.serial.*; 
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.HashMap;
import java.util.Map;
import controlP5.*;
import javax.sound.midi.Receiver;
import javax.sound.midi.MidiMessage;

ControlP5 cp5;

Textarea myTextarea;
Map<String, String> midimapper = new HashMap<String, String>();

Serial myPort; // Create object from Serial class

String val; // Data received from the serial port
int myval;
float myval2 = 0.0;
String myval3 = "0-0-0-";
String nfcval;
PImage bg;
PImage img;
PImage img2;
PImage img3;
PImage img4;
PImage img5;
String[] arabica ;
String[] robusta;
String[] goatmilk;
String split3[] = {""};
String split4[] = {""};
String keeper[] = {""};
String beanType[] = {"Empty","Arabica","Robusta"};
String milkType[] = {"Empty","Milk","Goat Milk"};
String sweetness[] = {"Empty","Milk","Goat Milk"};
void setup()
{
size(640, 600);
bg = loadImage("img/5.jpg"); //background image
String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
myPort = new Serial(this, portName, 9600);
cp5 = new ControlP5( this );

val = myPort.readStringUntil('\n'); // read it and store it in val

  if (val != null){
                    String split[] = val.split(",");
                    myval = int(split3[0]);
                    myval2 = Math.abs(float(split[1]));
                    myval3 = split[2].substring(1);

                    //Split NFC Data
                    String split1[] = myval3.split("-");
                  }





//Text File
arabica = loadStrings("text/arabica.txt");   
robusta = loadStrings("text/robusta.txt");
goatmilk = loadStrings("text/goatmilk.txt");

//Image file
img = loadImage("img/ara.png");            
img2 = loadImage("img/ro.png");
img3 = loadImage("img/Cm.png");
img4 = loadImage("img/Gm.png");
img5 = loadImage("img/loadicon.png");
}

/////////////////////////////////////////////////End of Setup()

















void draw()
{

while ( myPort.available() > 0) { // If data is available,
val = myPort.readStringUntil('\n'); // read it and store it in val

    
if (val != null){
  val = val.substring(0, val.length() - 2);
        int check2 = 0;
        
//////////////////////////////////////////////////check pattern 1
    String regex = "^(.+),(.+),([^,]+)$";
        //String test = "0,0,0-0-0";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(val);
        //println(matcher.matches());
        //println("test : "+test.length());
        //println("val : "+val.substring(0, val.length() - 2).length()+" : "+val.substring(0, val.length() - 2));
        if(matcher.matches() == false){val = "0,0,0-0-0";}
///////////////////////////////////////////////////        
        
    
background(bg);
String split[] = val.split(",");
println("val : "+val);
myval = int(split[0]);

myval2 = Math.abs(float(split[1]));

myval3 = split[2].substring(1);
//myval3 = myval3.substring(0, val.length() - 1);
println("myval3 : "+myval3);

        String regex2 = "[0123456789-]+";
        
        Pattern pattern2 = Pattern.compile(regex2);
        Matcher matcher2 = pattern2.matcher(myval3);
        println(matcher2.matches());
        if(matcher2.matches() == false){myval3 ="0-0-0-";}
//if (myval3.length() == 1){myval3 ="0-0-0-";}

        //println("myval3 length is "+myval3.length());
    /*for (int i = 0; i < myval3.length(); i++) {
        char check = myval3.charAt(i);

        if (check == '') {
            myval3 ="0-0-0-";
        }

    }*/




//////////////////////////////////////////////NFC Dara
String split1[] = myval3.split("-");

//text(split1[0]+ " " +split1[1]+ " " + split1[2],10,20);
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
textSize(10); text(int(split1[0]),600,10);
textSize(10); text(int(split1[1]),610,10);
textSize(10); text(int(split1[2]),620,10);


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
text("Your drink is getting cold.",380,550);
}

else{
textSize(20);
text("Enjoy !",480,550);
}
//////////////////////////////////////////////////////////

}

}

///////////////////////////////////////////////////////////////////Coffee Bean Info.

  /*cp5.begin(cp5.addTab("coffeeBean"));
    myTextarea = cp5.addTextarea("txt")
                  .setPosition(170,100)
                  .setSize(300,300)
                  .setFont(createFont("arial",12))
                  .setLineHeight(14)
                  .setColor(color(128))
                  .setColorBackground(color(255,100))
                  .setColorForeground(color(255,100));
                  ;
                   
                 
  //if(int(split4[0]) == 1){for(int i = 0 ; i < arabica.length ; i++){keeper[0]+=arabica[i];}}
  //else if(int(split4[0]) == 2){for(int i = 0 ; i < robusta.length ; i++){keeper[0]+=robusta[i];}}
  for(int i = 0 ; i < arabica.length ; i++){keeper[0]+=arabica[i];}
  myTextarea.setText(keeper[0]
                    );
  cp5.end();
  myTextarea.moveTo("coffeeBean");
///////////////////////////////////////////////////////////////////End Coffee Bean Info.
  
  

  
  final String device = "SLIDER/KNOB";
  
  //midimapper.clear();
  
  
  midimapper.put( ref( device, 18 ), "coffeeBean-1" );


  boolean DEBUG = false;

  if (DEBUG) {
    new MidiSimple( device );
  } 
  else {
    new MidiSimple( device , new Receiver() {

      @Override public void send( MidiMessage msg, long timeStamp ) {

        byte[] b = msg.getMessage();

        if ( b[ 0 ] != -48 ) {

          Object index = ( midimapper.get( ref( device , b[ 1 ] ) ) );

          if ( index != null ) {

            Controller c = cp5.getController(index.toString());
            if (c instanceof Slider ) {  
              float min = c.getMin();
              float max = c.getMax();
              c.setValue(map(b[ 2 ], 0, 127, min, max) );
            }  else if ( c instanceof Button ) {
              if ( b[ 2 ] > 0 ) {
                c.setValue( c.getValue( ) );
                c.setColorBackground( 0xff08a2cf );
              } else {
                c.setColorBackground( 0xff003652 );
              }
            } else if ( c instanceof Bang ) {
              if ( b[ 2 ] > 0 ) {
                c.setValue( c.getValue( ) );
                c.setColorForeground( 0xff08a2cf );
              } else {
                c.setColorForeground( 0xff00698c );
              }
            } else if ( c instanceof Toggle ) {
              if ( b[ 2 ] > 0 ) {
                ( ( Toggle ) c ).toggle( );
              }
            }
          }
        }
      }

      @Override public void close( ) {
      }
    }
    );
  }*/
//println(val); //print it out in the console

}

String ref(String theDevice, int theIndex) {
  return theDevice+"-"+theIndex;
}
