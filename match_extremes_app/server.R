library(shiny)

orig=read.table(infile,sep=",",head=F)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
	fname.out <- paste0("/tmp/out-", input$samples, "-", input$bmi, ".csv")
	print(fname.out)
	picat.cmd=paste("./picat m.pi sample.csv", input$samples, input$bmi, fname.out)
	print(picat.cmd)
	system(picat.cmd)
	print("picat done")

	matched=read.table(fname.out, sep=",", head=T)

	print(matched)
	plot(orig,xlab="BMI", ylab="isi-matsuda")

	points(orig[matched[,1],],col="green")
	points(orig[matched[,2],],col="red")

	for(i in 1:nrow(matched)) {
		lines(c(orig[matched[i,1],1],orig[matched[i,2],1]), c(orig[matched[i,1],2],orig[matched[i,2],2]))
	}
  })

  output$matched <- renderDataTable({
	fname.out <- paste0("/tmp/out-", input$samples, "-", input$bmi, ".csv")
	picat.cmd=paste("./picat m.pi sample.csv", input$samples, input$bmi, fname.out) 
	print(picat.cmd)
	system(picat.cmd)
	read.table(fname.out, sep=",", head=T)
  })
})
