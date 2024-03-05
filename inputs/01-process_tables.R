set.seed(71)
library(mice)
library(tidyverse)
library(palmerpenguins)

dataset = data(package='palmerpenguins')

# loading the dataset in.
penguins

# eliminate all entries with bill 34 <= length <= 40 mm
penguins_MCAR <- penguins %>%
  mutate(
    bill_length_mm = if_else(bill_length_mm >= 34 & bill_length_mm <= 40,
                             NA_real_,
                             bill_length_mm)
  )

# multiple imputation step.
multiple_imputation <-
  mice(
    penguins_MCAR,
    print = FALSE
  )
# mice estimate step.
mice_estimates <-
  complete(multiple_imputation) |>
  as_tibble()