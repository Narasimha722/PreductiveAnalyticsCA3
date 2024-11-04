library(e1071)
library(caTools)
df <- read.csv(file.choose())
str(df)
df <- df[,3:15]   
str(df)
df$sex <- as.factor(df$sex)
df$sex
df$sample_origin <- as.factor(df$sample_origin)
df$patient_cohort <- as.factor(df$patient_cohort)
df$diagnosis <- as.factor(df$diagnosis)
df$stage <- as.factor(df$stage)
str(df)
df <- df[,c(1,2,3,4,5,6,8,9,10,11,12,13)]
str(df)
set.seed(1234)
pd <- sample(2, nrow(df), replace = TRUE,prob = c(0.65,0.35))
tr <- df[pd==1,]
ts <- df[pd==2,]
tr
ts
classifier_cl <- naiveBayes(diagnosis ~ .,
                            data = tr)
classifier_cl

# Predicting on test data'
y_pred <- predict(classifier_cl, 
                  newdata = ts)
y_pred
cm <- table(y_pred,ts$diagnosis)
cm
accuracy <- sum(diag(cm)/sum(cm))
accuracy               
