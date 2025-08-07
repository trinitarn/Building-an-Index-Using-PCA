### 🎓 Does Wife’s Power in Household Decision-Making Improve PKH Effectiveness?
Analyzing Indonesia's Cash Transfer Program with PCA and Logistic Regression. 
Bachelor’s Thesis | Universitas Indonesia | 2025

**🧠 Project Overview**

This research investigates whether the wife’s role in household financial decisions enhances the effectiveness of Program Keluarga Harapan (PKH) — Indonesia’s flagship conditional cash transfer program — in reducing household poverty.
To explore this, I built a custom decision-making index (IPK Index) using Principal Component Analysis (PCA) in Python, and then ran a binary logistic regression in Stata to test its influence on poverty outcomes.

**💡 The novelty** lies in measuring women's decision-making power as an index and testing its interaction effect with PKH, something no previous study has done using IFLS data.

**🗂️ Dataset Structure Source** 

Indonesia Family Life Survey (IFLS) Wave 5
Sample: Households with mothers present, with a subset receiving PKH

**Variables:**

Dependent: Poverty status (binary — below/above provincial poverty line)

Independent: Custom-built IPK Index (wife's decision-making power)

Interaction: IPK × PKH receipt status

Controls: Wife’s age, education, employment, location, household consumption

**🧩 Index Construction (IPK)**
Using PCA in Python, I processed 10+ decision-related variables, including:
Food & clothing purchases
Children's education & health
Giving money to parents/in-laws
Major household purchases

**📊 Insight Summary**
PKH does significantly reduce poverty — households receiving it have a lower probability of being poor.
However, the wife's role in decision-making (IPK Index) does not significantly improve PKH’s effectiveness.
There is no significant interaction effect between women’s decision-making power and PKH receipt status on poverty reduction.
The data suggests structural limitations — even when women are targeted as recipients, social norms may still hinder their decision-making impact.

**✅ Recommendation**
While targeting women as PKH recipients is backed by literature, this study reveals that:
Empowerment is not automatic. Structural reform and family-level education are essential.
Programs like P2K2 (PKH’s family education module) should increase focus on shifting household decision-making dynamics, not just budgeting skills.
Future research and policy should go beyond targeting women, and work on enabling their authority in actual financial choices.

## Let Me Walk You Through The Steps:

1. [b3a_pk2_4.csv](https://github.com/trinitarn/Principal-Component-Analysis-to-Make-Women-s-Sense-of-Control-Index/blob/main/b3a_pk2_4.csv) is the dataset consists of household decision making dataset. Hence, we'll use it to make our IPK Indice, or the index which reflects the level of wife's decision making in the household. The tool used is Python in our [data](https://github.com/trinitarn/Principal-Component-Analysis-to-Make-Women-s-Sense-of-Control-Index/blob/main/DATA.ipynb).

2. Now, we use STATA to generate the PCA index. We do trials and errors, rotations and so on until the result is interpretable. But first, you need to make sure that the families in your sample has a wife that still alive [here](https://github.com/trinitarn/Principal-Component-Analysis-to-Make-Women-s-Sense-of-Control-Index/blob/main/istri_5.dta). You can see the code [here](https://github.com/trinitarn/Principal-Component-Analysis-to-Make-Women-s-Sense-of-Control-Index/blob/main/making%20the%20pca.do) and the PCA dataset [here](https://github.com/trinitarn/Principal-Component-Analysis-to-Make-Women-s-Sense-of-Control-Index/blob/main/siappca012_5.csv).

3. Then, after some data cleaning, we get [this](https://github.com/trinitarn/Principal-Component-Analysis-to-Make-Women-s-Sense-of-Control-Index/blob/main/siapregress.dta) dataset. Now, you can process the regression with [this](https://github.com/trinitarn/Principal-Component-Analysis-to-Make-Women-s-Sense-of-Control-Index/blob/main/processing%20the%20regression.do).
