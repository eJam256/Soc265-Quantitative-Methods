library(haven)
ANOVA_data <- read_sav("26801-0001-Data.sav")
ANOVA_data
view(ANOVA_data)
ANOVA_data <- subset(ANOVA_data, SPORT_CODE != 38)
##male = 0, female = 1
ANOVA_data <-ANOVA_data %>% mutate(gender = case_when(SPORT_CODE < 19 ~ "0", SPORT_CODE > 18 ~ "1"))
attach(ANOVA_data)
ANOVA_data
table(ANOVA_data$MULTIYR_APR_RATE_1000_OFFICIAL)
table(ANOVA_data$gender)
library(tidyverse)
library(dplyr)
##Create a new variable for being male [male sports = 1, female sports = 0]
ANOVA_data <- ANOVA_data %>% mutate(male = case_when(gender == 0 ~ 1, gender == 1 ~ 0))

gender_model <- lm(ANOVA_data$MULTIYR_APR_RATE_1000_OFFICIAL ~ male, data = ANOVA_data)
summary(gender_model)

##Create two new variables for division, [div 2 (division 1 = 0, div 2, div 3 = 0)] 
ANOVA_data <- ANOVA_data %>% mutate(div2 = case_when(SCL_DIV_14 == 2 ~ 1, SCL_DIV_14 == 1 ~ 0, SCL_DIV_14 == 3 ~ 0))
ANOVA_data <- ANOVA_data %>% mutate(div3 = case_when(SCL_DIV_14 == 3 ~ 1, SCL_DIV_14 == 1 ~ 0, SCL_DIV_14 == 2 ~ 0))

d2_model <- lm(ANOVA_data$MULTIYR_APR_RATE_1000_OFFICIAL ~ div2, data = ANOVA_data)
summary(d2_model)

d3_model <- lm(ANOVA_data$MULTIYR_APR_RATE_1000_OFFICIAL ~ div3, data = ANOVA_data)
summary(d3_model)

all_div_model <- lm(ANOVA_data$MULTIYR_APR_RATE_1000_OFFICIAL ~ div2 + div3, data = ANOVA_data)
summary(all_div_model)

gender_div_model <- lm(ANOVA_data$MULTIYR_APR_RATE_1000_OFFICIAL ~ male + div2 + div3, data = ANOVA_data)
summary(gender_div_model)

##make male d2, male d3 variables
ANOVA_data <- ANOVA_data %>% mutate(maled2 = if_else((male == 1 & div2 == 1), 1, 0))
ANOVA_data <- ANOVA_data %>% mutate(maled3 = if_else((male == 1 & div3 == 1), 1, 0))

interaction_model <- lm(ANOVA_data$MULTIYR_APR_RATE_1000_OFFICIAL ~ male + div2 + div3 + maled2 + maled3, data = ANOVA_data)
summary(interaction_model)

anova(gender_div_model, interaction_model)
anova(gender_div_model, gender_model)
