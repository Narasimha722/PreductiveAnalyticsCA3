library(randomForest)
df <- read.csv(file.choose())
str(df)
df <- df[,3:15]   
str(df)
df$sex <- as.integer(as.factor(df$sex))
df$sex
df$sample_origin <- as.integer(as.factor(df$sample_origin))
df$patient_cohort <- as.integer(as.factor(df$patient_cohort))
df$diagnosis <- as.factor(df$diagnosis)
df$stage <- as.integer(as.factor(df$stage))
df$sex
str(df)
df <- df[,c(1,2,3,4,5,6,8,9,10,11,12,13)]
df1 <- df[,1:6]
df2 <- df[,7:12]
df2 <- scale(df2[, 1:5])
df <- cbind(df1,df2)
str(df)
set.seed(777)
pd <- sample(2, nrow(df), replace = TRUE,prob = c(0.8,0.2))
tr <- df[pd==1,]
ts <- df[pd==2,]
tr
ts
classifier = randomForest(x = tr[-5],
                          y = tr$diagnosis,
                          ntree = 600)
y_pred = predict(classifier, ts,type="class")
cm = table(ts$diagnosis, y_pred)
cm
accuracy <- sum(diag(cm)/sum(cm))
accuracy

