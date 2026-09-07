#
#
#
#
#
#
#
#
#| message: false

library(tidyverse)
library(tidycensus)
library(sf)
#
#
#
#| message: false

income_tx <- get_acs(
  geography = "county",
  variables = "B19013_001",
  state = "TX",
  year = 2020,
  survey = "acs5",
  geometry = TRUE
)
#
#
#
ggplot(income_tx) +
  geom_sf(aes(fill = estimate)) +
  scale_fill_viridis_c(
    name = "Median household income",
    labels = scales::label_dollar()
  ) +
  labs(
    title = "Median Household Income by Texas County",
    caption = "Source: U.S. Census Bureau, 2020 ACS 5-year estimates."
  ) +
  theme_void()
#
#
#
#| message: false
#| cache: true

edu_state <- get_acs(
  geography = "state",
  variables = c(
    "B15003_001",
    "B15003_022",
    "B15003_023",
    "B15003_024",
    "B15003_025"
  ),
  summary_var = "B15003_001",
  year = 2020,
  survey = "acs5"
)
#
#
#
#
