import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import rita.*; 
import com.temboo.core.*; 
import com.temboo.Library.NYTimes.MostPopular.*; 
import com.temboo.Library.Twitter.Search.*; 
import java.net.URLDecoder; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class rita_test extends PApplet {

// ------ RiTA STUFF ------


RiMarkov rm;
RiString rs;
String[] targetSpeech = new String[0];

String sourceText;
String sourceTextLonger;
String sourceCombined;
Char speechChar;
// ------------------------

// ------ API STUFF ------






JSONObject json, topResult;
String abst, type, title, byline, source, url, section, column, adx_keywords; 
int assetId;
boolean step1 = false;

String[] listNYWords;
String string1;

// Needs to be set to be able to use:
String tembooUser = "";
String tembooKey = "";
String NYTimesKey = "";

String TwitterAccessToken ="";
String TwitterAccessTokenSecret = "";
String TwitterConsumerSecret = "";
String TwittersetConsumerKey = "";

// Create a session using your Temboo account application details
TembooSession session = new TembooSession(tembooUser, "myFirstApp", tembooKey);
// ------------------------

PFont myFont;

public void setup() {
  size(1050, 650);
  background(170, 240, 209);

  myFont = loadFont("MuseoSlab-700-48.vlw");
  textFont(myFont, 48);

  // Run the GetMostViewed Choreo function
  runGetMostViewedChoreo();
  if(step1)runLatestTweetChoreo();
}

public void draw() {
  background(170, 240, 209, 0.5f);

}

public void keyPressed(){
  getSource();
  extractWords(key, abst); //
  // displayWords();
  makeSentence();
}

public void extractWords(Char k, String s) { //extract words of interest from the text
  Char speechChar = k;
  String incoming = s;

  rs = new RiString(incoming);
  rs.analyze();

  int wc = rs.wordCount();

  for (int i=0; i < wc; i++) {
    String pos = rs.posAt(i);
    println("pos: "+pos);

    if (pos.startsWith(speechChar)) {
       targetSpeech = append(targetSpeech, rs.wordAt(i));

    }
  }
}

public void displayWords() {
  int numWords = targetSpeech.length;

  for (int i=0; i < numWords; i++ ) {
    text(targetSpeech[i], 50, (50 + 50*i));
  }
}

public void makeSentence() {
  background(170, 240, 209);

  rm = new RiMarkov(5);
  rm.loadText(sourceCombined);

  String result = rm.generateSentence();
  text(result, 50, 300);
  
  // String[] completions = rm.getCompletions(targetSpeech);

  // for (int i=0; i < completions.length; i++){
  //   text(completions[i], 50, (50 + 50*i));
  // }
}

public void runGetMostViewedChoreo() {
  // Create the Choreo object using your Temboo session
  GetMostViewed getMostViewedChoreo = new GetMostViewed(session);

  // Set inputs
  getMostViewedChoreo.setSection("all-sections");
  getMostViewedChoreo.setAPIKey(NYTimesKey);
  getMostViewedChoreo.setResponseFormat("json");
  getMostViewedChoreo.setTimePeriod("1");

  // Run the Choreo and store the results
  GetMostViewedResultSet getMostViewedResults = getMostViewedChoreo.run();

  json = JSONObject.parse(getMostViewedResults.getResponse());
  JSONArray results = json.getJSONArray("results");
  topResult =  results.getJSONObject(0);
  
  abst = topResult.getString("abstract");
  type = topResult.getString("type");
  section = topResult.getString("section");
  title = topResult.getString("title");
  byline = topResult.getString("byline");
  source = topResult.getString("source");
  url = topResult.getString("url");
  adx_keywords = topResult.getString("adx_keywords");
  column = topResult.getString("column");
  assetId = topResult.getInt("id");
  
  JSONArray des_facet = topResult.getJSONArray("des_facet");
  JSONArray per_facet = topResult.getJSONArray("per_facet");
  JSONArray org_facet = topResult.getJSONArray("org_facet");
  JSONArray media = topResult.getJSONArray("media"); // Holds the pictures, but doesn't work 
  
  listNYWords = split(abst, " ");
  int t = (int) listNYWords.length;
  string1 = listNYWords[(int)random(t)];
  println(abst, string1);

  step1 = true;
}

public void runLatestTweetChoreo() {
  // Create the Choreo object using your Temboo session
  LatestTweet latestTweetChoreo = new LatestTweet(session);

  // Set inputs
  latestTweetChoreo.setAccessToken(TwitterAccessToken);
  latestTweetChoreo.setQuery(string1);
  latestTweetChoreo.setAccessTokenSecret(TwitterAccessTokenSecret);
  latestTweetChoreo.setConsumerSecret(TwitterConsumerSecret);
  latestTweetChoreo.setConsumerKey(TwittersetConsumerKey);
  latestTweetChoreo.setResultType("popular");

  // Run the Choreo and store the results
  LatestTweetResultSet latestTweetResults = latestTweetChoreo.run();
  
  JSONObject json1 = JSONObject.parse(latestTweetResults.getResponse());
  JSONArray statuses = json1.getJSONArray("statuses");
  println(statuses);
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
