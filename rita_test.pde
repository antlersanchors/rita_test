import rita.*;

RiMarkov rm;
RiString rs;
String[] targetSpeech = new String[0];

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

}

void keyPressed(){
  getSource();
  extractWords(sourceText);
  displayWords();
  makeSentence();
}

void getSource() { // get the text we want to parse
  sourceText = "Your brother created ISIS, a young college student tells Jeb Bush, creating the kind of confrontational moment that presidential candidates dread";
  
}

void extractWords(String s) { //extract words of interest from the text
  String incoming = s;

  rs = new RiString(incoming);
  rs.analyze();

  int wc = rs.wordCount();

  for (int i=0; i < wc; i++) {
    String pos = rs.posAt(i);
    println("pos: "+pos);

    if (pos.startsWith("v")) {
       targetSpeech = append(targetSpeech, rs.wordAt(i));

    }
  }
}

void displayWords() {
  int numWords = targetSpeech.length;

  for (int i=0; i < numWords; i++ ) {
    text(targetSpeech[i], 50, (50 + 50*i));
  }
}

void makeSentence() {
  background(170, 240, 209);

  String result = rm.generateSentence();
  text(result, 50, 300);
  String[] completions = rm.getCompletions(targetSpeech);

  for (int i=0; i < completions.length; i++){
    text(completions[i], 50, (50 + 50*i));
  }
}



void wordReplacement() {

}

