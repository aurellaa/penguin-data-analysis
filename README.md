# Palmer Penguins: Exploratory Data Analysis (EDA) <br>
Author: aurellaa <br>
Repository: penguin-data-analysis

## Introduction <br>
This repository is dedicated to the exploratory data analysis (EDA) of the penguins dataset from the palmerpenguins R package.<br>

The goal of this project is to analyse factors influencing penguin body mass using statistical and visual exploration techniques. Understanding these predictors can provide insights into penguin morphology and health – thus aiding in conservation efforts. This project also serves as a practical demonstration of data visualisation and statistical analysis in R.
 <br>
<br>
<br>

## Dataset
The dataset used in this project is the penguins dataset from the palmerpenguins package, provided by Dr. Kristen Gorman and the Palmer Station, Antarctica LTER. This dataset is a simplified version of the raw data, containing observations of 344 penguins for 8 variables: species, island, bill length (mm), bill depth (mm), flipper length (mm), body mass (g), sex, and year. There are 3 penguin species which are found across 3 different islands. The target variable of this project is body mass.
 <br>
<br>
<br>

## Reproducing This Analysis
### Prerequisites 
Ensure you have the following R packages installed:

```
install.packages(c("palmerpenguins", "ggplot2", "dplyr", "ggpubr", "skimr", "cowplot"))
```

### Running the Analysis<br>
Clone this repository:

```
git clone https://github.com/aurellaa/penguin-data-analysis
cd palmer-penguins-eda

```
Open RStudio and run eda_penguins.Rmd or render the Markdown file:
```
rmarkdown::render("eda_penguins.Rmd")
```

View the results in the generated HTML, PDF, or Word document.

