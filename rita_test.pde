import rita.*;

RiMarkov rm;
RiString rs;
String[] myVerbs = new String[0];

String sourceText;

PFont myFont;

void setup() {
  size(1050, 650);
  background(170, 240, 209);

  myFont = loadFont("MuseoSlab-700-48.vlw");
  textFont(myFont, 48);

  rm = new RiMarkov(3);
  rm.loadFrom(new String[] { "wittgenstein.txt", "kafka.txt" }, this);
}

void draw() {

  sourceText = "Your brother created ISIS, a young college student tells Jeb Bush, creating the kind of confrontational moment that presidential candidates dread";
}

void extractWords(String s) {

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

void displayVerbs() {
  int numVerbs = myVerbs.length;

  for (int i=0; i < numVerbs; i++ ) {
    text(myVerbs[i], 50, (50 + 50*i));
  }
}

void makeSentence() {
  
  String result = rm.generateSentence();
  text(result, 50, 300);
  // result = rm.getCompletions([ "the","red"]);

}

void mouseClicked(){
  extractWords(sourceText);
  displayVerbs();
  makeSentence();
}


void wordReplacement() {

}

