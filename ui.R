shinyUI(fluidPage(
      titlePanel("Option sensitivities"),
      
      sidebarLayout(
            sidebarPanel(
                  p("The option considered is European"),
                  selectInput("type", 
                              label = "Choose an option type (strike=100)",
                              choices = list("call", "put"),
                              selected = "call"),
            
                  sliderInput("vol",label="Range of volatility (in %):",min=0,max=100,value=30),
                  
                  sliderInput("mty",label="Maturity in year:",value=1,min=0,max=5,step=0.25),
                  
                  selectInput("output", 
                              label = "Choose a second output:",
                              choices = list("delta","gamma","vega"),
                              selected = "price"),
                  
                  numericInput("rate",label="Rate (in %):",value=1,min=0,max=20,step=1),
                  
                  p("In finance, an ",a("option",href="http://en.wikipedia.org/wiki/Option_%28finance%29") ," is a contract which gives the buyer the right, but not the obligation,to buy or sell an underlying asset at a specified strike price on a specified date."),
                  p("The buyer pays a premium to the seller for this right. An option to buy something at a specific price is a call; an option to sell is a put."),
                  p(a("Black-Scholes ",href="http://en.wikipedia.org/wiki/Black-Scholes_model")," enables to value an option as a function of the asset price, strike price, time to maturity, volatility and interest rate."),
                  p(a("Volatility ",href="http://en.wikipedia.org/wiki/Volatility_%28finance%29")," is probably the key parameter to value an option. By sliding the volatility value, you can see how it impacts the price and derivatives of price (a.k.a. ",a("the greeks",href="http://en.wikipedia.org/wiki/Black%E2%80%93Scholes_model"),"). You can also play with the time to maturity (homogeneous to the square of the volatility) and the interest rate.")
                  
                  ),
            mainPanel(
                  plotOutput("plot1"),
                  plotOutput("plot2")
                  )
      )
))