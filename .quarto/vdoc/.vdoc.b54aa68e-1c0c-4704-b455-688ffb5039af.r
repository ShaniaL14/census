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
edu_state |>
  filter(variable %in% c(
    "B15003_022",
    "B15003_023",
    "B15003_024",
    "B15003_025"
  )) |>
  group_by(GEOID, NAME) |>
  summarize(
    pct_bachelors_or_higher = sum(estimate) / first(summary_est) * 100
  ) |>
  ggplot(aes(
    x = pct_bachelors_or_higher,
    y = reorder(NAME, pct_bachelors_or_higher)
  )) +
  geom_col() +
  scale_x_continuous(labels = scales::label_percent(scale = 1)) +
  labs(
    title = "Adults with a Bachelor's Degree or Higher by State",
    x = "Bachelor's degree or higher",
    y = NULL,
    caption = "Source: U.S. Census Bureau, 2020 ACS 5-year estimates."
  ) +
  theme_minimal()
#
#
#
#| message: false

age_ca <- get_acs(
  geography = "county",
  variables = c(
    median_age = "B01002_001",
    population = "B01003_001"
  ),
  state = "CA",
  year = 2020,
  survey = "acs5",
  geometry = FALSE
)
#
#
#
age_ca
#
#
#
#
