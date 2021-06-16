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



# 9.10-12 --------------------------------------------------------------------

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


# Exercise 9.13 -----------------------------------------------------------

# 1. BMI between 20 and 40 with diabetes
nhanes_small %>%
    # Format should follow: variable >= number or character
    filter(bmi >= 20 & bmi <= 40 & diabetes == "Yes")

# Pipe the data into mutate function and:
nhanes_modified <- nhanes_small %>% # Specifying dataset
    mutate(
        # 2. Calculate mean arterial pressure
        ___ = ___,
        # 3. Create young_child variable using a condition
        ___ = if_else(___, "Yes", "No")
    )

nhanes_modified



# 9.14-15 --------------------------------------------------------------------

# summary statistics by group

# maximum bmi
nhanes_small %>%
    summarise(max_bmi = max(bmi)) # wont give you max bmi because of NAs

# maximum bmi excluding NA values
nhanes_small %>%
    summarise(max_bmi = max(bmi, na.rm = TRUE))

# how many NA values are there?
nhanes_small %>%
    summarise(sum.na = sum(is.na(bmi)))
# or
summary(nhanes_small)

# calculating 2 max and min
nhanes_small %>%
    summarise(max_bmi = max(bmi, na.rm = TRUE),
              min_bmi = min(bmi, na.rm = TRUE))



# Exercise 9.16 -----------------------------------------------------------

# 1. Calculate the mean of weight and age
nhanes_small %>%
    summarise(mean_weight = mean(weight, na.rm = TRUE),
              mean_age = mean(age, na.rm =TRUE))

# 2. Calculate the max and min of height
nhanes_small %>%
    summarise(max_height = max(height, na.rm = TRUE),
              min_height = min(height, na.rm = TRUE))

# 3. Calculate the median of age and phys_active_days
nhanes_small %>%
    summarise(median_age = median(age, na.rm = TRUE),
              median_phys_active_days = median(phys_active_days, na.rm = TRUE))



# 9.17 + 9.19 --------------------------------------------------------------------

# Summary statistics by a group
nhanes_small %>%
    group_by(diabetes) %>%
    summarise(mean_age = mean(age, na.rm = TRUE),
              mean_bmi = mean(bmi, na.rm = TRUE))

nhanes_small %>%
    filter(!is.na(diabetes)) %>%
    group_by(diabetes) %>%
    summarise(mean_age = mean(age, na.rm = TRUE),
              mean_bmi = mean(bmi, na.rm = TRUE)) %>%
    ungroup()


## SAVING DATASETS/FRAMES AS FILES

#saving data as an .rda file in the data folder
usethis::use_data(nhanes_small,
                  overwrite = TRUE)





