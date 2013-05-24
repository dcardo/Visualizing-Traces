
import java.lang.IllegalArgumentException;
import controlP5.*;
float[] datesarray; 

PFont pfont = createFont("verdana",20, false); // use true/false for smooth/no-smooth
ControlFont font = new ControlFont(pfont,200);

// SOURCE

String DATASOURCE = "issuedata.csv";
//String IMAGEFOLDERPATH = "/Users/Daniel/Dropbox/0 BUILDERS_DATAVIZ/1 CODE/bimviz/data/issue_images";
String IMAGEFOLDERPATH = "issue_images";
//String IMAGEFOLDERPATH = "test";

// DATA STRUCTURES

ArrayList issue_set;              // this arraylist contains all of the issue data
ArrayList iset;                   // this arraylist contains only the "active" data (changes with date)
ArrayList dates;                  // this arrayList is to store the dates
ArrayList organizations;          // this arrayList is to store the organizations
ArrayList buildings;		  // this arrayList is to store the buildings

PGraphics pick_buffer;
int selected_issue = -1;

int bad_issues_count  = 0;
int good_issues_count = 0;
int date_counter;
int viz_mode = 0;

Date active_date;

// DATA FIELDS

String FIELDS[] = {"INDEX", "BUILDING", "LEVEL", "TRADE", "INT CODE", "DISCIPLINE", "DWG REF", "ZONE", "GRID X1", "GRID X2", "GRID Y1", "GRID Y2", "GT CODE", "KEY", "ISSUE DESCRIPTION", "OPENING DATE", "STATUS", "ACTION BY DATE", "LAST CHANGE", "ACTION", "BY NAME", "ORGANIZATION", "RFI", "EXT MEETING DATE", "EXT. MEETING ACTION"};
String ORGANIZATIONS[] = {"ARCH", "INTS", "CONS", "CONC", "MEP", "STEL"};
String BUILDINGS[] = {"B1", "B2","B3", "B4", "B5"}; // ZONE1_
String IMAGES[]; 

// VISUAL VARIABLES

CheckBox cb; // checkbox

int RAD = 800;
int SEPARATION = 250;

int RAD_INNER = 300; 
int RAD_MID = 550;

int INFO_PANEL_X = 1000; //10;
int INFO_PANEL_Y = 600; //15;

int ISSUE_PANEL_X = 1000;
int ISSUE_PANEL_Y = 150;

int MY_WIDTH = 1300;
int MY_HEIGHT = 1000;

int CENTERX = 500;
int CENTERY = 500;

int SLIDER_WIDTH = 700;
int SLIDER_POSX = 50;
int SLIDER_POSY = 100;

int KNOBS_X = SLIDER_POSX + SLIDER_WIDTH + 50;
int KNOBS_Y = SLIDER_POSY;
int KNOB_SEPARATION = 60;
int KNOB_RADIUS = 20;

int petal_switch = 0;
int tree_switch = 0;

// COLORS

color[] colors_organizations = {color(0, 0, 255), color(91, 198, 140), color(90, 255, 126), color(188, 255, 97), color(191, 214, 0), color(204, 153, 0)};
color[] colors_buildings = {color(167, 171, 240), color(59, 151, 255), color(100, 100, 255), color(101, 97, 170), color(163, 148, 255)};

// GUI

ControlP5 cp5;
int knobValue = 100;
Knob myKnobA;
Knob myKnobB;
Range range;
Slider date_slider;


// FONTS

PFont myFont; // used to create font
