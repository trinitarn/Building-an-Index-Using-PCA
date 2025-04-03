set more off
clear
cd "C:\Users\nitar\Documents\sekripsi\dua per tiga\pca\trial 1"

* Load the dataset with decision-making variables
use "b3a_pk2.dta", clear

* Create binary variables for each decision-maker
gen decision_A = strpos(pk18, "A") > 0  
gen decision_B = strpos(pk18, "B") > 0  
gen decision_C = strpos(pk18, "C") > 0  
gen decision_D = strpos(pk18, "D") > 0  
gen decision_E = strpos(pk18, "E") > 0  
gen decision_F = strpos(pk18, "F") > 0  
gen decision_G = strpos(pk18, "G") > 0  
gen decision_H = strpos(pk18, "H") > 0  
gen decision_I = strpos(pk18, "I") > 0  

* Collapse data to household level
collapse (sum) decision_A decision_B decision_C decision_D decision_E decision_F decision_G decision_H decision_I, by(hhid07)

* Perform PCA
pca decision_B decision_C decision_D decision_E decision_F decision_G decision_H decision_I
predict pca_index, score

rotate, varimax blanks(.3)

* Rescale PCA scores
egen min_pca = min(pca_index)
egen max_pca = max(pca_index)
gen pca_rescaled = (pca_index - min_pca) / (max_pca - min_pca)

//

keep hhid07 pca_rescaled
save "pca_index.dta", replace

use "b1_ksr1.dta", clear

* Keep only relevant variables
keep hhid07 ksr17

keep if ksr17 == 1

//
use "b1_ksr1.dta", clear
duplicates report hhid07
duplicates drop hhid07, force
save "b1_ksr1_clean.dta", replace
//
use "pca_index.dta", clear
duplicates report hhid07
duplicates drop hhid07, force
save "pca_index_clean.dta", replace

* Merge with PCA index dataset
merge 1:1 hhid07 using "pca_index_clean.dta"

* Keep only matched households
keep if _merge == 3
drop _merge

* Save the final merged dataset
save "pca_merged.dta", replace

//

* Plot histogram
histogram pca_rescaled, density normal title("Density Plot of Scaled PCA Index (PKH Recipients)") color(blue)
