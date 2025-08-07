set more off
clear

cd "C:\Users\nitar\Documents\sekripsi\REVISI DUA PER TIGA"

// drop families who are no longer having a wife

use hhid14_9 ar02b ar07 using "bk_ar1_5.dta", clear
save temp_istri_5.dta, replace
use "istri5_data.dta", clear
merge 1:m hhid14_9 using temp_istri_5.dta

tab _merge
drop _merge
save "istri_5.dta", replace

use istri5_data, clear
gen istri = (ar07 == 3 & ar02 == 2)
drop istri == 0
duplicates drop hhid07_9, force

save data_5_fix.dta, replace

// merging the dataset

use bk_sc1_5.dta, clear
rename sc01_14_14 KodeProvinsiAR18i
save bk_sc1_5.dta, replace

use KodeProvinsiAR18i MeanGK Cons_14 using "gk_5.dta", clear
save temp_5.dta, replace
use "bk_sc1_5.dta", clear
merge m:1 KodeProvinsiAR18i using temp_5.dta

tab _merge
drop _merge
duplicates drop hhid14_9, force
drop sc10 sc12 sc13 sc14 sc15 sc21x sc21 
save "sample_5.dta", replace

// process in index making using pca 

clear 
cd "C:\Users\nitar\Documents\sekripsi\REVISI DUA PER TIGA"
import delimited "C:\Users\nitar\Documents\sekripsi\REVISI DUA PER TIGA\siappca012_5.csv"

drop v1
pca a1 a2 b c d e f g h i j k l m n o p q
predict pca_index, score
rename pca_index pca_01_4
rename hhid07 hhid 
duplicates drop hhid, force
keep hhid pca_01_4
save index_pkh014.dta, replace