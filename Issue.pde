import java.util.Date;
import java.text.SimpleDateFormat;

DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");

class Issue {

  boolean is_on;
  int     id;
  String  building;
  String  level;
  String  trade;
  String  discipline;
  String  zone;
  int     x1;
  int     x2;
  String  y1;
  String  y2;
  String  description;
  Date    open_date;
  String  status;
  String  action;
  String  person;
  String  organization;
  String  imagepath;

  Issue (String[] values) {
    if (values[0].equals("") || values[0].length() != 5 || int(values[0]) == 0) {
      println("Illegal Argument Exception 1");
      throw new IllegalArgumentException();  
    }
 
    try {
      
      id =           int(values[0]);
      building =     values[1];
      level =        values[2];
      trade =        values[3];
      discipline =   values[4];
      zone =         values[7];
      x1 =           int(values[8]);
      x2 =           int(values[9]);
      y1 =           values[10];
      y2 =           values[11];
      description =  values[14];
      open_date =    parseDate(values[15]);
      status =       values[16];
      action =       values[19];
      person =       values[20];
      organization = values[21];
      imagepath =    "test"; // IMAGEFOLDERPATH + "/" + IMAGES[(int)random(IMAGES.length)];
      
    } catch (Exception e) {

      println("Illegal Argument Exception 2");
      throw new IllegalArgumentException();
    
    }
  }

  void update() {
  }

  String toString() {
    String r = "id: " + id + "\n";
    r += "open_date: " + open_date + "\n";
    return r;
  }

  Date parseDate(String txt) throws ParseException {
    return dateFormat.parse(txt);
  }
}
