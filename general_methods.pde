
void parse_issues(){
  String lines[] = loadStrings(DATASOURCE); 
  for (int i=0; i < lines.length; i++)
  { 
    // creates an array with the comma separated elements of each line
    String values[] = split(lines[i], ",");
    /*
    println("");
    println("--------------");
    println(i);
    println("--------------");
    */
    try {
      Issue issue = new Issue(values);    
      issue_set.add(issue);
      good_issues_count += 1;
 
    } catch (Exception e) {
        println("Creation of issue " + i + " failed.");
        bad_issues_count += 1;
    }
  } 
  
}

void parse_dates(){
  // populates a global ArrayList with the dates
  int i;
  Issue issue;
  for (i = 0; i < issue_set.size(); i++){
    issue = (Issue)issue_set.get(i);
    if (dates.contains(issue.open_date)){
    }
    else{
     dates.add(issue.open_date); 
    }
 }
}

void parse_organizations(){
  int i;
  Issue issue;
  for (i = 0; i < issue_set.size(); i++){
    issue = (Issue)issue_set.get(i);
    if (organizations.contains(issue.organization)){
    }
    else{
     organizations.add(issue.organization); 
    }
 }
}

void parse_buildings(){
  int i;
  Issue issue;
  for (i = 0; i < issue_set.size(); i++){
    issue = (Issue)issue_set.get(i);
    if (buildings.contains(issue.building)){
    }
    else{
     buildings.add(issue.building); 
    }
 }
}

void update_iset(int d){
  // updates the iset ArrayList with those issues active up until the date specified.
  int i;
  Issue issue;  
  for (i = 0; i < issue_set.size(); i++){
    issue = (Issue) issue_set.get(i);
    if (issue.open_date.equals(dates.get(d))){
      iset.add(issue);
    }
    else{
    }
  }
}

void update_iset_2(int d){
// alternative to previous method
  int i;
  Issue issue;
  iset.clear();
  for (i = 0; i < d; i++){
    iset.add((Issue) issue_set.get(i));
  }
  //update_date();

}

void update_date(){

  Date latest_date;
  Issue issue;
  issue = (Issue) iset.get(iset.size()-1);
  latest_date = issue.open_date;

  text(format_date_string(latest_date), SLIDER_POSX, SLIDER_POSY - 20);

  //println("Latest issue date: " + latest_date.toString());

}

String format_date_string(Date d){

  String date_string;
  String formatted_string;
  date_string = d.toString();

  //dow mon dd hh:mm:ss zzz yyyy
  formatted_string = date_string.substring(0, 10) + " 20" + date_string.substring(24);
  return formatted_string;

}

void print_general_info(){
  println("| Date counter: " + date_counter + " | Date: " + dates.get(date_counter) + " | Issues in iset: " + iset.size() + " | Total # of parsed Issues: " + issue_set.size());


}

void print_csv_line(String[] f) {
  // prints a parsed line from the csv file
  int i;
  for (i=0; i < f.length && i < FIELDS.length; i++) {
    println(" -> " + i + ":" + FIELDS[i] + ": " + f[i]);

  }
}

void update_info(){

  PImage b;
  int i, j;
  int separator = 15;
  int originx = INFO_PANEL_X;
  int originy = INFO_PANEL_Y;


  fill(255, 255, 255);

  for (i = 0; i < ORGANIZATIONS.length; i++){
    originy = originy + separator;  
    if (i == 3) {
      originx = originx + 80;
      originy = INFO_PANEL_Y + separator;
    }
    text(ORGANIZATIONS[i] +": " + issue_count_per_organization(ORGANIZATIONS[i]), originx, originy);
    for (j = 0; j < BUILDINGS.length; j++){
      originy = originy + separator;
      text("  " + BUILDINGS[j] + ": " + issue_count_per_organization_and_building(ORGANIZATIONS[i], BUILDINGS[j]), originx, originy);
    }
  }

  originy = originy + (2*separator);
  text("Total: " + iset.size(), originx, originy);
  
  if (selected_issue > 0) {
    
    Issue issue = (Issue)iset.get(selected_issue);

    text(issue.id, ISSUE_PANEL_X, ISSUE_PANEL_Y);
    text("Date opened: " + format_date_string(issue.open_date), ISSUE_PANEL_X, ISSUE_PANEL_Y + (separator * 1));
    text("Status: " + issue.status, ISSUE_PANEL_X, ISSUE_PANEL_Y + (separator * 2));
    text("Building: " +  issue.building + ". Level " + issue.level + ". Zone: " + issue.zone, ISSUE_PANEL_X, ISSUE_PANEL_Y + (separator * 3));
    text("Location in grid: " + issue.x1 + ", " + issue.x2 + " / " + issue.y1 + ", " + issue.y2, ISSUE_PANEL_X, ISSUE_PANEL_Y + (separator * 4));
    text("Discipline: " + issue.discipline + ", Trade: " + issue.trade + ". ", ISSUE_PANEL_X, ISSUE_PANEL_Y + (separator * 5));
    text("Responsible organization: " + issue.organization, ISSUE_PANEL_X, ISSUE_PANEL_Y + (separator * 6));
    text("Responsible person: " + issue.person, ISSUE_PANEL_X, ISSUE_PANEL_Y + (separator * 7));
    text(issue.description, ISSUE_PANEL_X, ISSUE_PANEL_Y + (separator * 8), 250, 100);
    //println("path: " + issue.imagepath.substring(issue.imagepath.length() - 9));
    
    try {
      if (issue.imagepath.substring(issue.imagepath.length() - 9).equals(".DS_Store")){
      }
      else{
        b = loadImage(issue.imagepath);
        image(b, 1000, 340);  
        }
    }
    catch (Exception e){
      
    }
  }
}


String[] listFileNames(String dir) {
     File file = new File(dir);
     if (file.isDirectory()) {
      String names[] = file.list();
      return names;
     }
     else {
    // If it’s not a directory
       println("not a valid directory.");
       return null;
  }
}


void trace(){
  
   println("");
   println("");
   println("No. Of Issues: " + good_issues_count);
   println("No. Of Bad Issues: " + bad_issues_count);
   println("No. of elements in ArrayList : " + issue_set.size());
   println("# of AEDAS issues: " + issue_count_per_organization("AEDAS"));
   println("# of AREP issues: " + issue_count_per_organization("AREP"));
   println("# of DDD issues: " + issue_count_per_organization("DDD"));
   println("# of ETA issues: " + issue_count_per_organization("ETA"));
   println("# of EVS issues: " + issue_count_per_organization("EVS"));
   println("# of SSJV issues: " + issue_count_per_organization("SSJV"));
}
