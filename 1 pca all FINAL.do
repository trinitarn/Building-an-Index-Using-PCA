set more off 
clear
cd "C:\Users\nitar\Documents\sekripsi\dua per tiga\pca\trial 1"

use "b3a_pk2.dta"

* Create binary variables for each decision-maker
gen decision_A = strpos(pk18, "A") > 0  // 1 if "A" is in pk18, else 0
gen decision_B = strpos(pk18, "B") > 0  
gen decision_C = strpos(pk18, "C") > 0  
gen decision_D = strpos(pk18, "D") > 0  
gen decision_E = strpos(pk18, "E") > 0  
gen decision_F = strpos(pk18, "F") > 0  
gen decision_G = strpos(pk18, "G") > 0  
gen decision_H = strpos(pk18, "H") > 0  
gen decision_I = strpos(pk18, "I") > 0  

* Check if it's working
list pk18 decision_A decision_B decision_C if _n <= 10  

collapse (sum) decision_A decision_B decision_C decision_D decision_E decision_F decision_G decision_H decision_I, by(hhid07)

pca decision_B decision_C decision_D decision_E decision_F decision_G decision_H decision_I
predict pca_index, score

rotate, varimax blanks(.3)

egen min_pca = min(pca_index)
egen max_pca = max(pca_index)
gen pca_rescaled = (pca_index - min_pca) / (max_pca - min_pca)

histogram pca_rescaled, density normal title("Density Plot of Scaled PCA Index") color(blue)

histogram pca_rescaled, frequency xlabel(0(0.1)1) title("Distribution of Scaled PCA Index") color(blue)