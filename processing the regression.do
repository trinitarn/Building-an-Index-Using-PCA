set more off
clear
cd "C:\Users\nitar\Documents\sekripsi\REVISI TIGA PER TIGA DATA\bersiin data"

use siapregress.dta, clear
drop if missing(pca_index)
drop if missing(sc05)
drop if missing(pkh)
drop if missing(status_miskin)
drop if missing(status_miskin_ekstrim)
drop if missing(edu_istri)
drop if missing(edu_suami)
drop if missing(kerja_suami)
drop if missing(kerja_istri)
drop if missing(age_istri)
drop if missing(hhsize)

save siapregress.dta, replace

// regressnya 

use siapregress.dta, clear
logit status_miskin c.pca_index##pkh i.edu_istri i.edu_suami i.kerja_istri i.kerja_suami age_istri age_suami i.sc05, vce(robust)

outreg2 using analisis_2.doc, replace cti(Status Miskin)

use siapregress.dta, clear
logit status_miskin c.pca_index##pkh, vce(robust)

outreg2 using analisis_1.doc, replace cti(Status Miskin)

// sampe sini dulu status miskin ekstrim

use siapregress.dta, clear
logit status_miskin_ekstrim c.pca_index##pkh i.edu_istri i.edu_suami i.kerja_istri i.kerja_suami age_istri age_suami i.sc05, vce(robust)

outreg2 using analisis_2ekstrim.doc, replace cti(Status Miskin Ekstrim)

use siapregress.dta, clear
logit status_miskin_ekstrim c.pca_index##pkh, vce(robust)

outreg2 using analisis_1ekstrim.doc, replace cti(Status Miskin Ekstrim)

// yeay

use siapregress.dta, clear
drop status_miskin
save siapregress.dta, replace

use hhid14_9 status_miskin using "status_miskin.dta", clear
save temp_miskinhhgk.dta, replace
use "siapregress.dta", clear
merge 1:1 hhid14_9 using temp_miskinhhgk.dta

drop _merge
save siapregress.dta, replace

// nah ini regressnya
drop if missing(pca_index)
duplicates report hhid14_9

use siapregress.dta, clear
logit status_miskin c.pca_index##pkh i.edu_istri i.edu_suami i.kerja_istri i.kerja_suami age_istri age_suami i.sc05, vce(robust)

outreg2 using analisis_fix1coef.doc, replace cti(Status Miskin)

use siapregress.dta, clear
logit status_miskin c.pca_index##pkh, vce(robust)

outreg2 using analisis_fix2coef.doc, replace cti(Status Miskin)

use siapregress.dta, clear
logit status_miskin pca_index, vce(robust)

// sampe sini dulu

outreg2 using analisis_model1.doc, stnum(replace coef=exp(coef), replace se=coef*se) cti(odds ratio)

* Check multicollinearity with uncentered VIF
vif, uncentered

* Step 3: Check for model specification issues (linktest)
linktest

* If you're concerned about heteroskedasticity, use robust standard errors:
logit y x1 x2 x3, robust

logit status_miskin c.pca_index##pkh, vce(robust)

outreg2 using analisis_model2.doc, stnum(replace coef=exp(coef), replace se=coef*se) cti(odds ratio)

* Step 2: Check for multicollinearity (VIF)
vif

* Step 3: Check for model specification issues (linktest)
linktest

* If you're concerned about heteroskedasticity, use robust standard errors:
logit y x1 x2 x3, robust

// ini coba dibikin model yang pake karakteristik istri aja

logit status_miskin c.pca_index##pkh i.edu_istri i.kerja_istri age_istri ks02 i.sc05, vce(robust)

vif, uncentered 
linktest

// linktestnya jelek, ada specification term

gen pca_index2 = pca_index^2
gen age_istri2 = age_istri^2
gen ks02_2 = ks02^2

logit status_miskin c.pca_index##pkh c.pca_index2 c.age_istri c.age_istri2 c.ks02 c.ks02_2 i.edu_istri i.kerja_istri ks02 i.sc05, vce(robust)

// gangerti ini normalitynya gimana ujinya.... langsung autocor ajadeh

xtserial status_miskin c.pca_index c.age_istri c.ks02 i.edu_istri i.kerja_istri ks02 i.sc05

predict residuals, residuals
scatter residuals fitted_values

// uji normalitynya

swilk pca_index   // Shapiro-Wilk test for normality

// uji kelar bro, uji pca juga kelar yey

use siapregress.dta, replace 

logit status_miskin c.pca_index##pkh i.edu_istri i.kerja_istri age_istri ks02 i.sc05, vce(robust)

outreg2 using analisis_fix1coef.doc, replace cti(Coefficients)

logit status_miskin c.pca_index##pkh, vce(robust)

outreg2 using analisis_fix2coef.doc, replace cti(Coefficients)

outreg2 using analisis_fix1.doc, stnum(replace coef=exp(coef), replace se=coef*se) cti(odds ratio)

asdoc logit status_miskin c.pca_index##pkh, vce(robust), save(analisisdua.doc), replace

// ini masukin hh size

use bk_ar1.dta, clear
gen hhsize = !missing(ar02b)
collapse (sum) hhsize, by(hhid14_9)

save hhsize.dta, replace

use hhid14_9 hhsize using "hhsize.dta", clear
save temphhsize.dta, replace
use "siapregress.dta", clear
merge 1:1 hhid14_9 using temphhsize.dta

drop _merge 
save siapregress.dta, replace

// oke coba semuanya terus liat kovarians tiap variabelnya

use siapregress.dta, replace

logit status_miskin c.pca_index##pkh i.edu_istri i.edu_suami i.kerja_istri i.kerja_suami age_istri age_suami ks02 i.sc05, vce(robust)

correlate pca_index pkh edu_istri edu_suami kerja_istri kerja_suami age_istri age_suami ks02 sc05 hhsize, covariance

// berarti yang dibuang age suami aja sih

use siapregress.dta, replace

logit status_miskin c.pca_index##pkh i.edu_istri i.edu_suami i.kerja_istri i.kerja_suami age_istri ks02 i.sc05 hhsize, vce(robust)

outreg2 using analisis_fixxcoef.doc, replace cti(Coefficients)

logit status_miskin c.pca_index##pkh, vce(robust)
outreg2 using analisis_fixxcoef.doc, replace cti(Coefficients)

// tanpa konsumsi

use siapregress.dta, replace

logit status_miskin c.pca_index##pkh i.edu_istri i.edu_suami i.kerja_istri i.kerja_suami age_istri i.sc05 hhsize, vce(robust)

outreg2 using analisis_coef_nocons.doc, replace cti(Coefficients)

// bikin yg buat peta persebaran

use hhid14_9 sc01_14_14 using "bk_sc1_5.dta", clear
save temp_lokasibps.dta, replace
use "siapregress.dta", clear
merge 1:1 hhid14_9 using temp_lokasibps.dta

drop _merge
save siapregress.dta, replace

use siapregress.dta, clear
rename sc01_14_14 Province
drop if missing(pca_index)

sort Province pca_index
collapse (mean) pca_index, by(Province)
save persebaran.dta, replace

// kemiskinan ekstrim

use siapregress.dta, replace

use hhid14_9 status_miskin_ekstrim using "sample_5.dta", clear
save temp_ekstrim.dta, replace
use "siapregress.dta", clear
merge 1:1 hhid14_9 using temp_ekstrim.dta

drop _merge
save siapregress.dta, replace

logit status_miskin_ekstrim c.pca_index##pkh i.edu_istri i.edu_suami i.kerja_istri i.kerja_suami age_istri i.sc05 hhsize, vce(robust)

outreg2 using analisis_ekstrim_2.doc, replace cti(Status Miskin Ekstrim)

logit status_miskin_ekstrim c.pca_index##pkh, vce(robust)

outreg2 using analisis_ekstrim_1.doc, replace cti(Status Miskin Ekstrim)

