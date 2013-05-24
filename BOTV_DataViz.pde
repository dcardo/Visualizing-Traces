void setup()
{
  // initialize picking buffer

  pick_buffer = createGraphics(width, height, P2D);
  
  // initialize data structures, see "global_values.pde" for declarations
  
  issue_set =     new ArrayList();
  iset =          new ArrayList();
  dates =         new ArrayList();
  organizations = new ArrayList();
  buildings =     new ArrayList();
  
  date_counter = 0;   // keeps track of the active date, relates to the ArrayList "dates"
  iset.clear();       // cleans the issue arraylist
 
  // initialize visual aspects of stage
  
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

  parse_issues();
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




