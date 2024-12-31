# Soc265-Quantitative-Methods
A repository for all assignments completed for Sociology 265, Quantitative Methods. All data used is from the platfomr ICPSR, with the ID# of 26801, which is a dataset about NCAA Academic Progress Rates.

### Crosstab Assignment
The file "CrosstabHW.R" is the result of the first assignment of this class which was to do a crosstabulation on a dataset of our choice. In this assignment, I created a new variable to turn the interval values of APR into a scale of "Average", "Above Average", and "Below Average" and evaluated the number of baseball, football, men's cross country, and men's basketball teams that fell into each category in a crosstab. I concluded that football had the worst APR scores with most teams below average, while men's cross country had the best scores with most teams above average. Meanwhile, baseball teams tended to have average APR scores while basketball skewed below average but still had a significant number of teams with average APR scores.

### 2-Way ANOVA Assignment
The file "ANOVAHW.R" is the result of the second assignment of this class which was to do a two way ANOVA on a dataset of our choice. In this assignment, I tested whether the division of play had an effect on the relationship between APR and gender. In this assignment, I created a dummy variable for gender based on the provided sports codes. I concluded that although being male had a significant negative effect on APR, participation at the Division 3 level had an almost equal positive effect.

### Regression Assignment
The file "RegressionHW.R" is the result of the third anf findal assignment of this class which was to conduct regression analysis on a dataset of our choice. In this assignment, I tested the effect of participation in a Power 5 conference, revenue sport, likliehood of future professional career, team size, type of college (public or private), and whether the student attends an HBCU. I created dummy variables for gender, Power 5 conference, revenue sport, and liklihood of future professional career. I concluded that gender does not seem to have the greatest effect on APR, instead it is attending an HBCU.
