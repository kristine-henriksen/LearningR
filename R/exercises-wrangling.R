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

## THE PIPE OPERATOR %>% = "and then" (shortcut CTRL + SHIFT + M)
colnames(nhanes_small)
# is the same as:
nhanes_small %>%
    colnames()

nhanes_small %>%
    select(phys_active) %>%
    rename(physically_active = phys_active)


# Exercise 9.9 ------------------------------------------------------------

nhanes_small %>%
    select(tot_chol, bp_sys_ave, poverty)

nhanes_small %>%
    rename(diabetes_diagnosis_age = diabetes_age)

# Rewrite this with pipe:
select(nhanes_small, bmi, contains("age"))
# then becomes
nhanes_small %>%
    select(bmi, contains("age"))


# Rewrite this with pipe:
physical_activity <- select(nhanes_small, phys_active_days, phys_active)
rename(physical_activity, days_phys_active = phys_active_days)
# then becomes
nhanes_small %>%
    select(phys_active_days, phys_active) %>%
    rename(days_phys_active = phys_active_days)



# 9.10 --------------------------------------------------------------------

## FILTERING

#filter for all females
nhanes_small %>%
    filter(sex == "female")
# fiter for all non-females
nhanes_small %>%
    filter(sex != "female")

#filter for participants who have a BMI equal to 25
nhanes_small %>%
    filter(bmi == 25)
#filter for participants who have a BMI equal or greater than 25
nhanes_small %>%
    filter(bmi >= 25)

# filter for participants where BMI is equal or grater than 25 AND sex is female
nhanes_small %>%
    filter(bmi >= 25 & sex == "female")

# filter for participants where BMI is equal or grater than 25 OR sex is female
nhanes_small %>%
    filter(bmi > 25 | sex == "female")
# NOTE: shortcut for | is ALT + I


## ARRANGING

# arranging by age (default is ascending order)
nhanes_small %>%
    arrange(age)

# arrange by sex (Default is alphabetic a-z order)
nhanes_small %>%
    arrange(sex)

# arranging by age in descending (or z-a) order
nhanes_small %>%
    arrange(desc(age))

# arranging by sex then age in ascending order
nhanes_small %>%
    arrange(sex, age)

# arranging by sex in descending order then age in ascending order
nhanes_small %>%
    arrange(desc(sex), age)


## TRANSFORM OR ADD COLUMNS

# "mutating"/transforming height in cm into height in meters
nhanes_small %>%
    mutate(height = height / 100)

# adding new column with log(height) values
nhanes_small %>%
    mutate(log_height = log(height))

# mutating height in cm into height in meters and then dding new column with log(height) values
nhanes_small %>%
    mutate(height = height / 100,
           log_height = log(height))

# adding new column with yes/no for if participants are highly active
nhanes_small %>%
    mutate(highly_active = if_else(phys_active_days >= 5, "yes", "no"))

# "save" new columns in dataset
nhanes_update <- nhanes_small %>%
    mutate(height = height / 100,
           log_height = log(height),
           highly_active = if_else(phys_active_days >= 5, "yes", "no"))

str(nhanes_update)





