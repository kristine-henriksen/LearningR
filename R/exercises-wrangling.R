# Load the packages
source(here::here("R/package-loading.R"))

# Check column names
colnames(NHANES)

# Look at contents
str(NHANES)
glimpse(NHANES)

# See summary
summary(NHANES)

# Look over the dataset documentation
?NHANES

# select specific columns
select(NHANES, Age)

# select more columns
select(NHANES, Age, Weight, BMI)
select(NHANES, "Age", "Weight", "BMI")

# Exclude a column
select(NHANES, -HeadCirc)

# select all columns that start with BP (blood pressure)
select(NHANES, starts_with("BP"))

# select all columns that ends with "Day"
select(NHANES, ends_with("Day"))

# select all columns that ends with "Age"
select(NHANES, contains("Age"))

?select_helpers

# save selected columns into a new data frame
nhanes_small <- select(NHANES, Age, Gender, Height,
                       Weight, BMI, Diabetes, DiabetesAge,
                       PhysActiveDays, PhysActive, TotChol,
                       BPSysAve, BPDiaAve, SmokeNow, Poverty)

# view the data fram
nhanes_small
View(nhanes_small)

## RENAMING
# remaning all columns to snake case
nhanes_small <- rename_with(nhanes_small, snakecase::to_snake_case)

# rename specific columns
nhanes_small <- rename(nhanes_small, sex = gender)

## THE PIPE OPERATOR ( %>% = "and then")
colnames(nhanes_small)
# is the same as:
nhanes_small %>%
    colnames()

nhanes_small %>%
    select(phys_active) %>%
    rename(physically_active = phys_active)















