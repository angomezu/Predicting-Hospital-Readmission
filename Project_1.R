# Install required packages if not installed
packages <- c("tidyverse", "data.table", "caret", "ggplot2", "pROC")
install.packages(setdiff(packages, rownames(installed.packages())), dependencies = TRUE)

# Load necessary libraries
library(tidyverse)
library(data.table)
library(caret)
library(ggplot2)
library(pROC)

# Load dataset
file_path <- "C:/Users/angom/East Tennessee State University/Applied Data Science - AB - Documentos/Courses/Advanced Data Analysis/Project_1/hospital_readmissions.csv"
data <- fread(file_path)

# Convert 'readmitted' to a binary factor
data$readmitted <- factor(ifelse(data$readmitted == "yes", 1, 0), levels = c(0, 1), labels = c("no", "yes"))

# Convert categorical variables to factors
categorical_vars <- c("age", "glucose_test", "A1Ctest", "change", "diabetes_med", 
                      "medical_specialty", "diag_1", "diag_2", "diag_3")
data[, (categorical_vars) := lapply(.SD, as.factor), .SDcols = categorical_vars]

# Identify numeric columns for standardization
numeric_vars <- setdiff(names(data), c(categorical_vars, "readmitted"))

# Train-Test Split
set.seed(123)
train_index <- createDataPartition(data$readmitted, p = 0.8, list = FALSE)
train_data <- data[train_index]
test_data <- data[-train_index]

# Standardization (Z-score normalization) - FIXING WARNINGS ✅
train_numeric <- train_data[, ..numeric_vars]
test_numeric <- test_data[, ..numeric_vars]

preProcess_model <- preProcess(train_numeric, method = c("center", "scale"))

train_data[, (numeric_vars) := predict(preProcess_model, newdata = train_numeric)]
test_data[, (numeric_vars) := predict(preProcess_model, newdata = test_numeric)]

# Train Logistic Regression Model
logistic_model <- glm(readmitted ~ ., data = train_data, family = binomial(link = "logit"))

# Model Evaluation
train_probs <- predict(logistic_model, train_data, type = "response")
test_probs <- predict(logistic_model, test_data, type = "response")

train_predicted <- factor(ifelse(train_probs > 0.5, "yes", "no"), levels = c("no", "yes"))
test_predicted <- factor(ifelse(test_probs > 0.5, "yes", "no"), levels = c("no", "yes"))

conf_matrix_train <- confusionMatrix(train_predicted, train_data$readmitted, positive = "yes")
conf_matrix_test <- confusionMatrix(test_predicted, test_data$readmitted, positive = "yes")

roc_train <- roc(train_data$readmitted, train_probs, levels = c("no", "yes"))
roc_test <- roc(test_data$readmitted, test_probs, levels = c("no", "yes"))

# Print Results
cat("Logistic Regression Model Performance Metrics:\n")

cat("\nTRAINING SET:\n")
cat("Accuracy:", conf_matrix_train$overall["Accuracy"], "\n")
cat("AUC:", auc(roc_train), "\n")

cat("\nTEST SET:\n")
cat("Accuracy:", conf_matrix_test$overall["Accuracy"], "\n")
cat("AUC:", auc(roc_test), "\n")

# Plot ROC Curves
par(mfrow = c(1,2))
plot(roc_train, col = "red", main = "ROC Curve (Train)")
plot(roc_test, col = "blue", main = "ROC Curve (Test)")
par(mfrow = c(1,1))
