
---

## `community_assembly.R`

```r
# Stochastic community assembly model
# Alexandros Kaminas

rm(list = ls())

library(ggplot2)
library(dplyr)

set.seed(42)

dir.create("figures", showWarnings = FALSE)

# --------------------------------------------------
# Parameters
# --------------------------------------------------

n_species_pool <- 50
timesteps <- 200

colonization_rate <- 0.05
birth_rate <- 0.2
death_rate <- 0.15

# --------------------------------------------------
# Initial state
# --------------------------------------------------

community <- rep(0, n_species_pool)  # abundances
richness <- numeric(timesteps)

# --------------------------------------------------
# Simulation
# --------------------------------------------------

for (t in 1:timesteps) {

  # Colonization
  colonizers <- rbinom(n_species_pool, 1, colonization_rate)
  community[colonizers == 1] <- community[colonizers == 1] + 1

  # Birth
  births <- rbinom(n_species_pool, community, birth_rate)
  community <- community + births

  # Death
  deaths <- rbinom(n_species_pool, community, death_rate)
  community <- pmax(community - deaths, 0)

  # Record richness
  richness[t] <- sum(community > 0)
}

# --------------------------------------------------
# Output data
# --------------------------------------------------

df <- data.frame(
  time = 1:timesteps,
  richness = richness
)

# --------------------------------------------------
# Plot richness through time
# --------------------------------------------------

p1 <- ggplot(df, aes(x = time, y = richness)) +
  geom_line(linewidth = 1) +
  labs(
    title = "Community assembly dynamics",
    subtitle = "Species richness over time",
    x = "Time",
    y = "Species richness"
  ) +
  theme_minimal()

ggsave("figures/richness_time_series.png", p1, width = 7, height = 5, dpi = 300)

# --------------------------------------------------
# Final abundance distribution
# --------------------------------------------------

abundance_df <- data.frame(
  abundance = community[community > 0]
)

p2 <- ggplot(abundance_df, aes(x = abundance)) +
  geom_histogram(bins = 20) +
  labs(
    title = "Final community structure",
    x = "Abundance",
    y = "Frequency"
  ) +
  theme_minimal()

ggsave("figures/abundance_distribution.png", p2, width = 7, height = 5, dpi = 300)

# --------------------------------------------------
# Print summary
# --------------------------------------------------

cat("Final species richness:", sum(community > 0), "\n")
