

void make_gui(){

	cp5 = new ControlP5(this);

  myKnobA = cp5.addKnob("radius_a")
               .setRange(300,900)
               .setValue(RAD)
               .setPosition(KNOBS_X,KNOBS_Y)
               .setRadius(KNOB_RADIUS)
               .setViewStyle(Knob.ARC)
               .setColorForeground(color(100,100,100))
               .setColorBackground(color(20, 20, 20))
               .setColorActive(color(30,30,30))
               .setDragDirection(Knob.HORIZONTAL)
               ;
                     
  myKnobB = cp5.addKnob("radius_b")
               .setRange(300,1000)
               .setValue(RAD_MID)
               .setPosition(KNOBS_X + KNOB_SEPARATION, KNOBS_Y)
               .setRadius(KNOB_RADIUS)
               .setViewStyle(Knob.ARC)
               .setColorForeground(color(100,100,100))
               .setColorBackground(color(20, 20, 20))
               .setColorActive(color(30,30,30))
               .setDragDirection(Knob.HORIZONTAL)
               ;

  myKnobB = cp5.addKnob("radius_c")
               .setRange(50,900)
               .setValue(RAD_INNER)
               .setPosition(KNOBS_X + (KNOB_SEPARATION*2), KNOBS_Y)
               .setRadius(KNOB_RADIUS)
               .setViewStyle(Knob.ARC)
               .setColorForeground(color(100,100,100))
               .setColorBackground(color(20, 20, 20))
               .setColorActive(color(30,30,30))
               .setDragDirection(Knob.HORIZONTAL)
               ;

  cp5.addSlider("dates")
     //.setFont(font)
     .setPosition(SLIDER_POSX, SLIDER_POSY)
     .setRange(0,255)
     .setNumberOfTickMarks(dates.size())
     .setWidth(SLIDER_WIDTH)
     .showTickMarks(true)
     .snapToTickMarks(true)
     .setMin(0)
     .setMax(issue_set.size())
     //.setMax(dates.size()-1)
     .setColorActive(100)
     .setColorBackground(255)
     .setColorForeground(200)
     ;

  cp5.getController("radius_a")
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(10)
     ;

  cp5.getController("radius_b")
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(10)
     ;

  cp5.getController("radius_c")
     .getCaptionLabel()
     .setFont(font)
     .toUpperCase(false)
     .setSize(10)
     ;


  cb = cp5.addCheckBox("checkBox")
      .setPosition(KNOBS_X, KNOBS_Y - 20)
      .setColorForeground(color(0))
      .setColorBackground(40)
      .setColorActive(color(255))
      .setColorLabel(color(255))
      .setSize(10, 10)
      .setItemsPerRow(3)
      .setSpacingColumn(20)
      .setSpacingRow(5)
      .addItem("PS", 0)
      .addItem("TR", 1)
      //.addItem("100", 100)
      //.addItem("150", 150)
      //.addItem("200", 200)
      //.addItem("255", 255)
      ;
}


void keyPressed() {
  if (key==' ') {
    cb.deactivateAll();
  } 
  else {
    for (int i=0;i<6;i++) {
      // check if key 0-5 have been pressed and toggle
      // the checkbox item accordingly.
      if (keyCode==(48 + i)) { 
        // the index of checkbox items start at 0
        cb.toggle(i);
        println("toggle "+cb.getItem(i).name());
        // also see 
        // checkbox.activate(index);
        // checkbox.deactivate(index);
      }
    }
  }

  if (key == 'k'){
      save("image.png");
  }
}

void radius_a(int theValue) {
  //knob a
  //myColorBackground = color(theValue);
  RAD = theValue;
  //println("a knob event: "+theValue);
}

void radius_b(int theValue) {
  //knob b
  //myColorBackground = color(theValue);
  RAD_MID = theValue;
  //println("a knob event: "+theValue);
}

void radius_c(int theValue){
//knob c
  RAD_INNER = theValue;
}

void dates(float value) {
  update_iset_2((int) value);
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(cb)) {
    
    petal_switch = (int) cb.getArrayValue()[0]; 
    tree_switch = (int) cb.getArrayValue()[1];
    } 
}    
  


void checkBox(float[] a) {
  println(a);
}

