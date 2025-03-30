# Predicting Hospital Readmission using Logistic Regression

This project applies statistical modeling to identify key factors contributing to hospital readmissions, using a dataset of 25,000 patient records. The objective is to help healthcare providers proactively detect high-risk patients and reduce preventable readmissions through data-driven insights.

**Status**: Completed
**Last Updated**: March 30, 2025

---

## Project Overview

- **Objective**: Predict hospital readmission using patient demographics, treatment history, and medical visit data.
- **Dataset**: [Kaggle Hospital Readmissions Dataset](https://www.kaggle.com/datasets/dubradave/hospital-readmissions)
- **Modeling Approach**: Logistic Regression in R
- **Toolset**: R, `tidyverse`, `caret`, `pROC`, `ggplot2`

---

## Methodology

### Data Preprocessing

- Converted categorical variables into factors (e.g., age brackets, diagnoses, test results)
- Transformed target variable `readmitted` into binary format (0 = No, 1 = Yes)
- Standardized numeric variables using Z-score normalization
- Handled right-skewed distributions using **Winsorization** to limit outliers

### Feature Engineering

- Selected variables based on medical relevance:
  - Time in hospital
  - Number of medications, lab procedures, and primary/secondary diagnoses
  - Prior hospital visits (inpatient, outpatient, emergency)
  - Diabetes medication status and diagnostic test results

### Model Training & Evaluation

- Applied logistic regression with stepwise AIC selection
- Evaluated on:
  - Accuracy, AUC (ROC Curve)
  - Precision, Recall, F1-score
  - Confusion Matrix
- Train-test split: 80% / 20%

---

## Results

- **Training Accuracy**: 61.16%
- **Test Accuracy**: 61.65%
- **AUC (Train)**: 0.647
- **AUC (Test)**: 0.662

### Key Findings

- **Positive predictors of readmission**:
  - Longer hospital stays
  - Higher number of medications and lab procedures
  - Frequent prior hospital visits
  - Prescription of diabetes medication
  - Advanced age (70s and 80s)

- **Negative predictor**:
  - Number of procedures performed during stay (associated with reduced risk)

- **Non-significant variables**:
  - Glucose and A1C test results
  - Change in diabetes medication

---

## R Script Highlights (`Project_1.R`)

- Cleanly loads and preprocesses the dataset
- Performs model training and test evaluation
- Uses `caret` and `pROC` for model validation and ROC plotting
- Includes confusion matrices and AUC scores for performance assessment

---

## How to Run

1. Clone this repository and install R (version 4.1+ recommended)
2. Open `Project_1.R` in RStudio
3. Set the correct path to the dataset CSV
4. Run all chunks to preprocess data, train the model, and view evaluation metrics

---

## Limitations & Future Work

- Predictive performance is modest, likely due to missing behavioral, social, or follow-up data
- Future iterations may explore:
  - Regularized models (LASSO, Ridge)
  - Tree-based classifiers (Random Forest, XGBoost)
  - SHAP/LIME interpretability methods
  - Inclusion of external datasets to improve feature depth

---

## Author

**Angel Barrera**  
Master’s Student, Applied Data Science  
East Tennessee State University  
Email: angomezu@gmail.com

---

## References

1. [Hospital Readmissions Dataset (Kaggle)](https://www.kaggle.com/datasets/dubradave/hospital-readmissions)
2. Regression & Advanced Data Analytics Course, ETSU, 2025
