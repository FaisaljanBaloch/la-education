library(tidyverse)
library(tidycensus)

# Load data
edu_data <- get_acs(
  geography = "tract",
  variables = c(
    total = "B15003_001",
    bach = "B15003_022",
    masters = "B15003_023",
    prof = "B15003_024",
    doctorate = "B15003_025"
  ),
  state = "CA",
  county = "Los Angeles",
  year = 2022,
  survey = "acs5",
  geometry = TRUE,
  output = "wide"
)

# Calculate percent bachelor's
edu_data <- edu_data |>
  mutate(
    bach_plus = bachE + mastersE + profE + doctorateE,
    pct_bach_plus = 100 * bach_plus / totalE
  )

# Save the data to an RDS file
saveRDS(edu_data, file = "data/edu_data.rds")