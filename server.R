library(UsingR)
library(ggplot2)
data(iris)

shinyServer(
  function(input, output) {
    ## Render Plot main function
    output$mainPlot <- renderPlot({
      
    ## Setting up the variables
    choice <<- input$id1
    ptx <<- input$id2
    pty <<- input$id3
    x <<- iris$Petal.Width
    y <<- iris$Petal.Length
    Species <<- iris$Species
    centroids <<- aggregate(cbind(x,y)~Species,iris,FUN = mean)
    
    ## Base Plot
    irisPlot <- ggplot(iris,aes(x,y))	+ geom_point() + ggtitle("Plot of Petal Width Against Petal Length (iris data)") + xlab("Petal Width") + ylab("Petal Length")
    
    ## If checkbox selected, Show clustering
    if (any(choice=='1')) {
      irisPlot <- irisPlot +  geom_point(aes(color = factor(Species)))  
      irisPlot <- irisPlot + geom_point(aes(x=centroids$x,y=centroids$y),size=5)
    }
    
    ## If checkbox selected, Show only linear regression
    if (any(choice=='2')) {
      irisPlot <- irisPlot + geom_smooth(method="lm",se=FALSE, fullrange=TRUE)
    }
    
      ## Predict petal length if Predict Checkbox Selected
      if (any(input$id4=="1")) {
        fit <- lm(y ~ x, iris)
        ptynew <<- unname(ptx*fit$coefficients[2] + fit$coefficients[1])
      } else {
        ptynew <<- pty
      }
      
      ## Predict the species of the new point
      ## Finding the centroid with the smallest distance to the new point
      centroids$diff <- abs(centroids$x-ptx) + abs(centroids$y-ptynew)
      pts <<- centroids[which.min(centroids$diff),]$Species
      
      ## Add the new point to graph
      # if (ptynew>0)
      irisPlot <- irisPlot + geom_point(mapping=aes(x=ptx,y=ptynew),size=5,shape=17)
      
      ## For UI to display the results (Width, Length and Species)
      output$Width <- renderText({paste("Selected Width = ", round(ptx,2))})
      if (any(input$id4=="1")) {
        output$Length <- renderText({paste("(Predicted) Length = ", round(ptynew,2))})
      } else {
        output$Length <- renderText({paste("(Selected) Length = ", round(ptynew,2))})
      }
      output$Species <- renderText({paste("(Predicted) Species = ", pts)})
      
      ## Final Plot to be rendered
      irisPlot
      
    }, height=500)
  })
