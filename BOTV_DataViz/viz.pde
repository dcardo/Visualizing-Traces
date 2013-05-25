//
// BOTV_DataViz
// Daniel Cardoso Llach
//
// http://mit.edu/dcardoso/www
// http://vimeo.com/51693897
//
// Visualization and Geometry Code
// http://creativecommons.org/licenses/by-nc/3.0/
//
// -------------------------------------


void draw_rings(){
    
  strokeWeight(0.25);
  stroke(100);
  noFill();
  
  float posx, posy, posmidx, posmidy, outerposx, outerposy, innerposx1, innerposy1, innerposx2, innerposy2, posx2, posy2, iposx, iposy;
  float bposx, bposy, bposmidx, bposmidy, outerposmidx, outerposmidy;
  int internal_radius, middle_radius;
  int i, j, k, l;
  int issues_per_organization;
  int issues_per_organization_and_building;
  float theta, phi, phi_mid, theta_mid, gamma, test_factor, sigma;
  float increment, small_increment, building_increment, outer_increment;

  internal_radius = RAD_INNER/2;
  middle_radius = RAD_MID/2;

  increment = 0;
  building_increment = 0;
  theta = 2*PI;
  phi = 2*PI;
  gamma = 2*PI;
  sigma = 2*PI;
  test_factor = 0;
  
  float[] organization_ratios = new float[ORGANIZATIONS.length];
  float[] building_ratios = new float[BUILDINGS.length];

  // DRAW RINGS

  // OUTER ELLIPSE
  ellipse(CENTERX, CENTERY, RAD, RAD);

  // MIDDLE ELLIPSE
  ellipse(CENTERX, CENTERY, RAD_MID, RAD_MID);

  // INNER ELLIPSE
  ellipse(CENTERX, CENTERY, RAD_INNER, RAD_INNER);
  
  strokeWeight(0.75);

  // inner ring: organizations
  for (i = 0; i < 6; i++){

    // define the proportions of the circle for defining the organization
    organization_ratios[i] = (float)issue_count_per_organization(ORGANIZATIONS[i])/iset.size();   
    issues_per_organization = issue_count_per_organization(ORGANIZATIONS[i]);
    
    // find angle boundaries for organization on inner ring
    theta = 2*PI*(organization_ratios[i]+increment);
    theta_mid = 2*PI*((organization_ratios[i]/2)+increment);

    // points on inner ring
    posx = CENTERX + (cos(theta)*internal_radius);
    posy = CENTERY - (sin(theta)*internal_radius);

    // points on middle ring
    posx2 = CENTERX + (cos(theta)*middle_radius);
    posy2 = CENTERY - (sin(theta)*middle_radius);

    // middle (branch) points on inner ring 
    posmidx = CENTERX + (cos(theta_mid)*internal_radius);
    posmidy = CENTERY - (sin(theta_mid)*internal_radius);

    // middle (branch) points for bezier control
    outerposmidx = CENTERX + (cos(theta_mid)*(internal_radius + 50));
    outerposmidy = CENTERY - (sin(theta_mid)*(internal_radius + 50));

    // draw organization bounding points
    stroke(0, 0, 255);
    strokeWeight(0.45);
    //ellipse(posx, posy, 5, 5);
    //ellipse(outerposmidx, outerposmidy, 20, 20);
    //line (posx2, posy2, CENTERX, CENTERY);
    stroke(255, 0, 0);
    rect(posmidx-3, posmidy-3, 6, 6);
    line(CENTERX, CENTERY, posmidx, posmidy);    
    text(ORGANIZATIONS[i], posmidx + 10, posmidy + 10);

    phi = theta;

    // middle ring: buildings 
    for (l = 0; l < 5; l++){ // for each building in an organization

      // starting angle
      issues_per_organization_and_building = issue_count_per_organization_and_building(ORGANIZATIONS[i], (String) BUILDINGS[l]);
      building_ratios[l] = (float) issues_per_organization_and_building/iset.size();

      // find angle boundaries for organization on inner ring
      phi = 2*PI*(building_ratios[l] + building_increment);
      phi_mid = 2*PI*((building_ratios[l]/2) + building_increment);

      bposx = CENTERX + (cos(phi)*middle_radius);
      bposy = CENTERY - (sin(phi)*middle_radius);

      // middle poings on middle ring

      bposmidx = CENTERX + (cos(phi_mid) * middle_radius);
      bposmidy = CENTERY - (sin(phi_mid) * middle_radius);

      // draw organization bounding points
      stroke(255, 0, 255);
      strokeWeight(1);
      if (issues_per_organization_and_building > 0){ // only draw branch if there are issues
        line(bposmidx, bposmidy, posmidx, posmidy); 
        stroke(0,0,255);
        strokeWeight(0.45);
        //ellipse(bposx, bposy, 5, 5);
        stroke(255, 0, 255);
        strokeWeight(0.7);
        rect(bposmidx-3, bposmidy-3, 6, 6);
        text((String) buildings.get(l), bposmidx + 10, bposmidy + 10);  
      }
      



      //if (viz_mode == 0){

        for (k = 0; k < issues_per_organization_and_building; k++){

          // angle
          sigma = 2*PI*(((building_ratios[l]/issues_per_organization_and_building)*k) + building_increment);

          // position
          iposx = CENTERX + (cos(sigma)*RAD/2);
          iposy = CENTERY - (sin(sigma)*RAD/2);

          // drawing
          strokeWeight(0.1);
          stroke(colors_buildings[l]);
          //ellipse(iposx, iposy, 3, 3);
          //strokeWeight(0.1);
          
          //  LINE **** NEEDS TO BE SPLINE
          line(bposmidx, bposmidy, iposx, iposy);
          

        }

        building_increment = building_increment + building_ratios[l];

      //}

    }
  
  
    // draw all issues in outer ring
    boolean found_pick = false;
    
    for (j = 0; j < issues_per_organization; j++){

      gamma = 2 * PI * (((organization_ratios[i] / issues_per_organization) * j) + increment);
      
      posx = CENTERX + (cos(gamma)*RAD/2);
      posy = CENTERY - (sin(gamma)*RAD/2);
      
      // bezier control geometry
      outerposx = CENTERX + (cos(gamma)*((RAD/2)-50));
      outerposy = CENTERY - (sin(gamma)*((RAD/2)-50));

      //innerposx1 = CENTERX + (cos(gamma)*(middle_radius-(SEPARATION/2)+20));
      //innerposy1 = CENTERY - (sin(gamma)*(middle_radius-(SEPARATION/2)+20));

      //innerposx2 = CENTERX + (cos(gamma)*(middle_radius-SEPARATION));
      //innerposy2 = CENTERY - (sin(gamma)*(middle_radius-SEPARATION));

      // outer construction line
      //line (posx, posy, outerposx, outerposy);
      
      // BEZIER
      
      // draw bezier to pick buffer with an color that encondes the id of the issue
      
      color id = color(i, j, 0);        
      
      pick_buffer.beginDraw();
      pick_buffer.stroke(id);
      pick_buffer.bezier(posx, posy, outerposx, outerposy, outerposmidx, outerposmidy, posmidx, posmidy);
      pick_buffer.endDraw();

      // is the mouse over a pixel with the same id?       
      
      color value = pick_buffer.get(mouseX, mouseY);
      
      if (value == id && !found_pick) {
        stroke(255, 0, 0);
        found_pick = true;
        selected_issue = find_issue(ORGANIZATIONS[i], j);
      } else {
        //strokeWeight(1);
        stroke(0,255,0);
      }

      strokeWeight(0.25);
      
      // older beziers

      if (petal_switch == 1){
        //bezier(posmidx, posmidy, CENTERX, CENTERY, outerposx, outerposy, posx, posy);
        
        // petals
        //bezier(posx, posy, CENTERX, CENTERY, outerposx, outerposy, posmidx, posmidy);
        //bezier(posx, posy, outerposx, outerposy, innerposx1, innerposy1, innerposx2, innerposy2);

        // well formed bezier: draw to main canvas
        stroke(colors_organizations[i]);
        bezier(posx, posy, outerposx, outerposy, outerposmidx, outerposmidy, posmidx, posmidy);
      }
      else{

      }

      
    }


    increment = increment + organization_ratios[i];
  }
}
  
  

