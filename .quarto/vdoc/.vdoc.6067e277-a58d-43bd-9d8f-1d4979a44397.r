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
  summarize(
    minimum = min(pct_bachelors_or_higher),
    first_quartile = quantile(pct_bachelors_or_higher, 0.25),
    median = median(pct_bachelors_or_higher),
    mean = mean(pct_bachelors_or_higher),
    third_quartile = quantile(pct_bachelors_or_higher, 0.75),
    maximum = max(pct_bachelors_or_higher)
  )
#
#
#
#
