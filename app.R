# Load packages ----
library(shiny)
library(shinydashboard)
library(shinyBS)
library(boastUtils)
library(ggplot2)
library(dplyr)

# Define Global Constants, Functions, Load Data ----
## From https://github.com/beanumber/mdsr/blob/master/data/SAT_2010.rda
load("./SAT_2010.rda")

selectedStates <- c("California", "Maryland", "Massachusetts", "New Jersey",
                    "Pennsylvania", "Rhode Island", "Kansas", "Minnesota",
                    "Nebraska", "North Dakota", "Tennessee", "Wisconsin")
## Clean data

cleanData <- SAT_2010 %>%
  dplyr::select(state, salary, total, sat_pct) %>%
  dplyr::filter(state %in% selectedStates) %>%
  dplyr::mutate(
    group = ifelse(
      test = sat_pct > 27,
      yes = "High",
      no = "Low"
    )
  )

# Define the UI ----
ui <- list(
  dashboardPage(
    skin = "purple",
    ## Header ----
    dashboardHeader(
      title = "Simpson's Paradox",
      titleWidth = 250,
      tags$li(
        class = "dropdown",
        tags$a(target = "_blank", icon("comments"),
               href = "https://pennstate.qualtrics.com/jfe/form/SV_7TLIkFtJEJ7fEPz?appName=Simpsons_Paradox"
        )),
      tags$li(class = "dropdown",
              tags$a(href = 'https://shinyapps.science.psu.edu/',
                     icon("home")))
    ),
    ## Sidebar ----
    dashboardSidebar(
      width = 250,
      sidebarMenu(
        id = "pages",
        menuItem("Overview", tabName = "over", icon = icon("dashboard")),
        menuItem("Exploration", tabName = "first", icon = icon("wpexplorer")),
        menuItem("References",tabName = "Ref", icon = icon("leanpub"))),
      tags$div(
        class = "sidebar-logo",
        boastUtils::psu_eberly_logo("reversed")
      )
    ),
    ## Body ----
    dashboardBody(
      tabItems(
        tabItem(
          ### Overview ----
          tabName = "over",
          h1("Simpsons Paradox"),
          p(
            "In this app you will explore Simpson's paradox. Simpson's paradox is
            a phenomenon in which a trend appears in different groups of data but
            disappears or reverses when these groups are combined."
          ),
          p(
            "This app examines SAT scores in 12 states and how they are related
            to teachers' salaries in year 2010. The states are divided into two
            groups; one with high SAT participation rates (California, Maryland,
            Massachusetts, New Jersey, Pennsylvania and Rhode Island), and the
            other with low SAT participation rates (Kansas, Minnesota, Nebraska,
            North Dakota, Tennessee and Wisconsin)."
          ),
          tags$ol(
            tags$li(
              "When you just look at the states with high SAT participation rates
              (blue circles), you will see a positive relationship. Similarly, if
              you just look at the states with low SAT participation rates (orange
              circles), there is also a positive relationship."
            ),
            tags$li(
              "Looking at all 12 states together, you will see a negative
              relationship (black line). The difference between the black line
              and the orange and blue lines illustrates Simpson's paradox."
            ),
            tags$li(
              "What would the data look like if the participation rates were
              similar? Adjust the slider to see!"
            )
          ),
          br(),
          h2("Instructions"),
          tags$ol(
            tags$li(
              "Click the Explore button below to see the plot of original/actual
              paradox effect."
            ),
            tags$li(
              "Move the slider to see how making the participation rates more
              similar to lessen the paradox effect."
            )
          ),
          div(
            style = "text-align: center;",
            bsButton(
              inputId = "explore",
              label = "Explore",
              icon = icon("bolt"),
              size = "large"
            )
          ),
          br(),
          h2("Acknowledgements"),
          p(
            "This app was originally developed and programmed by Jinglin Feng with
            Alex Chen. Chelsea Wang and Yuxin Zhang assisted with some original
            programing issues. The app was updated by Zhuolin Luo and Neil Hatfield
            in 2020."
          ),
          br(),
          p(
            br(),
            br(),
            br(),
            div(class = "updated", "Last Update: 12/11/2020 by NJH.")
          )
        ),
        ### Exploration page ----
        tabItem(
          tabName = "first",
          h2("Exploring Simpson's Paradox"),
          p(
            "For this app, we are going to look at a data set containing data from
            2010 for 12 selected states. We will look at these states' average
            teachers' salaries (US$ 2010), total SAT scores, and SAT participation
            rates (percent of students in each state taking the SAT)."
          ),
          p("We've divided the 12 selected states into two groups based upon how
            their SAT participation compares to the National level of 27%:"),
          tags$ul(
            tags$li(
              tags$strong("Low: "), "States with SAT participation less than 27%"
            ),
            tags$li(
              tags$strong("High: "), "States with SAT participation higher than 27%"
            )
          ),
          box(
            title = "View Data",
            collapsible = TRUE,
            collapsed = TRUE,
            width = 12,
            DT::DTOutput("HLtable")
          ),
          br(),
          fluidRow(
            column(
              width = 4,
              wellPanel(
                checkboxInput(
                  inputId = "showGrouping",
                  label = "Show Grouping",
                  value = FALSE
                ),
                sliderInput(
                  inputId = "participation",
                  label = "Vary participation",
                  min = 0,
                  max = 1,
                  step = 0.01,
                  value = 1
                ),
                tags$ul(
                  tags$li(
                    "Set the slider to 1 to see the actual effect of the paradox."
                  ),
                  tags$li(
                    "Set the slider to 0 to see no paradox effect at all."
                  ),
                  tags$li(
                    "Varying the slider in between will make the SAT participation
                    more (towards 0) or less (towards 1) similar."
                  )
                )
              )
            ),
            column(
              width = 8,
              plotOutput("scatterPlot"),
              tags$script(HTML(
                "$(document).ready(function() {
                document.getElementById('scatterPlot').setAttribute('aria-label',
                `Explore how Simpson's Paradox affects the relationship between
                states' average teacher salaries and average total test scores by
                looking at whether the state is in the high or low participation
                group. Use the vary participation slider to make the states'
                participation rates more or less similar.`)
                })"
              ))
            )
          ),
          h3("Challenge"),
          p(
            "How does the slope of the overall regression line change as the SAT
            participation rate become more similar from State to State?"
          )
        ),
        tabItem(
          ### References ----
          tabName = "Ref",
          withMathJax(),
          h2("References"),
          p(
            class = "hangingindent",
            "Bailey, E. (2015), shinyBS: Twitter Bootstrap Components for Shiny.
            R package version 0.61. Available from
            https://CRAN.R-project.org/package=shinyBS"
          ),
          p(
            class = "hangingindent",
            "Baumer, B. S., Kaplan, D. T., & Horton, N. J. (2017), Modern Data
            Science with R. Chapman and Hall/CRC. [SAT 2010 Data Set]."
          ),
          p(
            class = "hangingindent",
            "Carey, R. and Hatfield, N. (2020). boastUtils: BOAST Utilities. R
            package version 0.1.6.6. Available from
            https://github.com/EducationShinyAppTeam/boastUtils"
          ),
          p(
            class = "hangingindent",
            "Chang, W. and Borges Ribeio, B. (2018), shinydashboard: Create
            dashboards with 'Shiny', R Package. Available from
            https://CRAN.R-project.org/package=shinydashboard"
          ),
          p(
            class = "hangingindent",
            "Chang, W., Cheng, J., Allaire, J., Xie, Y., and McPherson, J. (2019),
            shiny: Web application framework for R, R Package. Available from
            https://CRAN.R-project.org/package=shiny"
          ),
          p(
            class = "hangingindent",
            "Wickham H. (2016), ggplot2: Elegant graphics for data analysis,
            R Package, New York: Springer-Verlag. Available from
            https://ggplot2.tidyverse.org"
          ),
          p(
            class = "hangingindent",
            "Wickham H., François, R., Henry, L, and Müller, K. (2020), dplyr:
            A Grammar of data manipulation. R Package [v 1.0.2]. Available from
            https://CRAN.R-project.org/package=dplyr"
          )
        )
      )
    )
  )
)

# Define the server ----
server <- function(input, output,session) {
  ## Explore Button ----
  observeEvent(
    eventExpr = input$explore,
    handlerExpr = {
    updateTabItems(
      session = session,
      inputId = "pages",
      selected = "first"
    )
  })

  ## Display data table ----
  output$HLtable <- DT::renderDT(
    expr = cleanData,
    caption = "Data for Exploring Simpson's Paradox",
    rownames = FALSE,
    colnames = c("State", "Avg. Salary ($)", "Avg. Total SAT Score",
                 "Participation", "Group"),
    style = "bootstrap4",
    options = list(
      responsive = TRUE,
      scrollX = TRUE,
      ordering = TRUE,
      paging = FALSE,
      lengthChange = FALSE,
      pageLength = 12,
      searching = FALSE,
      info = FALSE,
      columnDefs = list(
        list(className = "dt-center", targets = 1:4)
      )
    )
  )

  ## Generate Plot ----
  observeEvent(
    eventExpr = c(input$showGrouping, input$participation),
    handlerExpr = {
      # Modification for level of participation
      # From old code
      salaryMod <- 8714 - input$participation * 8714
      totalMod <- -0.01417 * salaryMod
      modData <- cleanData %>%
        mutate(
          salary = salary + ifelse(
            test = group == "High",
            yes = -1 * salaryMod,
            no = salaryMod),
          total = total + ifelse(
            test = group == "High",
            yes = -1 * totalMod,
            no = totalMod
          )
        )
      basePlot <- ggplot(
        data = modData,
        mapping = aes(x = salary, y = total)
      ) +
        geom_point(size = 4) +
        geom_smooth(
          method = "lm",
          formula = y ~ x,
          se = FALSE,
          linetype = "longdash",
          size = 2,
          color = "black"
        ) +
        theme_bw() +
        theme(
          axis.title = element_text(size = 18),
          axis.text = element_text(size = 16),
          legend.title = element_text(size = 18),
          legend.text = element_text(size = 16),
          plot.title = element_text(size = 18),
          legend.position = "bottom"
        ) +
        xlab("Avg. teacher salary (US$)") +
        ylab("Avg. total SAT score") +
        labs(
          title = "Total SAT Score by Teacher Salary",
          color = "SAT Participation"
        )
      if (input$showGrouping) {
        modPlot <- basePlot +
          geom_point(
            mapping = aes(color = group),
            size = 4
          ) +
          geom_smooth(
            mapping = aes(group = group, color = group),
            method = "lm",
            formula = y ~ x,
            se = FALSE,
            linetype = "solid",
            size = 1
          ) +
          scale_color_manual(
            values = c(
              "High" = psuPalette[1],
              "Low" = psuPalette[2]
            )
          )
      } else {
        modPlot <- basePlot
      }
      output$scatterPlot <- renderPlot(modPlot)
    }
  )

}

# boastApp Call ----
boastUtils::boastApp(ui = ui, server = server)