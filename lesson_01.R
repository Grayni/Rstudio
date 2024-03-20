library(tidyverse)
require(readxl)

# high_density_lipids
hdl <- read_tsv('data/high_density_lipids.tsv') %>%
  #select(-Name) %>%
  mutate(Patient.number = as.factor(Patient.number),
         Vial.number = as.factor(Vial.number))

# low_density_lipids
ldl <- read_tsv('data/low_density_lipids.tsv') %>%
  #select(-Name) %>%
  mutate(Patient.number = as.factor(Patient.number),
         Vial.number = as.factor(Vial.number))

# metadata
meta <- read_xlsx('data/metadata.xlsx', sheet = 1) %>%
  rename_with(make.names)

# identifying_data
identifying_data <- meta %>%
  select(c(Vial.number, Patient.number, Name))

# clinical_data
clinical_data <- meta %>%
  select(-c(Vial.number, Patient.number, Name))

# descriptive
descriptive <- read_xlsx('data/metadata.xlsx', sheet = 2) %>%
  rename('Variable'='...1', 'Description'='...2') %>%
  drop_na()

# lipids
lipids <- full_join(hdl, ldl, by = c('Vial.number', 'Patient.number'), suffix = c('.hdl', '.ldl')) %>%
  select(-c(Name.hdl, Name.ldl))

