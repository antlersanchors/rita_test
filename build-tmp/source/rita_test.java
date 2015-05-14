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

RiLexicon lexicon;

RiString rs;

public void setup()
{
  size(650, 200);

  RiText.defaultFontSize(30);
  RiText.defaults.alignment = CENTER;
  
  rts[0] = new RiText(this, "click to", width / 2, 75);
  rts[1] = new RiText(this, "parse", width / 2, 110);
  rts[2] = new RiText(this, "abstract", width / 2, 145);

  abstractText = loadStrings("abstract.txt");

}
  

public void draw()
{
  background(230, 240, 255);

  String[] words = split(abstractText[0]," ");

  int l = words.length;
  println("l: "+l);

  String test = "Hello Derp";

  rs = new RiString("Your brother created ISIS, a young college student tells Jeb Bush, creating the kind of confrontational moment that presidential candidates dread");
  rs.analyze();

  String x = rs.posAt(2);
  println("x: "+ x);
  
  int w = rs.wordCount();
  println("w: "+w);

  rs.replaceWord(2, "DERP");

  
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
