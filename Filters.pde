int issue_count_per_organization(String organization){
  // returns a count of the issues belinging to a specific organization
 int r, i; 
 r = 0;
 Issue issue;

  for (i = 0; i < iset.size(); i++){
    issue = (Issue)iset.get(i); 
    if (organization.equals(issue.organization)){
    r ++;  
  }
 }
 return r;
}

int issue_count_per_organization_and_building(String organization, String building){

  int r, i; 
  r= 0;
  Issue issue;
  
  for (i = 0; i < iset.size(); i++){
    issue = (Issue)iset.get(i);
    if ((organization.equals(issue.organization) && (building.equals(issue.building)))){
     r++; 
    }
  }
  return r;
}

ArrayList issues_per_organization(String organization){

  // returns the Issues per trade
 
  int i;
  Issue issue;
  ArrayList r;
  r = new ArrayList();
      
  for (i = 0; i < iset.size(); i++){
    issue = (Issue)iset.get(i);
   if (organization.equals(issue.organization)){ 
     r.add(issue);
   }
  }
  return r;
}

int find_issue(String organization, int index) {
 int counter = 0;
 for (int i = 0; i < iset.size(); i++){
   Issue issue = (Issue) iset.get(i);
   if (organization.equals(issue.organization)) {
    if (counter == index) {
      return i;
    } else {
      counter++;
    }
   }
 }
 return -1;
}

