library(shiny)
library(shinydashboard)
library(ggplot2)
library(shinyBS)
library(plotly)

shinyServer(function(input, output,session) {
  
  # From https://github.com/beanumber/mdsr/blob/master/data/SAT_2010.rda
  load("./SAT_2010.rda")
  
  #Explore Button
  observeEvent(input$explore, {
    updateTabItems(session, "tabs", "first")
  })
  
  
  output$SAT1<-renderTable(
    
    SAT_2010[c(5,20,21,30,38,39,16,23,27,34,42,49), c(1,4,8,9)]
    
  )
  

    output$plot2<-renderPlotly({
      
      SAT_2010_plot2<-SAT_2010[c(5,20,21,30,38,39,16,23,27,34,42,49),]%>%
        mutate(SAT_grp=ifelse(sat_pct<=27, "Low SAT Participation State", "High SAT Participation State"))
      
      integer=8714-input$integer*8714
      
      low=which(SAT_2010_plot2$salary<=55051)
      high=which(SAT_2010_plot2$salary>55051)
      SAT_2010_plot2[low, ]$salary=SAT_2010_plot2[low, ]$salary+integer
      SAT_2010_plot2[low, ]$total=SAT_2010_plot2[low, ]$total+(integer*-0.01417 )    
      
      SAT_2010_plot2[high, ]$salary=SAT_2010_plot2[high, ]$salary-integer
      SAT_2010_plot2[high, ]$total=SAT_2010_plot2[high, ]$total-(integer*-0.01417 )
      
      
      
      # ggplot(data=SAT_2010_plot2,aes(salary,total, col=SAT_grp))+
      #   geom_point()+geom_smooth(method=lm, se=FALSE)+ylab("Average Total SAT Score")+
      #   xlab("Average Teacher Salary")+geom_text(aes(label=state), size=3)+
      #   geom_smooth(method = "lm",se = F, color = "black", linetype = "dashed",lwd=1.5)
      # 
      # 
      # ggplot(data=SAT_2010_plot2,aes(salary,total, col=SAT_grp))+
      #   geom_point()+xlim(c(45111,72734))+ylim(c(1473,1781))+ylab("Average Total SAT Score")+
      #   xlab("Average Teacher Salary")
      
      p=ggplot(data=SAT_2010_plot2,aes(salary,total, col=SAT_grp, label=state
      ))+geom_smooth(method="lm", se=F)+
        labs(x="Teachers' Salaries", y="SAT Scores")+geom_point(aes(text=paste("State:", state, "\n",
                                                                              "New Salary:", salary,"\n",
                                                                              'New SAT Score:', total,"\n",
                                                                              '', SAT_grp)),size = 3, pch=21)
      
      
      
      pp=p + geom_smooth(method = "lm",se = F, color = "black", linetype = "longdash",lwd=1.5)+
        scale_colour_manual(name='',values=c('Low SAT Participation State'='orange','High SAT Participation State'='blue',
                                             'black'='black'))+theme_bw()+
        theme(axis.title.x = element_text( face="bold"),
              axis.title.y = element_text(face="bold"),
              panel.background = element_blank(),
              legend.position="none",
              axis.line = element_line(color = 'black'))
      
      ggplotly(pp,tooltip =  "text")%>% config(displayModeBar = F) 
      
      
      
    })
    
    

  
  
}
)

