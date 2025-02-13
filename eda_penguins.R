---
  title: "Code for Exploratory Data Analysis of Penguins Dataset"
author: 'aurellaa'
date: "2025-02-14"
---

# Loading necessary packages


library(ggpubr)
library(palmerpenguins)
library(skimr)
library(dplyr)
library(ggplot2)
library(gridExtra)
library(cowplot)

# Inspecting the dataset
str(penguins)
summary(penguins)

# Handling missing values
colSums(is.na(penguins))
penguins_clean <- na.omit(penguins) # Removes rows with missing values to ensure clean data

# Descriptive statistics
skim(penguins_clean)

# Summary statistics by species
penguins_clean |>
  group_by(species) |>
  summarize(
    avg_body_mass = mean(body_mass_g),
    avg_bill_length = mean(bill_length_mm),
    avg_bill_depth = mean(bill_depth_mm),
    avg_flipper_length = mean(flipper_length_mm)
  )


## Visualisations =============================================================

# Setting a global theme

theme_set(
  theme_classic()
)

### Frequency Distribution =============================================================

#### Species ===========================================================================

# Bar chart showing the count of each species
freqspecies <- ggplot(penguins_clean, aes(x = species, fill = species)) + 
  geom_bar(color = "black", show.legend = FALSE) +
  labs(title = "Frequency of Species",
       x = "Species",
       y = "Count")

# Faceted bar chart displaying species distribution across islands
freqspecies_byisland <- ggplot(penguins_clean, aes(x = species, fill = species)) +
  geom_bar(color = "black") +
  facet_wrap( ~ island) +
  labs(title = "Species Distribution by Island",
       x = "Species", 
       y = "Count")

# Plotting both bar charts onto a grid
plot_grid(freqspecies, freqspecies_byisland, labels = c("A", "B"), ncol = 2, nrow = 1)

#### Sex ===========================================================================

# Bar chart showing the count of male and female penguins per species
ggplot(penguins_clean, aes(x = sex, fill = sex)) +
  geom_bar(color = "black") +
  facet_wrap( ~ species) +
  labs(title = "Sex Distribution by Species",
       x = "Sex", 
       y = "Count")

### Body Mass Analysis =============================================================

# Bar chart showing mean body mass for each species, grouped by sex
ggplot(penguins_clean, aes(x = species, y = body_mass_g, fill = sex)) +
  geom_bar(stat = "summary", fun = "mean", position = "dodge", color = "black") +
  labs(
    title = "Average Body Mass by Species and Sex",
    x = "Species",
    y = "Average Body Mass (g)"
  )

# Histogram of body mass, by species and sex
ggplot(data = penguins_clean, aes(x = body_mass_g, fill = species)) +
  geom_histogram(color = "black", bins = 25) +  # Histogram with black outline
  facet_grid(species ~ sex) +  # Facet by species (rows) and sex (columns) +
  labs(title = "Body Mass Distribution",
       x = "Body Mass (g)", 
       y = "Count") +
  theme_bw() +
  theme(axis.text.x = element_text(angle=65, vjust=0.6))


# Boxplot showing body mass distribution across species
box_bm_byspec <- ggplot(penguins_clean, aes(x = species, y = body_mass_g, fill = species)) + 
  stat_boxplot(geom ='errorbar') +
  geom_boxplot() +
  labs(title = "Boxplot of Distribution of Body Mass (g) by Species",
       x = "Species",
       y = "Body Mass (g)")

# Boxplot showing body mass distribution across sex
box_bm_bysex <- ggplot(penguins_clean, aes(x = sex, y = body_mass_g, fill = sex)) + 
  stat_boxplot(geom ='errorbar') +
  geom_boxplot() +
  labs(title = "Boxplot of Distribution of Body Mass (g) by Sex",
       x = "Sex",
       y = "Body Mass (g)")

# Plotting both box plots onto a grid
plot_grid(box_bm_byspec, box_bm_bysex, labels = c("A", "B"), ncol = 2, nrow = 1)



### Correlation Analysis =============================================================

# Computing correlation coefficients between body mass and numerical variables
cor_table <- data.frame(
  Relationship = c("Body Mass and Bill Length", "Body Mass and Bill Depth", "Body Mass and Flipper Length"),
  Correlation = c(cor(penguins_clean$body_mass_g, penguins_clean$bill_length_mm, use = "complete.obs"),
                  cor(penguins_clean$body_mass_g, penguins_clean$bill_depth_mm, use = "complete.obs"),
                  cor(penguins_clean$body_mass_g, penguins_clean$flipper_length_mm, use = "complete.obs"))
)

print(cor_table)


### Scatterplot Analysis =============================================================

# Scatterplots visualizing relationships between Body Mass vs. Flipper Length
# Body Mass vs. Bill Length
ggplot(penguins_clean, aes(x = bill_length_mm, y = body_mass_g, color = species)) +
  geom_point(alpha = 0.7) + 
  geom_smooth(method = lm) +
  facet_grid(sex ~ species) +
  labs(title = "Body Mass (g) against Bill Length (mm)",
       x = "Bill Length (mm)",
       y = "Body Mass (g)") +
  theme_bw() +
  theme(axis.text.x = element_text(angle=65, vjust=0.6))

# Body Mass vs. Flipper Length by Species and Sex
ggplot(penguins_clean, aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  geom_point(alpha = 0.7) + 
  geom_smooth(method = lm) +
  facet_grid(sex ~ species) +
  labs(title = "Body Mass (g) against Flipper Length (mm)",
       x = "Flipper Length (mm)",
       y = "Body Mass (g)") +
  theme_bw() +
  theme(axis.text.x = element_text(angle=65, vjust=0.6))


### Citation =============================================================

citation("palmerpenguins")
