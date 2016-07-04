//import processing.core.*;
//import processing.data.Table;
//import processing.data.TableRow;


public class MetaData {
  
	Table dataBuffer;
	LineData[] linesArray;      // array of LineData: 
	String[] lineIndexArray;    // array of lineNums.
  
	MetaData(String filename_) {
		dataBuffer = loadTable(filename_, "header");  // lineNum, stop #, stopID, stopName, takeON, takeOFF, onBoard
		int stopNumber = dataBuffer.getRowCount();

		// build LineData[] array.
		linesArray = new LineData[0];
		lineIndexArray = new String[0];
		
		int j=0; int numOfLines_int=0;
		for (int i=0; i<stopNumber; i++) {
			if (i == stopNumber-1 || dataBuffer.getInt(i+1, 1) == 1) {
				String lineNum_ = dataBuffer.getString(i, 0);
				linesArray = (LineData[]) append(linesArray, new LineData(dataBuffer, lineNum_, busRoutes.getChild(numOfLines_int), j, i)); //real line data
				lineIndexArray = append(lineIndexArray, lineNum_); //just array of lineNum_(string)
				j = i+1; numOfLines_int++;
			}
		}
	}
    
	public int numOfLines () {
		return lineIndexArray.length;
	}
  
	public int lineIndex (String lineNum_) {
		for (int i=0; i<lineIndexArray.length; i++) {
			if (lineIndexArray[i] == lineNum_) {
				return i;
			}
		}
		return -1;
	}
  
	public String lineName (int lineIndex_) {
		if (lineIndex_ < lineIndexArray.length) {
			return lineIndexArray[lineIndex_];
		}
    
		return null;
	}

  
	public LineData selectedLine (int index) {
		return linesArray[index];
	}
}

