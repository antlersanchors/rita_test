// ------ RiTA STUFF ------
import rita.*;

RiMarkov rm;
RiString rs;
String[] targetSpeech = new String[0];

String sourceText;
String sourceTextLonger;
String sourceCombined;
// ------------------------

// ------ API STUFF ------
import com.temboo.core.*;
import com.temboo.Library.NYTimes.MostPopular.*;
import com.temboo.Library.Twitter.Search.*;

import java.net.URLDecoder;

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

void setup() {
  size(1050, 650);
  background(170, 240, 209);

  myFont = loadFont("MuseoSlab-700-48.vlw");
  textFont(myFont, 48);

  // Run the GetMostViewed Choreo function
  runGetMostViewedChoreo();
  if(step1)runLatestTweetChoreo();
}

void draw() {

}

void keyPressed(){
  getSource();
  // extractWords(sourceCombined);
  // displayWords();
  makeSentence();
}

void getSource() { // get the text we want to parse
  sourceText = "Your brother created ISIS, a young college student tells Jeb Bush, creating the kind of confrontational moment that presidential candidates dread";

  sourceTextLonger = "Besides, you look good in a dress. Talk about going nowhere fast. Yes, absolutely, I do indeed concur, wholeheartedly! The Enterprise computer system is controlled by three primary main processor cores, cross-linked with a redundant melacortz ramistat, fourteen kiloquad interface modules. Smooth as an android's bottom, eh, Data? Wait a minute - you've been declared dead. You can't give orders around here. Yesterday I did not know how to eat gagh. Sorry, Data. Now we know what they mean by 'advanced' tactical training. I'll be sure to note that in my log. I'll alert the crew. Did you come here for something in particular or just general Riker-bashing? A surprise party? Mr. Worf, I hate surprise parties. I would *never* do that to you. Sure. You'd be surprised how far a hug goes with Geordi, or Worf. What? We're not at all alike! Commander William Riker of the Starship Enterprise. Maybe if we felt any human loss as keenly as we feel one of those close to us, human history would be far less bloody. Worf, It's better than music. It's jazz. Earl Grey tea, watercress sandwiches... and Bularian canapés? Are you up for promotion? And blowing into maximum warp speed, you appeared for an instant to be in two places at once. I think you've let your personal feelings cloud your judgement. Is it my imagination, or have tempers become a little frayed on the ship lately? We know you're dealing in stolen ore. But I wanna talk about the assassination attempt on Lieutenant Worf. We finished our first sensor sweep of the neutral zone. Our neural pathways have become accustomed to your sensory input patterns. They were just sucked into space. Travel time to the nearest starbase? That might've been one of the shortest assignments in the history of Starfleet. Ensign Babyface! Fate protects fools, little children and ships named Enterprise. Your head is not an artifact! Shields up! Rrrrred alert! We could cause a diplomatic crisis. Take the ship into the Neutral Zone Not if I weaken first. Some days you get the bear, and some days the bear gets you. Maybe if we felt any human loss as keenly as we feel one of those close to us, human history would be far less bloody. Why don't we just give everybody a promotion and call it a night - 'Commander'? Damage report! I guess it's better to be lucky than good. Captain, why are we out here chasing comets? Congratulations - you just destroyed the Enterprise. My oath is between Captain Kargan and myself. Your only concern is with how you obey my orders. Or do you prefer the rank of prisoner to that of lieutenant? I'd like to think that I haven't changed those things, sir. You enjoyed that. When has justice ever been as simple as a rule book? Computer, belay that order. I'm afraid I still don't understand, sir. Then maybe you should consider this: if anything happens to them, Starfleet is going to want a full investigation. A lot of things can change in twelve years, Admiral. I can't. As much as I care about you, my first duty is to the ship. Well, that's certainly good to know. Flair is what marks the difference between artistry and mere competence. We have a saboteur aboard. Fate. It protects fools, little children, and ships named Enterprise. The unexpected is our normal routine. When has justice ever been as simple as a rule book? But the probability of making a six is no greater than that of rolling a seven. This should be interesting. Some days you get the bear, and some days the bear gets you. The game's not big enough unless it scares you a little.";

  sourceCombined = sourceText + sourceTextLonger;
  
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

  rm = new RiMarkov(5);
  rm.loadText(sourceCombined);

  String result = rm.generateSentence();
  text(result, 50, 300);
  
  // String[] completions = rm.getCompletions(targetSpeech);

  // for (int i=0; i < completions.length; i++){
  //   text(completions[i], 50, (50 + 50*i));
  // }
}

void runGetMostViewedChoreo() {
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

void runLatestTweetChoreo() {
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