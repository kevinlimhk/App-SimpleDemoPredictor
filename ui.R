## Applcation that take in Petal Width and predict Petal Length and its species.
library(shiny)

shinyUI(fluidPage(
  h2('Application - Simple Predictor To Demostrate Clustering and Linear Regression'),
  plotOutput('mainPlot', width="100%", height="100%"),
  # hr(),
  
  fluidRow (
  column (4,
          h4('Data'),
          helpText('iris dataset that consists of three species of Iris (Setosa, Virginica and Versicolor)'),
          helpText('Selected Dimension: Petal Length and Petal Width'),
          h4('Purpose Of Application'),
          helpText("The Application lets user to input a set of petal width and/or length and aims to achieve the following objectives: "),
          helpText("(1) Use Clustering to predict which species the new data point belongs to"),
          helpText("(2) Use Linear Regression to predict the Petal Length base on a give Petal Width"),
          h4('Plot Points Description'),
          helpText("*Big Dots -> Centroids of the Different Clusters for the 3 Species"),
          helpText("**Big Triangle -> the new input data point")
  ),
  column (3,
  h2("Controls"),
    checkboxGroupInput("id1", NULL,
                       c("Show Species Clusters & Centroids" = "1",
                         "Show Linear Regression" = "2"), selected=c("1","2"), inline = TRUE),
    checkboxGroupInput("id4", NULL,
                       c("Let's Predict Petal Length! (Ignore Petal Length Input Value When Selected)" = "1"), selected="1", inline = TRUE),
    numericInput('id2', 'Petal Width (min = 0, max = 2.5, step = 0.1)', 1, min = 0, max = 2.5, step = 0.1),
    numericInput('id3', 'Petal Length (min = 0, max = 7, step = 0.1)' , 1, min = 0, max = 7, step = 0.1),
    helpText('*Ignore Input if (Predict Length) checkbox is selected*')
  ),
  column (3,
    h2(textOutput('Width')),
    h2(textOutput('Length')),
    h2(textOutput('Species'))
  )
  )
  
))
