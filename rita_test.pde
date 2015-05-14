import rita.*;

RiString rs;
String[] myVerbs = new String[0];

PFont myFont;

void setup()
{
  size(650, 650);
  background(170, 240, 209);

myFont = loadFont("MuseoSlab-700-48.vlw");
textFont(myFont, 48);
}
  

void draw()
{

  // parseText();
}

void parseText() {

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

void displayVerbs() {
  int numVerbs = myVerbs.length;
  // text(numVerbs, 200, 200);

  for (int i=0; i < numVerbs; i++ ) {
    text(myVerbs[i], 50, (50 + 50*i));
  }
}

void mouseClicked(){
  parseText();
  displayVerbs();
}

void wordReplacement() {

}

