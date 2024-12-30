library(haven)
library(tidyverse)
install.packages("Hmisc")
library("Hmisc")
install.packages("corrplot")
library(corrplot)
install.packages("ggcorrplot")
library(ggcorrplot)
regression_data <- read_sav("26801-0001-Data.sav")
regression_data
View(regression_data)
regression_data <- subset(regression_data, SPORT_CODE != 38)
regression_data <- subset(regression_data, SCL_DIV_14 == 1)
regression_data
##male = 0, female = 1
regression_data <- regression_data %>% mutate(gender = case_when(SPORT_CODE < 19 ~ 0, 
                                                                 SPORT_CODE > 18 ~ 1))
attach(regression_data)
##Power 5 = 1, else = 0
regression_data <- regression_data %>% mutate(conf_5 = case_when((D1_FB_CONF_14 == "Pac-12 Conference" | D1_FB_CONF_14 == "Atlantic Coast Conference" | D1_FB_CONF_14 == "Big Ten Conference" | D1_FB_CONF_14 == "Big 12 Conference" | D1_FB_CONF_14 == "Southeastern Conference") ~ 1,
                                                               TRUE ~ 0))
table(regression_data$conf_5)
##revenue sport = 1, non revenue = 0
regression_data <- regression_data %>% mutate(revenue = case_when((SPORT_CODE == 2 | SPORT_CODE == 4) ~ 1,
                                                                  TRUE ~ 0))
##future pro = 1, no pro = 0
regression_data <- regression_data %>% mutate(future_pro = case_when((SPORT_CODE == 1 | SPORT_CODE == 2 | SPORT_CODE == 4 | SPORT_CODE == 8 | SPORT_CODE == 19 | SPORT_CODE == 27 | SPORT_CODE == 31) ~ 1, 
                                                                     TRUE ~ 0))
sapply(lapply(regression_data, unique), length)

##dummy variables
regression_data <- regression_data %>% mutate(male = case_when(gender == 0 ~ 1, 
                                                     gender == 1 ~ 0))


##additive model
all_model <- lm(regression_data$MULTIYR_APR_RATE_1000_OFFICIAL ~ conf_5 + male + revenue + future_pro + SCL_HBCU + SCL_PRIVATE + MULTIYR_SQUAD_SIZE, 
                data = regression_data)
summary(all_model)

##gender model
gender_model <- lm(regression_data$MULTIYR_APR_RATE_1000_OFFICIAL ~ gender, data = regression_data)
summary(gender_model)

##HBCU model
hbcu_model <- lm(regression_data$MULTIYR_APR_RATE_1000_OFFICIAL ~ SCL_HBCU, data = regression_data)
summary(hbcu_model)

##square squad size
regression_data$squad_squared = '^'(regression_data$MULTIYR_SQUAD_SIZE, 2)

##curvilinearity model
curve_model <- lm(regression_data$MULTIYR_APR_RATE_1000_OFFICIAL ~ conf_5 + male + revenue + future_pro + SCL_HBCU + SCL_PRIVATE + MULTIYR_SQUAD_SIZE + squad_squared, 
                  data = regression_data)
summary(curve_model)

##e is decimal points, move left
ggplot(data = regression_data, aes(x = MULTIYR_SQUAD_SIZE, y = MULTIYR_APR_RATE_1000_OFFICIAL)) + geom_point() + geom_smooth()
##don't need details, just say there is a non-linear relationship

##interaction variables
##regression_data <- regression_data %>% mutate(male_pro = if_else((male == 1 & future_pro == 1), 1, 0))
regression_data <- regression_data %>% mutate(male_power = if_else((male == 1 & conf_5 == 1), 1, 0))

##interaction model
interaction_model <- lm(regression_data$MULTIYR_APR_RATE_1000_OFFICIAL ~ conf_5 + male + revenue + future_pro + 
                          SCL_PRIVATE + SCL_HBCU + MULTIYR_SQUAD_SIZE + male_power, 
                        data = regression_data)
summary(interaction_model)
