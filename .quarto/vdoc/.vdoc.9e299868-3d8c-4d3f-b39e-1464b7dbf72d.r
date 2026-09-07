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
  geom_sf(aes(fill = estimate))
#
#
#
#
