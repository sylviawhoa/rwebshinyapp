install.packages('rsconnect')
library(rsconnect)

rsconnect::setAccountInfo(name='sylviawhoa', token='7C8F0FA14CDF7B90F8F55FD8485B6B1D', secret='ERNg8xcudqKOwJPBPhPts1BnhrLJufJBweM3NPqU')

#update.packages()
rsconnect::deployApp('~/Desktop/shinywebapp')
runApp() 


