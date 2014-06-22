shinyServer(function(input, output) {
      option.value <- function(S,X,t,r,v,cp)
      {
            t=max(t,0.00001)
            d1 <- (log(S/X)+(r+0.5*v^2)*t)/(v*sqrt(t))
            d2 <- d1-v*sqrt(t)
            if (cp=="call") {
                  delta=pnorm(d1)
                  price=S*delta-X*exp(-r*t)*pnorm(d2) 
                              } else {
                  delta=-pnorm(-d1)
                  price=X*exp(-r*t)*pnorm(-d2)+S*delta
                              }
            gamma=exp(-d1^2/2)/S/v/sqrt(2*pi*t)
            vega=gamma*t*S*S*v
            data.frame(price=price,delta=delta,gamma=gamma,vega=vega)
      }
      
      Spot=c(seq(from=10,to=80,by=10),seq(from=80,to=95,by=5),seq(from=95,to=105,by=2),seq(from=105,to=120,by=5),seq(from=120,to=200,by=10))
      par(mar=c(2,2,0,0))
      output$plot1<-renderPlot({
            if (is.na(input$rate)) rate=0 else rate=input$rate/100
            par(mar=c(3,4,1,0))
            plot(Spot,option.value(S=Spot,X=100,r=rate,t=input$mty,v=input$vol/100,cp=input$type)$price,type='b',col='red',ylab=paste("PRICE",toupper(input$type)));
            if (input$type=="call") {
                  segments(x0=0,y0=0,x1=100,y1=0,lty=3);segments(x0=100,y0=0,x1=200,y1=100,lty=3)
            } else {
                  segments(x0=0,y0=100,x1=100,y1=0,lty=3);segments(x0=100,y0=0,x1=200,y1=0,lty=3)
            }
            })
     
      output$plot2<-renderPlot({
            if (is.na(input$rate)) rate=0 else rate=input$rate/100
            par(mar=c(3,4,1,0))
            if (input$output=="delta") {
            plot(Spot,option.value(S=Spot,X=100,r=rate,t=input$mty,v=input$vol/100,cp=input$type)$delta,type='b',col='blue',ylab=paste("DELTA",toupper(input$type)));
            if (input$type=="call") {
                  segments(x0=0,y0=0,x1=100,y1=0,lty=3);segments(x0=100,y0=0,x1=100,y1=1,lty=3);segments(x0=200,y0=1,x1=100,y1=1,lty=3)
            } else {
                  segments(x0=0,y0=-1,x1=100,y1=-1,lty=3);segments(x0=100,y0=0,x1=100,y1=-1,lty=3);segments(x0=200,y0=0,x1=100,y1=0,lty=3)
            }
            } else {
                  if (input$output=="gamma") {
                  plot(Spot,option.value(S=Spot,X=100,r=rate,t=input$mty,v=input$vol/100,cp=input$type)$gamma,type='b',col='dark green',ylab=paste("GAMMA",toupper(input$type)))
                        } else {
                        plot(Spot,option.value(S=Spot,X=100,r=rate,t=input$mty,v=input$vol/100,cp=input$type)$vega,type='b',col='purple',ylab=paste("VEGA",toupper(input$type)))
                        }          
                  } 
      })
      
      output$text1<-renderText({paste0("Vol=",input$vol)})
})
