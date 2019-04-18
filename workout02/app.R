#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application
ui <- fluidPage(
  
  # Application title
  titlePanel("Saving Investing Modalities"),
  
  # Input Widgets 
  fluidRow(
    column(4,
           sliderInput("initial", "Initial Amount ($)",
                       min = 0,
                       max = 100000,
                       value = 1000,
                       pre = "$",
                       step = 500)),
    column(4,
           sliderInput("rate", "Return Rate (%)",
                       min = 0,
                       max = 20,
                       value = 5,
                       step = 0.1)),
    column(4,
           sliderInput("year", "Years",
                       min = 0,
                       max = 50,
                       value = 20,
                       step = 1))),
  fluidRow(
    column(4,
           sliderInput("annual", "Annual Contribution ($)",
                       min = 0, 
                       max = 50000,
                       value = 2000,
                       pre = "$",
                       step = 500)),
    column(4,
           sliderInput("growth", "Growth Rate (%)",
                       min = 0, 
                       max = 20,
                       value = 2,
                       step = 0.1)),
    column(4,
           selectInput("facet", "Facet?",
                       choices = c("Yes", "No"),
                       selected = "No"))),
  
  # Show a plot and table of the generated distribution
  mainPanel(
    h4('Timelines'),
    plotOutput("plot"),
    h4("Balances"),
    tableOutput("balances")
  )
)

# Modality functions

# Write a function future_value() that computes the future value of an investment, taking the following arguments: amount, rate, years
#' @title Future Value Function
#' @description calculates future value of an investment
#' @param amount amount initially invested (numeric)
#' @param rate annual rate of return (numeric)
#' @param years number of years (numeric)
#' @return computed future value (numeric)
future_value <- function(amount, rate, years) {
  return(amount * ((1 + rate)^years))
}

# Write a function annuity() that computes the future value of annuity, taking the following arguments: contrib, rate, years
#' @title Future Value of Annuity
#' @description calculates future value of annuity
#' @param contrib contributed amount (numeric)
#' @param rate annual rate of return (numeric)
#' @param years num of years (numeric)
#' @return computed future value of annuity (numeric)
annuity <- function(contrib, rate, years) {
  return(contrib * (((1 + rate)^years - 1)/rate))
}

# Write a function growing_annuity() that computes the future value of growing annuity, taking the following arguments: contrib, rate, growth, years
#' @title Future Value of Growing Annuity
#' @description calculates future value of growing annuity
#' @param contrib first contribution (numeric)
#' @param rate annual rate of return (numeric)
#' @param growth annual growth rate (numeric)
#' @param years number years (numeric)
#' @return computed future value of growing annuity (numeric)
growing_annuity <- function(contrib, rate, growth, years) {
  return(contrib * (((1 + rate)^years - (1 + growth)^years)/(rate - growth)))
}

# Define server logic
server <- function(input, output) {
  
  # Plot
  output$plot <- renderPlot({
    x <- c(input$initial)
    no_contrib <- c(input$initial)
    y <- c(input$initial)
    fixed_contrib <- c(input$initial)
    z <- 5
    growing_contrib <- c(input$initial)
    input_year <- input$year
    year_range <- 1:input$year
    for(i in year_range) {
      input_rate <- input$rate/100
      input_growth <- input$growth / 100
      input_initial <- input$initial
      input_annual <- input$annual
      no_contrib <- c(no_contrib, future_value(amount = input_initial, rate = input_rate, years = i))
      all_contrib <- 0:input$year
      fixed_contrib <- c(fixed_contrib, future_value(amount = input_initial, rate = input_rate, years = i) + annuity(contrib = input_annual, rate = input_rate, years = i))
      growing_contrib <- c(growing_contrib, future_value(amount = input_initial, rate = input_rate, years = i) + growing_annuity(contrib = input_annual, rate = input_rate, growth = input_growth, years = i))
    }
    
    each_year = input$year + 1
    all_contrib <- 0:input$year
    dat <- data.frame(year = all_contrib, mode = rep(c('no_contrib', 'fixed_contrib', 'growing_contrib'), each = each_year), balance = c(no_contrib, fixed_contrib, growing_contrib))
    dat$mode <- factor(dat$mode, levels = c('no_contrib', 'fixed_contrib', 'growing_contrib'))
    # No facetting
    if (input$facet == "No") {
      ggplot(data = dat, aes(x = year, y = balance, col = mode)) + 
        labs(title = "Three Modes of Investing", x = "Year", y = "Value", color = "Mode") +
        geom_line(size = 0.5) + 
        geom_point(size = 0.5) + 
        scale_color_discrete('mode')
    } else {
      ggplot(data = dat, aes(x = year, y = balance, col = mode)) + 
        labs(title = "Three Modes of Investing", x = "Year", y = "Value") +
        geom_line(size = 0.5) + 
        geom_point(size = 0.5) + 
        scale_color_discrete('mode') +
        geom_area(aes(fill = mode), alpha = 0.5) +
        facet_wrap(~mode)
    }
  })
  
  # Create the table for the three modes
  output$balances <- renderTable(digits = 3, rownames = TRUE, {
    
    no_contrib <- c(input$initial)
    x <- c(input$initial)
    fixed_contrib <- c(input$initial)
    y <- c(input$initial)
    growing_contrib <- c(input$initial)
    
    input_years <- 1:input$year
    for(i in input_years) {
      input_rate <- input$rate / 100
      initial_input <- input$initial
      input_growth <- input$growth / 100
      annual_input <- input$annual
      no_contrib <- c(no_contrib, future_value(amount = initial_input, rate = input_rate, years = i))
      fixed_contrib <- c(fixed_contrib, future_value(amount = initial_input, rate = input_rate, years = i) + annuity(contrib = annual_input, rate = input_rate, years = i))
      growing_contrib <- c(growing_contrib, future_value(amount = initial_input, rate = input_rate, years = i) + growing_annuity(contrib = annual_input, rate = input_rate, growth = input_growth, years = i))
    }
    year <- 0:input$year
    df <- data.frame(cbind(year, no_contrib, fixed_contrib, growing_contrib))
    xy<- input$growth / 100
    df$year <- sprintf('%1.0f', df$year)
    df
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

