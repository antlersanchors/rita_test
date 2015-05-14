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



RiText[] rts = new RiText[3];
String[] abstractText;
String[] abstractWords;

String[] myVerbs = new String[0];

RiLexicon lexicon;

RiString rs;

public void setup()
{
  size(650, 650);

  RiText.defaultFontSize(30);
  RiText.defaults.alignment = CENTER;
  
  rts[0] = new RiText(this, "click to", width / 2, 75);
  rts[1] = new RiText(this, "parse", width / 2, 110);
  rts[2] = new RiText(this, "abstract", width / 2, 145);

  abstractText = loadStrings("abstract.txt");

}
  

public void draw()
{
  // background(230, 240, 255);

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
       myVerbs = append(myVerbs, pos);

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
