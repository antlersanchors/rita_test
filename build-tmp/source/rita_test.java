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



RiMarkov rm;
RiString rs;
String[] myVerbs = new String[0];

String sourceText;

PFont myFont;

public void setup() {
  size(1050, 650);
  background(170, 240, 209);

  myFont = loadFont("MuseoSlab-700-48.vlw");
  textFont(myFont, 48);

  rm = new RiMarkov(3);
  rm.loadFrom(new String[] { "wittgenstein.txt", "kafka.txt" }, this);
}

public void draw() {

  sourceText = "Your brother created ISIS, a young college student tells Jeb Bush, creating the kind of confrontational moment that presidential candidates dread";
}

public void parseText(String s) {

  String incoming = s;

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

  for (int i=0; i < numVerbs; i++ ) {
    text(myVerbs[i], 50, (50 + 50*i));
  }
}

public void makeSentence() {
  
  String result = rm.generateSentence();
  text(result, 50, 300);
  // result = rm.getCompletions([ "the","red"]);

}

public void mouseClicked(){
  parseText(sourceText);
  displayVerbs();
  makeSentence();
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
