library(shiny)
library(shinydashboard)
library(ggplot2)
library(shinyBS)
library(plotly)


dashboardPage(#skin="black",
              
              #Title
              dashboardHeader(title="Simpson's paradox",titleWidth=260),
              
              #Sidebar
              dashboardSidebar(
             
                width = 235,
                sidebarMenu(
                  id = "tabs",
                  menuItem("Overview", tabName = "over", icon = icon("dashboard")),
                  menuItem("Exploration", tabName = "first", icon = icon("wpexplorer"))
                )),
              
              #Content within the tabs
              dashboardBody(
                tags$head(
                  tags$link(rel = "stylesheet", type = "text/css", href = "sidebar.css")
                ),
                
                tabItems(
                  tabItem(tabName = "over",
                          tags$a(href='http://stat.psu.edu/',tags$img(src='PS-HOR-RGB-2C.png', align = "left", width = 180)),
                          br(),br(),br(),
                          h3(tags$b("About:")),
                          h4("In this app you will explore Simpson's paradox.
                                      Simpson's paradox is a phenomenon in which a trend appears in different 
                                      groups of data but disappears or reverses when these groups are combined."
                          ),
                          h4(p("This app examines SAT scores in 12 states and how they are related to 
                                               teachers' salaries in year 2010. The states are divided into 6 
                                               with high SAT participation rates ( California, Maryland,
                                                Massachusetts, New Jersey, Pennsylvania and
                                                Rhode Island ), and 6 with 
                                               low SAT participation rates ( Kansas, Minnesota, 
                                               Nebraska, North Dakota, Tennessee and Wisconsin ).

                                               "
                          )),
                          
                          h4(tags$li("When you just look at the states with high SAT
                                                       participation rates ( blue circles ), you will see a 
                                                       positive relationship. Similarly, if you just look 
                                                       at the states with low SAT participation 
                                                       rates ( orange circles ), there is also a positive relationship.")),
                          h4(tags$li("Looking at all 12 states together, you will see
                                                       a negative relationship ( black line ). The difference 
                                                       between the black line and the orange and blue lines illustrates 
                                                       Simpson's paradox.")),
                          h4(tags$li("What would the data look like if the participation rates were 
                                                       more equal?", tags$strong("Adjust the slider to see!"))),
                          br(),
                          h3(tags$b("Instructions:")),
                          h4(tags$li("Click the Explore button below to see the plot of original/actual paradox effect.")),
                          h4(tags$li("Move the slider to see how making the participation rates more equal lessen
                                      the paradox effect.")),
                          div(style = "text-align: center",bsButton("explore", "Explore", icon("bolt"), size = "large")),
                          br(),
                          h3(tags$b("Acknowledgements:")),
                          h4(tags$div("This app was developed and coded by Jinglin Feng. Special thanks to Alex Chen for being my partner in this project. 
                                    Information about SAT results by state for 2010 was drawn from 
                                    Baumer, B., Kaplan, D., & Horton, N. J. (2017).",tags$i("Modern data science with R."), 
                                      "Special thanks to Chelsea Wang and Yuxin Zhang for help on some programming issues."))
                  ),
                  
                  #Define the content contained within part 1 ie. tabname "first"
                  tabItem(tabName = "first",
                          div(style="display: inline-block;vertical-align:top;",
                              tags$a(href='https://shinyapps.science.psu.edu/',tags$img(src='homebut.PNG', width = 15))
                          ),
                          fluidRow(
                              
                              column(6,
                                 h3("Plot:"),
                                 
                                 tags$style(HTML(".js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-bar {background: #1C2C5B}")),
                                 
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
                                 
                                 #tags$style(HTML(".js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-bar {background: #1C2C5B}")),
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
              )
)
)
)

               
            
    