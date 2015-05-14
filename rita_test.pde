import rita.*;

RiText[] rts = new RiText[3];
String[] abstractText;
String[] abstractWords;

String[] myVerbs = new String[0];

RiLexicon lexicon;

RiString rs;

void setup()
{
  size(650, 650);

  RiText.defaultFontSize(30);
  RiText.defaults.alignment = CENTER;
  
  rts[0] = new RiText(this, "click to", width / 2, 75);
  rts[1] = new RiText(this, "parse", width / 2, 110);
  rts[2] = new RiText(this, "abstract", width / 2, 145);

  abstractText = loadStrings("abstract.txt");

}
  

void draw()
{
  // background(230, 240, 255);

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
       myVerbs = append(myVerbs, pos);

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

