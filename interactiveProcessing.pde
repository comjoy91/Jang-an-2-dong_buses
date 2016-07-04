
//  import processing.core.*;
//    import geomerative.*;

	PShape img;
	PImage capacity_background, onOffArrow, person;
	PShape capacity, passGraph;
	PShape busRoutes, busNumIcon;
	MetaData dataFile;
	PFont mainFont;
    float GRAPH_HEIGHT, VALUE_OF_HIGHEST, GRAPH_X_START, REC_WIDTH, GRAPH_Y_BASE;
    float ARROW_Y, ARROW_MIDDLE_Y, STATION_TEXT_Y;
    float BUSNUMICON_WIDTH, BUSNUMICON_HEIGHT, BUSNUMICON_X, BUSNUMICON_Y, BUSNUMICON_DISTANCE_X, BUSNUMICON_DISTANCE_Y;
    float CAPACITY_X, CAPACITY_Y, CAPACITY_WIDTH, CAPACITY_HEIGHT;
    float PASSGRAPH_X;
    
    float iconX, iconY;
 
    int NUMOF_BUS, mouse_clicked, cursor_buffer;

    void settings() {
      size(1280, 800, FX2D);
    }

    void setup() {
        smooth();

        frameRate(30);
        colorMode(RGB);
        img = loadShape("jangandongMap.svg");
        
        onOffArrow = loadImage("arrows.png");
        person = loadImage("person.png");
        capacity = loadShape("busCapacity.svg");
        capacity_background = loadImage("busCapacity_background.png");
        
        passGraph = loadShape("passGraph.svg");
        
        
        busRoutes = loadShape("linePath.svg");
        busNumIcon = loadShape("scatterPlot.svg").getChild("busIcon");
        
        mainFont = loadFont("SDGothicNeo1OTFM-16.vlw");
        
        dataFile = new MetaData("data_everyLine.csv");
                    
        GRAPH_HEIGHT = 600;
        VALUE_OF_HIGHEST = 300000;
        GRAPH_X_START = 680;
        REC_WIDTH = 4;
        GRAPH_Y_BASE = 680;
        
        ARROW_Y = 222;
        ARROW_MIDDLE_Y = ARROW_Y+64;
        STATION_TEXT_Y = GRAPH_Y_BASE+40;
        
        BUSNUMICON_WIDTH = 54;
        BUSNUMICON_HEIGHT = 33;
        BUSNUMICON_X = 1020;
        BUSNUMICON_Y = 262;
        BUSNUMICON_DISTANCE_X = 82;
        BUSNUMICON_DISTANCE_Y = 53;
        
        CAPACITY_X = GRAPH_X_START;
        CAPACITY_Y = 263;
        CAPACITY_WIDTH = 250;
        CAPACITY_HEIGHT = 154;
        
        PASSGRAPH_X = 721;
        
        mouse_clicked = -1;
        cursor_buffer = -1;
        iconX = 0;
        iconY = 0;
        
        NUMOF_BUS = busNumIcon.getChildCount();
        img.getChild("lines").setVisible(false);

    }
    
    void draw() {

    	background(255, 255, 255);
    	smooth();

        shape(busNumIcon, 0, 0);

        noStroke();
        fill(255, 255, 255, 140);
        rect(width/2, 0, width/2+100, height/2+20); // transparency for BUSNUMICON       
//        fill(255, 255, 255, 140);
//        rect(0, height/2+20, CAPACITY_X, height/2-20); // transparency for scatterPlot
        
        noFill();

       	shape(img, 0, 0);


        
        if(mouse_clicked >= 0 ) {
        		      
	      
	      // build capacity title
	      shape(capacity.getChild("busTitle").getChild(mouse_clicked), 0, 0);
        	dataFile.selectedLine(mouse_clicked).displayGraph_Route_linedata();
       	}
       	
       	
       	cursor_buffer = -1;
       	for(int i=0; i<NUMOF_BUS; i++) {
	        iconX = BUSNUMICON_X + BUSNUMICON_DISTANCE_X*(i%3);
	        iconY = BUSNUMICON_Y + BUSNUMICON_DISTANCE_Y*(i/3);

  	        if(mouseX > iconX && mouseX < iconX + BUSNUMICON_WIDTH) {
	        	if(mouseY > iconY && mouseY < iconY + BUSNUMICON_HEIGHT) {

	        		shape(busNumIcon.getChild(i), 0, 0);
			        cursor_buffer = i;
			        
	        	}
  	        }
       	}
       	
       	
       	
       	if (mousePressed) {
       		mouse_clicked = -1;
       		mouse_clicked = cursor_buffer;
       		
       		if (mouse_clicked < 0) {
       			img.getChild("seoul").setVisible(true);
       			img.getChild("lines").setVisible(false);
       		}
       		else { 
       			img.getChild("seoul").setVisible(false); 
       			img.getChild("lines").setVisible(true);
       			}
       		
       	}
       
       
    }


  