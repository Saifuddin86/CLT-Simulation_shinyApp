
set.seed(879)
library(tidyverse)
library(shiny)
library(ggthemes)
library(bslib)
library(systemfonts)
#thematic::thematic_shiny(font = "auto")

theme <- bslib::bs_theme(
  version = 4,
  bootswatch = "flatly" # Replace "flatly" with another theme if you'd like
)
#

distribution<-c("Uniform","Exponential","Beta")


# Application Layout
shinyUI(
  fluidPage(
    # Add a custom theme using bslib
    theme = bslib::bs_theme(
      bg = "#edede9", 
      fg = "black", 
      primary = "#023047", 
      base_font = bslib::font_google("Source Sans Pro")
    ),
    br(),
    
    # Application title
    titlePanel("Simulation of Central Limit Theorem"),
    
    # Description of the simulation
    p("The random numbers are generated from Uniform(0,50),Exponential(3) and
      Beta(10,2) with the population size N=1,00,000."),
    
    # Task 2: First row with population distribution and its histogram
    fluidRow(
      column(4, 
             wellPanel(
               selectInput("distribution", "Population distribution", distribution),
               sliderInput("bins", "Number of bins for the population distribution", 
                           min = 5, max = 50, value = 10),
               p( tags$b("Method:"), "In the following simulation, samples are drawn 
                 repeatedly from the population and sample means are computed;
                 finally histogram of samples means are plotted.")
             )
      ),
      column(8, 
             plotOutput("p1") # Population distribution histogram
      )
    ),
    
    # Task 3: Second row with simulation controls and sample means histogram
    fluidRow(
      column(4, 
             wellPanel(
               numericInput("nsim", "Number of simulations (Maximum 10,000)", 
                            min = 500, max = 10000, value = 500),
               sliderInput("n", "Sample size", min = 0, max = 385, value = 30),
               sliderInput("bin_sim", "Number of bins for the distribution of sample means", 
                           min = 5, max = 50, value = 10)
             )
      ),
      column(8, 
             plotOutput("p2") # Sample means histogram
             #plotOutput("p3")
      )
    ),
    
    # Additional explanation
    fluidPage(
      br(),
      tags$p(
        "This is the essence of the ", 
        tags$b("Central Limit Theorem (CLT)"), 
        ". It states that, regardless of the shape of the population distribution 
    (e.g., Uniform, Exponential, or even skewed), the distribution of 
    sample means will approach a ", 
        tags$b("Normal Distribution"), 
        " as the sample size increases, provided the samples are independent and identically distributed.",
        tags$br(), tags$br(),
        "This property is the backbone of statistical inference and is why we 
    can use normal approximations in many real-world scenarios. It allows 
    us to make predictions and inferences about population parameters from 
    sample data, no matter how irregular the underlying distribution might be."
      )
    )
  )
)
