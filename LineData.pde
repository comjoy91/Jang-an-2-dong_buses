//import processing.core.*;


public class LineData {

	  String lineNum;
	  int numOfStops;
	  float dailyPass, dailyPass_station, dailyPass_bus;
	  int daily_leng, station_leng, bus_leng;
	  BusStopElement[] stopsData;
	  PShape lineRoute;


	  class BusStopElement {
	    String name;
	    int takeOnNum, takeOffNum, onBoardNum;
	    float takeOnAvgNum, takeOffAvgNum, onBoardAvgNum;
	    
		BusStopElement(TableRow stationData_) {
	      // TableRow stationData_: lineNum, stop #, stopID, stopName, takeON, takeOFF, onBoard, takeOnAvg, takeOffAvg, onBoardAvg
	      name = stationData_.getString(3);
	      takeOnNum = stationData_.getInt(4);
	      takeOffNum = stationData_.getInt(5);
	      onBoardNum = stationData_.getInt(6);
	      takeOnAvgNum = stationData_.getFloat(7);
	      takeOffAvgNum = stationData_.getFloat(8);
	      onBoardAvgNum = stationData_.getFloat(9);
	    }
	 
	    public String busStopName() {
	      return name;  }
	    public int takeOn() {
	      return takeOnNum;  }
	    public int takeOff() {
	      return takeOffNum;  }
	    public int onBoard() {
	      return onBoardNum;  }
	    public float takeOnAvg() {
	      return takeOnAvgNum;  }
	    public float takeOffAvg() {
	      return takeOffAvgNum;  }
	    public float onBoardAvg() {
	      return onBoardAvgNum;  }
	    
	  }

	  LineData(Table dataBuffer_, String lineNum_, PShape lineRoute_, int begin_, int end_) {
	    // TableRow stationData_: lineNum, stop #, stopID, stopName, takeON, takeOFF, onBoard, takeOnAvg, takeOffAvg, onBoardAvg
	    int begin = begin_;
	    int end = end_;
	    lineNum = lineNum_;
	    lineRoute = lineRoute_;
	    numOfStops = end-begin+1;
	    
	    
	    // Show the "dailyPass"
	    dailyPass = dataBuffer_.getRow(begin).getFloat(10);
	    dailyPass_bus = dataBuffer_.getRow(begin).getFloat(11);
	    dailyPass_station = dataBuffer_.getRow(begin).getFloat(12);
	    
	    stopsData = new BusStopElement[numOfStops];
	    for (int i=0; i<numOfStops; i++) {
	      stopsData[i] = new BusStopElement(dataBuffer_.getRow(begin+i));
	    }
	    
	  }
	  
	  public String stopName (int station_) {
	    return stopsData[station_].busStopName();  }
	  public int tOnNum (int station_) {
	    return stopsData[station_].takeOn();  }
	  public int tOffNum (int station_) {
	    return stopsData[station_].takeOff();  }
	  public int onBNum (int station_) {
	    return stopsData[station_].onBoard();  }
	  public float tOnAvNum (int station_) {
	    return stopsData[station_].takeOnAvg();  }
	  public float tOffAvNum (int station_) {
	    return stopsData[station_].takeOffAvg();  }
	  public float onBAvNum (int station_) {
	    return stopsData[station_].onBoardAvg();  }
	    
	  public float dailyPassNum () {
	  	return dailyPass; }
	  public float dailyPass_stationNum () {
	  	return dailyPass_station; }
	  public float dailyPass_busNum () {
	  	return dailyPass_bus; }
	  
	  public PShape fragmentRoute (int station_) {
		  return lineRoute.getChild(station_);	  }

	  
	  void displayGraph_Route_linedata() {

		  
		  // making bus route path. (start)
	      lineRoute.disableStyle();
	      if (lineNum.length() <= 3) { stroke(45, 76, 161); }
	      else { stroke(40, 180, 64); }
	      strokeWeight(3);
	      strokeCap(ROUND);
	      noFill();
	      shape(lineRoute, 0, 0); 
	      shape(img.getChild("stations"), 0, 0);
	      // making bus route path. (end)
	      
	      // making bus graph axis
	      shape(capacity.getChild("graphAxis"), 0, 0);

		  //build dailyPass
		  
		  if(mouseX > GRAPH_X_START && mouseX <= GRAPH_X_START + numOfStops*REC_WIDTH && mouseY > BUSNUMICON_Y + BUSNUMICON_DISTANCE_Y*3) {
	      	passGraph.setVisible(false);  	}
	      
	      else { 
	      	
	      daily_leng = int(dailyPassNum()/1000+0.5);
	      bus_leng = int(dailyPass_busNum()/30+0.5);
	      station_leng = int(dailyPass_stationNum()/10+0.5);
	      
	      passGraph.getChild("dailyPass").disableStyle();
	      passGraph.getChild("busPass").disableStyle();
	      passGraph.getChild("stationPass").disableStyle();
	      
	      shape(passGraph.getChild("texts"), 0, 0);
	      noStroke();
	      if (lineNum.length() <= 3) { fill(45, 76, 161); }
	    	else { fill(86, 135, 64); }

	      for(int i=0; i<daily_leng; i++) {
	      	shape(passGraph.getChild("dailyPass").getChild(i), 0, 0); }
	      for(int i=0; i<bus_leng; i++) {
	      	shape(passGraph.getChild("busPass").getChild(i), 0, 0); }
	      for(int i=0; i<station_leng; i++) {
	      	shape(passGraph.getChild("stationPass").getChild(i), 0, 0); }
	      	
	      	
	      	passGraph.setVisible(true);
	      	
  	      	fill(0);
	      	textFont(mainFont, 16);
	      	textAlign(LEFT);
	   	  	text(str(dailyPassNum()), daily_leng*14.7+PASSGRAPH_X+10, 77);
	      	textAlign(LEFT);
	   	  	text(str(dailyPass_busNum()), bus_leng*11.5+PASSGRAPH_X+10, 152.5);
	      	textAlign(LEFT);
	   	  	text(str(dailyPass_stationNum()), station_leng*9+PASSGRAPH_X+10, 224);  
	   	  	
	   	  }	
    
	      //end
	      
	    
	      for (int i=0; i<numOfStops; i++) {


	    	// making graph color. (start)
	    	if (lineNum.length() <= 3) { fill(45, 76, 161); }
	    	else { fill(86, 135, 64); }
	    	// making graph color. (end)
			noStroke();

	        float h = map(onBNum(i), 0, VALUE_OF_HIGHEST, 0, GRAPH_HEIGHT);
	        float x = i*REC_WIDTH;
	        rect(x+GRAPH_X_START, GRAPH_Y_BASE-h, REC_WIDTH, h); //making graph.

	        if(mouseX > x+GRAPH_X_START && mouseX <= x+GRAPH_X_START+REC_WIDTH && mouseY > BUSNUMICON_Y + BUSNUMICON_DISTANCE_Y*3) {
	          	
	          	image(capacity_background, CAPACITY_X, CAPACITY_Y); //invisible bus capacity title.
	          	
	            fill(255, 100, 0);
	            rect(x+GRAPH_X_START, GRAPH_Y_BASE-h, REC_WIDTH, h); // selected graph rectangle.

	            displayCapacity_linedata(i); // draw capacity&passengers.
	            displayOnOff_linedata(i); // draw onBoard/offBoard passengers.

				lineRoute.getChild(i).disableStyle();
	            stroke(255, 100, 0);
	            strokeWeight(12);
	            strokeCap(ROUND);
	            noFill();
	            shape(lineRoute.getChild(i), 0, 0); // selected route path.
				lineRoute.getChild(i).enableStyle();
	        }
	        

	        x+=REC_WIDTH;
	      
	        
	      }
	  }
	  
	  void displayOnOff_linedata (int stationIndex_) {
	  	
	  	String stationName = stopName(stationIndex_);
	    float takeonFl = tOnAvNum(stationIndex_);
	    float takeoffFl = tOffAvNum(stationIndex_);
	    float onboardFl = onBAvNum(stationIndex_);
		int takeon = int(takeonFl + 0.5); // 0.5 : for half update(...)
	    int takeoff = int(takeoffFl + 0.5); // 0.5 : for half update(...)
/*
	    float x_align = stationIndex_*REC_WIDTH+GRAPH_X_START-80;
	    float x_gap = 50;
	    
	    image(onArrow, x_align, ARROW_Y);
	    image(offArrow, x_align+x_gap, ARROW_Y);
	    
	    for (int i=0; i<takeon; i++) {
	    	image(person, x_align-30*i, ARROW_Y+20);
	    }
	    for (int i=0; i<takeoff; i++) {
	    	image(person, x_align+x_gap+30*i, ARROW_Y+20);
	    }
	    
	    fill(0);
	    textFont(mainFont, 16);
	    textAlign(RIGHT);
	    text(takeonFl, x_align, BUSICON_Y);
	    
	    textAlign(LEFT);
	    text(takeoffFl, x_align+x_gap, BUSICON_Y);
	    
	    textAlign(CENTER);
	    text(stationName, x_align+x_gap, BUSICON_Y+30);
	    
	    */
	    
	    float x_align = 780;
	    
	    float x_alignText = stationIndex_*REC_WIDTH+GRAPH_X_START;
	    
	    image(onOffArrow, x_align, ARROW_Y);
	    
	    for (int i=0; i<takeon; i++) {
	    	image(person, x_align-13-13*(i%7), ARROW_Y-30*(i/7));
	    }
	    for (int i=0; i<takeoff; i++) {
	    	image(person, x_align+55+13*(i%7), ARROW_Y-30*(i/7));
	    }
	    
	    fill(0);
	    textFont(mainFont, 16);
	    	    
	    textAlign(RIGHT);
	    text(stationName, x_alignText, STATION_TEXT_Y);
	    
	    textAlign(RIGHT);
	    text("Getting ON at once: "+str(takeonFl), x_alignText, STATION_TEXT_Y+20);
	    
	    textAlign(RIGHT);
	    text("Getting OFF at once: "+str(takeoffFl), x_alignText, STATION_TEXT_Y+40);
	    
	    textAlign(RIGHT);
	    text("On BOARD: "+str(onboardFl), x_alignText, STATION_TEXT_Y+60);

	  }
	  

	  void displayCapacity_linedata (int stationIndex_) {
	  	
	    float onBoardFl = onBAvNum(stationIndex_);
		int onboard = int(onBoardFl + 0.5); // 0.5 : for half update(...)
		
		shape(capacity.getChild("busstop"), 0, 0);
		
	    for (int i=0; i<=onboard; i++) {
	    	shape(capacity.getChild("bus").getChild(i), 0, 0);
	    }


	  }
	  
	  
}

