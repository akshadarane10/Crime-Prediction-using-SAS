## Crime Rate Prediction using SAS
This project aims to develop a predictive model to estimate violent crime rates (per 100,000 people) across U.S. states using demographic and socio-economic factors. The analysis was conducted using SAS.

## Dataset
The dataset includes the following variables:
- crime: Violent crimes per 100,000 people (target)
- murder: Murders per 1,000,000 people
- pctmetro: % population in metropolitan areas
- pctwhite: % white population
- pcths: % with high school education or above
- poverty: % population under poverty line
- single: % single-parent households

 ## Methodology
- Data preprocessing & EDA
- Train-test split (70-30)
- Model building: Linear Regression, Stepwise Selection, Ridge Regression
- Regression assumption checks
- Model evaluation on test data
- Cross-validation to select best model

## Results
The best-performing model selected poverty, single, and pctmetro as key predictors.
Evaluation metrics showed good prediction performance with low RMSE.

## Key Insights
Higher poverty and single-parent rates are strong indicators of increased crime.
Urban areas may need targeted safety and social support interventions.

## Tools
SAS (Base + PROC REG, PROC SURVEYSELECT)

📁 Files
crime_model.sas: All SAS code for preprocessing, modeling, and evaluation

README.md: Project overview
