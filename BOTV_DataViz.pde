import controlP5.*;
ControlP5 cp5;
int knobValue = 100;
Knob myKnobA;
Knob myKnobB;
Range range;
Slider date_slider;
float[] datesarray; 

PFont pfont = createFont("verdana",20, false); // use true/false for smooth/no-smooth
ControlFont font = new ControlFont(pfont,200);

void setup()
{

  // initialize picking buffer
  pick_buffer = createGraphics(width, height, P2D);
  
  // initialize data structures

  issue_set = new ArrayList();
  iset = new ArrayList();
  dates = new ArrayList();
  organizations = new ArrayList();
  buildings = new ArrayList();

  date_counter = 0; // keeps track of the active date, relates to the ArrayList "dates"
  iset.clear();
 
  // initialize stage
  
  size(MY_WIDTH, MY_HEIGHT);
  stroke(255, 255, 255);
  smooth();
  noStroke();
  background (0);
  myFont = createFont("verdana", 10);
  textFont(myFont);

  // initialize picking buffer
  pick_buffer = createGraphics(width, height, P2D);
  pick_buffer.beginDraw();
  pick_buffer.noFill();
  pick_buffer.strokeWeight(2);
  pick_buffer.endDraw(); 

  // parse issues  
  String lines[] = loadStrings(DATASOURCE);

  for (int i=0; i < lines.length; i++)
  {
    
    // creates an array with the comma separated elements of each line
    String values[] = split(lines[i], ",");
    try {
      Issue issue = new Issue(values);
      issue_set.add(issue);
      good_issues_count += 1;
 
    } catch (Exception e) {
      bad_issues_count += 1;
    }
  }
  parse_dates();
  datesarray = new float[dates.size()];
  parse_buildings();  
  make_gui();
}

void draw() {
  background(0);
  
  pick_buffer.beginDraw();
  pick_buffer.background(0);
  pick_buffer.endDraw();
  selected_issue = -1;
  
  draw_rings();
  update_info();

  if (iset.size() > 1){
    update_date();  
  }
}




