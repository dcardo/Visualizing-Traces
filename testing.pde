

void testing_issue_set(){

	println("Parsed issues: " + issue_set.size());

}

void test_filters(){
	// seems to be working fine
	int i, j;
	for (i = 0; i < dates.size(); i++){
		update_iset(date_counter);
		println(i + ": size of iset: " + iset.size());
		date_counter++;
	}
	println("Iset size: " + iset.size());
	for (i = 0; i < ORGANIZATIONS.length; i ++){
		println("");
		println("ORGANIZATION: " + ORGANIZATIONS[i] + ". Total issues: " + issue_count_per_organization(ORGANIZATIONS[i]));
		for (j = 0; j < BUILDINGS.length; j++){
			println(" -> " + BUILDINGS[j] + ": " + issue_count_per_organization_and_building(ORGANIZATIONS[i], BUILDINGS[j]));	
		}
	}
}


void test_issue_display(){




}


void test_load_random_image(){

	// works
	int i;
	String[] s = listFileNames("/Users/Daniel/Dropbox/0 BUILDERS_DATAVIZ/1 CODE/bimviz/data/issue_images");
	for (i = 0; i < s.length; i++){
		println(i + " :" +s[i]);
	}


}