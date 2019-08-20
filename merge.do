
cd "C:\Users\dyu\Dropbox\Boris_all_projects\Academic_Wage\Shanghai_Ranking"

use Final_rank, clear 
keep if year == 2017

*generate Field variable for merging
gen Field = ""

replace Field = "FIN" if subject == "Finance" 
replace Field = "ECO" if subject == "Economics" 
replace Field = "CS" if subject == "Computer Science & Engineering" 
replace Field = "BUSI" if subject == "Business Administration" 
replace Field = "MATH" if subject == "Mathematics"
replace Field = "PHYS" if subject == "Physics"
replace Field = "HUM" if Field == ""

*generate average humanities score and ranking across three fields 
bys institution: egen ave_hum_score = mean(total_score) if Field == "HUM" 
replace total_score = ave_hum_score if Field == "HUM" 

duplicates drop institution Field ave_hum_score, force

egen new_rank = rank(ave_hum_score) if Field == "HUM", f
replace ranking = new_rank if Field == "HUM" 
drop new_rank ave_hum_score

sort Field ranking

*
gen uni_lower = lower(institution)

save rankigs_to_merge.dta, replace 



