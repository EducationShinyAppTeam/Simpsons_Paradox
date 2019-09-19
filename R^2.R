plot(mtcars[,-c(2,8,9,10,11)])
model<-lm(mpg~disp+hp+drat+wt+qsec,mtcars)
model1<-lm(mpg~disp,mtcars)
model2<-lm(mpg~hp,mtcars)
model3<-lm(mpg~drat,mtcars)
model4<-lm(mpg~wt,mtcars)
model5<-lm(mpg~qsec,mtcars)
library(corrplot)
newdatacor = (cor(mtcars[,-c(2,8,9,10,11)]))^2
corrplot(newdatacor, method = "number")
summary(model1)$r.squared
summary(model2)$r.squared
summary(model3)$r.squared
summary(model4)$r.squared
summary(model5)$r.squared

# From https://github.com/beanumber/mdsr/blob/master/data/SAT_2010.rda
load("./SAT_2010.rda")

#SAT & Salary:
library(ggplot2)
SAT_2010_new<-SAT_2010[c(1,17,49,23,18,10,2,11,8,37),]
SAT_2010_salary_plot<-ggplot(data=SAT_2010_new,aes(x=salary,y=total))+
  geom_point()+geom_smooth(method = "lm")+ylab("Average Total SAT Score")+
  xlab("Average Teacher Salary")+geom_text(aes(label=state), size=3)
SAT_2010_salary_plot

# Lurking variable: The % of taking SAT in each State
SAT_2010_plot2<-SAT_2010_new%>%
  mutate(SAT_grp=ifelse(sat_pct<=27, "Low", "High"))
ggplot(data=SAT_2010_plot2,aes(salary,total, col=SAT_grp))+
  geom_point()+geom_smooth(method=lm, se=FALSE)+ylab("Average Total SAT Score")+
  xlab("Average Teacher Salary")+geom_text(aes(label=state), size=3)+
  geom_smooth(method = "lm",se = F, color = "black", linetype = "dashed",lwd=1.5)


#SAT & Expenditure
SAT_2010_expense_plot<-ggplot(data=SAT_2010,aes(x=expenditure,y=total))+
  geom_point()+geom_smooth(method = "lm")+ylab("Average Total SAT Score")+
  xlab("Average Expenditure per student")
SAT_2010_expense_plot

# Lurking variable: The % of taking SAT in each State
SAT_2010_plot3<-SAT_2010 %>%
  mutate(SAT_grp=ifelse(sat_pct<=27, "Low", "High"))
SAT_2010_expense_plot %+% SAT_2010_plot3+aes(color=SAT_grp)
