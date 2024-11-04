library(e1071)
library(caTools)
library(class)
df <- read.csv(file.choose())
str(df)
df <- df[,3:15]   
str(df)
df$sex <- as.numeric(as.factor(df$sex))
df$sex
df$sample_origin <- as.numeric(as.factor(df$sample_origin))
df$patient_cohort <- as.numeric(as.factor(df$patient_cohort))
df$stage <- as.numeric(as.factor(df$stage))
str(df)
df <- df[,c(1,2,3,4,5,6,8,9,10,11,12,13)]
df1 <- df[,1:6]
df2 <- df[,7:12]
df2 <- scale(df2[, 1:5])
df <- cbind(df1,df2)
str(df)
set.seed(1234)
pd <- sample(2, nrow(df), replace = TRUE,prob = c(0.75,0.25))
tr <- df[pd==1,]
ts <- df[pd==2,]
tr
ts
classifier_knn <- knn(train = tr,
                      test = ts,
                      cl = tr$diagnosis,
                      k = 1)
classifier_knn
cm <- table(ts$diagnosis, classifier_knn)
cm
accuracy <- sum(diag(cm)/sum(cm))
accuracy



