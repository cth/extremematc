library(shiny)

orig=read.table("sample.csv",sep=",",head=F)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot

  output$distPlot <- renderPlot({
	picat.cmd=paste("./picat m.pi sample.csv", input$samples, input$bmi, "/tmp/out.csv")
	print(picat.cmd)
	system(picat.cmd)
	print("picat done")

	matched=read.table("/tmp/out.csv", sep=",", head=T)

	print(matched)
	plot(orig,xlab="BMI", ylab="isi-matsuda")

	points(orig[matched[,1],],col="green")
	points(orig[matched[,2],],col="red")

	for(i in 1:nrow(matched)) {
		lines(c(orig[matched[i,1],1],orig[matched[i,2],1]), c(orig[matched[i,1],2],orig[matched[i,2],2]))
	}
  })
})
