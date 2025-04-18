#Prepare population data
set.seed(879)
N<-10000
Uniform<-runif(N,0,50)
#hist(Uniform)
Exponential<-rexp(N,3)
#hist(Exponential)
Beta<-rbeta(N,10,2)
#hist(Beta)
tibble::tibble (Uniform,Exponential,Beta) %>% gather(key="Distribution",
                                                value="Value")->pop_data

filter(pop_data,Distribution=="Uniform") %>% ggplot(aes(x=Value))+
  geom_histogram(bins = 20)->uhist
  


shinyServer(function(input,output){
  df_pop<- reactive({
    pop_data %>% filter(Distribution == input$distribution)
  })
  
  # create a histogram from population
  output$p1<-renderPlot({
    ggplot(df_pop(),aes(x=Value))+
      geom_histogram(bins = input$bins,fill="#48cae4",color="black")+
      labs(title=paste("Histogram of ", input$distribution,"distribution (N=1,00,000)"),
           x = ifelse(input$distribution == "Uniform", "X~U(0,50)",
                      ifelse(input$distribution =="Exponential", "X~EXP(3)",
                             "X~Beta(10,2)")),
           y="Frequency")+
      theme_clean()+
      theme(axis.text = element_text(size=16),
            axis.title =element_text(size=16))
  })
  
  # Create histogram of Sample means
  
  output$p2 <- renderPlot({
    sample_means <- replicate(input$nsim, {
      sample(df_pop()$Value, size = input$n, replace = FALSE) %>% mean()
    })
    
    ggplot(data.frame(SampleMeans = sample_means), aes(x = SampleMeans)) +
      geom_histogram(bins = input$bin_sim, fill = "steelblue", alpha = 0.7,
                     color="black") +
      labs(x= expression(paste("Sample mean,"," ", bar(x))),
           y="Frequency",
           title ="Histogram of Sample Means" )+
      theme_clean()+
      theme(axis.text = element_text(size=16),
            axis.title =element_text(size=16))
  })
  
})



