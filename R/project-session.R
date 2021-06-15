source(here::here("R/package-loading.R"))

# Basics of R -------------------------------------------------------------

weight_kilos <- 100
weight_kilos

# Character vector
c("a", "b", "c")
# Logic vector
c(TRUE, FALSE)
# Numeric vector
c(1,2,4)
# Factor vector
factor(c("high", "medium", "low"))

head(CO2, 10) # first 10 rows
colnames(CO2) # column names
str(CO2) # structure
summary(CO2) #summary

colnames()


# Exercise 7.10 -----------------------------------------------------------

# Object names
DayOne #bad
day_1 #good

T <- FALSE #bad - T already means TRUE so would be super confusing
FALSE #good

c <- 9 #bad - c is already combine. so again super confusing
9 #good


# Spacing
x[,1] #bad
x[ ,1] #bad
x[, 1] #good

mean (x, na.rm = TRUE) #bad
mean( x, na.rm = TRUE ) #bad
mean(x, na.rm = TRUE) #good


height<-feet*12+inches #bad
height <- (feet * 12) + inches #good

df $ z #bad
df$z #good

x <- 1 : 10 #bad
x <- 1:10 #good

# Indenting and brackets
#bad
if (y < 0 && debug) {
message("Y is negative")}
#good
if (y < 0 && debug) {
    message("Y is negative")
}


# QUICK FIX TO TIDY UP CODE/MAKE IT EASY TO READ
# ctrl + shift + a
# require(styler) and then use styler::style_file()












