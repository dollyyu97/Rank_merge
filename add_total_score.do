
use BA-total, clear

append using Fin-total Econ-total CS-total Maths-total Phy-total Poli-total Socio-total Educ-total, force

*check if all obs are imported
tab subject year

replace total_score = 1.5*PUB + 0.5*CNCI + 0.1*IC+ TOP if subject == "Finance" 
													   
replace total_score = 1.5*PUB + 0.5*CNCI + 0.1*IC+ TOP +AWARD if subject == "Economics"

replace total_score = 1.5*PUB + 0.5*CNCI + 0.1*IC + TOP if subject ==  "Business Administration" ///
														& year != 2017
replace total_score = 1.5*PUB + 0.5*CNCI + 0.1*IC + 1.5*TOP if subject ==  "Business Administration" ///
														& year == 2017


replace total_score = PUB + CNCI + 0.2*IC + TOP+ AWARD if subject == "Mathematics"
replace total_score = PUB + CNCI + 0.2*IC + TOP+ AWARD if subject == "Physics"

replace total_score = PUB + CNCI + 0.2*IC + TOP + AWARD if subject == "Computer Science & Engineering" ///
												& year != 2017
												
replace total_score = PUB + CNCI + 0.2*IC + 0.2*TOP + 1.8*AWARD if subject == "Computer Science & Engineering" ///
												                & year == 2017
replace total_score = 1.5*PUB + 0.5*CNCI + 0.1*IC +1.5*TOP if subject == "Education"  
replace total_score = 1.5*PUB + 0.5*CNCI + 0.1*IC +1.5*TOP if subject == "Political Sciences" 
replace total_score = 1.5*PUB + 0.5*CNCI + 0.1*IC +1.5*TOP if subject == "Sociology"

assert total_score != . 

* Generate new ranking according to calculated total score
bysort subject year: egen ranking = rank(total_score), f
sort subject year ranking

order ranking, first 
drop rank 

save Final_rank.dta, replace


