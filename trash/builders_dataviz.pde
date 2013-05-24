

// Dissertation chapter 6 data viz sketch
// a visualization depicting the information flow in a BIM coordination process.
// Based on data collected from a team of 4 GT BIM coordinators in AD.

Issue[] issues = new Issue[5000]; // use vector class to be able to resize?

void setup()
{
  // load issue data from CSV file
  // parse the data line by line
  
  String lines[] = loadStrings("datatest.csv");

  for (int i=0; i < lines.length; i++) 
  {
    // creates an array with the comma separated elements of each line
    String fields[] = split(lines[i], ",");
   
    if (is_valid_issue(fields)) 
    { 
      issues[i] = new Issue(fields[0]);
      println("Issue " + i + " created.");
    }
  }
   println("No. Of Issues: " + issues.length);
}

boolean is_valid_issue(String[] f){
  // checks if an array containing a tuple's fields represents a valid issue  
  
  // string is empty
  if (f[0].equals(""))
  { 
    return false;  
  }
  
  // string is too short to represent an issue index
  if (f[0].length() < 2)
  {
    return false; 
  } 
  
  // string cannot be cast as an int, (text)
  if (int(f[0]) == 0)
  {
    return false; 
  }
  
  return true;
  
}

void draw(){
  // TODO  
}





