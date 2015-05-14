import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import rita.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class rita_test extends PApplet {



RiString rs;
String[] myVerbs = new String[0];

PFont myFont;

public void setup()
{
  size(650, 650);
  background(170, 240, 209);

myFont = loadFont("MuseoSlab-700-48.vlw");
textFont(myFont, 48);
}
  

public void draw()
{

  // parseText();
}

public void parseText() {

  String incoming = "Your brother created ISIS, a young college student tells Jeb Bush, creating the kind of confrontational moment that presidential candidates dread";

  rs = new RiString(incoming);
  rs.analyze();

  int wc = rs.wordCount();

  for (int i=0; i < wc; i++) {
    String pos = rs.posAt(i);
    println("pos: "+pos);

    if (pos.startsWith("v")) {
       myVerbs = append(myVerbs, rs.wordAt(i));

    }
  }
}

public void displayVerbs() {
  int numVerbs = myVerbs.length;
  // text(numVerbs, 200, 200);

  for (int i=0; i < numVerbs; i++ ) {
    text(myVerbs[i], 50, (50 + 50*i));
  }
}

public void mouseClicked(){
  parseText();
  displayVerbs();
}

public void wordReplacement() {

}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "rita_test" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
