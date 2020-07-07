library(shiny)
library(shinydashboard)
library(ggplot2)
library(shinyBS)
library(plotly)
library(corrplot)


dashboardPage(skin="purple",
              
              #Title
              dashboardHeader(
                title="Simpson's paradox",
                titleWidth=250,
                tags$li(class = "dropdown",
                      tags$a(href='https://shinyapps.science.psu.edu/',
                             icon("home")))
                ),
              #Sidebar
              dashboardSidebar(
             
                width = 250,
                sidebarMenu(
                  id = "tabs",
                  menuItem("Overview", tabName = "over", icon = icon("dashboard")),
                  menuItem("Exploration", tabName = "first", icon = icon("wpexplorer")),
                  menuItem("References",tabName = "Ref",icon = icon("leanpub"))),
                  #PSU logo
                  tags$div(
                    class = "sidebar-logo",
                    boastUtils::psu_eberly_logo("reversed")
                  )
                ),
              
              #Content within the tabs
              dashboardBody(
                tags$head(
                  tags$link(rel = "stylesheet", type = "text/css", 
                            href="https://educationshinyappteam.github.io/Style_Guide/theme/boast.css")
                ),
                
                tabItems(
                  tabItem(tabName = "over",
                          
                          h1("Simpsons Paradox"),
                          p("In this app you will explore Simpson's paradox.
                                      Simpson's paradox is a phenomenon in which a trend appears in different 
                                      groups of data but disappears or reverses when these groups are combined."
                          ),
                          p("This app examines SAT scores in 12 states and how they are related to 
                                               teachers' salaries in year 2010. The states are divided into 6 
                                               with high SAT participation rates ( California, Maryland,
                                                Massachusetts, New Jersey, Pennsylvania and
                                                Rhode Island ), and 6 with 
                                               low SAT participation rates ( Kansas, Minnesota, 
                                               Nebraska, North Dakota, Tennessee and Wisconsin ).

                                               "
                          ),
                          
                          p(tags$li("When you just look at the states with high SAT
                                                       participation rates ( blue circles ), you will see a 
                                                       positive relationship. Similarly, if you just look 
                                                       at the states with low SAT participation 
                                                       rates ( orange circles ), there is also a positive relationship.")),
                          p(tags$li("Looking at all 12 states together, you will see
                                                       a negative relationship ( black line ). The difference 
                                                       between the black line and the orange and blue lines illustrates 
                                                       Simpson's paradox.")),
                          p(tags$li("What would the data look like if the participation rates were 
                                                       more equal? Adjust the slider to see!")), 
                         
                          br(),
                          h2("Instructions"),
                          p(tags$li("Click the Explore button below to see the plot of original/actual paradox effect.")),
                          p(tags$li("Move the slider to see how making the participation rates more equal lessen
                                      the paradox effect.")),
                          div(style = "text-align: center",bsButton("explore", "Explore", icon("bolt"), size = "large")),
                          br(),
                          h2("Acknowledgements"),
                          p("This app was developed and programmed by Jinglin Feng and updated by Zhuolin Luo in 2020."),
                          
                         
                            br(),
                            br(),
                            br(),
                            div(class = "updated", "Last Update: 07/07/2020 by ZL.")
                          
                          
                  ),
                  
                  #Define the content contained within part 1 ie. tabname "first"
                  tabItem(tabName = "first",
                          
                          fluidRow(
                              
                              column(6,
                                 h3("Plot:"),
                               
                                 div(style = "position:relative;right:-6em;",
                                 sliderInput("integer", label = div(style='width:216%;', 
                                                                            div(style='float:left; width:50%', 'No Paradox Effect'), 
                                                                           div(style='float:right;width:50%', 'Actual Paradox Effect')), 
                                                                min = 0, max = 1, value = 1, width = '394px')),
                                 bsPopover("integer", "", "Move the slider to see how the Simpson Paradox effect changes. Default as actual paradox effect, which is the true SAT participation rates in the dataset. No paradox effect is the case that when all states have equal SAT participation rates", place="right", options = list(container = "body")),
                          
                                 plotlyOutput("plot2"),
                                 bsPopover("plot2", "", "Hover over a point to see more details", placement = "right"),
                                 img(src="jinglin.jpg", width="70%"),
                                 
                                 h3("Challenge:"),
                                 h4("How does the slope of the overall regression line change
                                    as the SAT participation rate become more similar from State to State?")
                                           
                          
                                
                            ),
                          
                          column(4,offset = 1,
                                 h3("Introduction:"),
                                 box(width ="10.5%",background = "navy",
                                     "This dataset is about the SAT results by state in 2010. There 
                                     are 12 selected states with different average teachers' salaries, SAT 
                                     scores and SAT participation rates. The variable 'salary' is 
                                     the average teachers' salaries in US dollars ; The variable 'total' 
                                     is the state average SAT score ; The variable 'sat pct' is 
                                     the percent of students taking the SAT in that state."),
                                 
                                 img(src="table.jpg", width = "306px", height = "400px", style="display: block; margin-left: auto; margin-right: auto;"),
                                 br(),
                                 h4(tags$div(
                                   tags$strong("Low Group"),
                                   ": States have SAT Participation Rate", 
                                   tags$strong("less than 27%" ),
                                   "(National Level)")),
                                 
                                 h4(tags$div(
                                   tags$strong("High Group"),
                                   ": States have SAT Participation Rate", 
                                   tags$strong("greater than 27%" ),
                                   "(National Level)"))
                                 
                                 
                                 )
                          
                  )
              ),
              
              tabItem(
                tabName = "Ref",
                withMathJax(),
                h2("References"),
                p(class = "hangingindent",
                  "Bailey, E. (2015), shinyBS: Twitter bootstrap components for shiny, R package. Available from https://CRAN.R-project.org/package=shinyBS"),
                p(class = "hangingindent",
                  "Baumer, B., Kaplan, D., & Horton, N. J. (2017), Information about SAT results by state for 2010"),
                p(class = "hangingindent",
                  "Chang, W. and Borges Ribeio, B. (2018), shinydashboard: Create dashboards with 'Shiny', R Package. Available from https://CRAN.R-project.org/package=shinydashboard"),
                p(class = "hangingindent",
                  "Chang, W., Cheng, J., Allaire, J., Xie, Y., and McPherson, J. (2019), shiny: Web application framework for R, R Package. Available from https://CRAN.R-project.org/package=shiny"),
                p(class = "hangingindent",
                  "Sievert, C., Parmer, C., Hocking, T., Chamberlain, S., Ram, K., Corvellec, M. and Despouy, P. (2020), plotly: Create Interative Web Graphics via 'plotly.js', R Package. Available from https://cran.r-project.org/web/packages/plotly/index.html"),
                p(class = "hangingindent",
                  "Wei, T., Simko, V., Levy, M., Xie, Y., Jin, Y. and Zemla, J. (2017), corrplot: Visualization of a Correlation Matrix, R Package. Available from https://cran.r-project.org/web/packages/corrplot/index.html"),
                p(class = "hangingindent",
                  "Wickham H. (2016), ggplot2: Elegant graphics for data analysis, R Package, New York: Springer-Verlag. Available from https://ggplot2.tidyverse.org")
                
                )
)#end of tabItem
)
)

               
            
    