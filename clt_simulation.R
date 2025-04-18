library(tidyverse)
#library(shiny)
# Prepare population data
set.seed(321)
N=10000
Uniform<-runif(N,10,30)
#hist(Uniform)
Exponential<-rexp(N,2.5)
#hist(Exponential)
Beta<-rbeta(N,10,2)
hist(Beta)
tibble::tibble (Uniform,Exponential) %>% gather(key="Distribution",
                                                value="Value")->pop_data

distribution<-c("Uniform","Exponential")


# Application Layout
shinyUI(
  fluidPage(
    br(),
    # TASK 1: Application title
    titlePanel("Simulation of Central limit theorem"),
    
    # Task 2: add a row where we choose population distribution and 
              # its histogram
    fluidRow(column(3,
           wellPanel(
             selectInput("distribution","Distribution",distribution),
             numericInput("nsim","Number of simulation",min=500,1000,value=1000),
             numericInput("bins", "Number of bins", min = 0, max = 150, value = 10)
           )),
           column(9,plotOutput("p1"))
           ),
  
  # Task 3: Show the histogram of sample means
  fluidPage(column(3,
                   wellPanel(
                     numericInput("n", "Sample size", min = 0, max = 250, value = 10)
                   )),
            column(9,plotOutput("p2"))
            )
)
)


shinyServer(function(input,output){
   # create a histogram from population
  output$p1<-renderPlot({
    ggplot(pop_data,aes(x=Value))+
      geom_histogram()
  })
  
  
  })


