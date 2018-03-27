rm(list=ls())

library(geoR)
library(sp)
library(geoR)

df = read.csv('precip.csv')
head(df)

coordinates(df) = ~LONGITUDE+LATITUDE
bubble(df, 'PRCP', col='grey', maxsize=1.5, pch=19, fill=T)
head(df)

df.geoR = as.geodata(df, data.col=1)

points(df.geoR, ylab="", xlab="", col="gray")
plot(df.geoR)

df.geoR

###

x_coord = df.geoR[[1]][, 1]
y_coord = df.geoR[[1]][, 2]
rain_mm = df.geoR[[2]]

plot(x_coord, rain_mm)
x_fit = lm(rain_mm ~ x_coord)
summary(x_fit)
abline(x_fit, col='red')

plot(y_coord, rain_mm)
y_fit = lm(rain_mm ~ y_coord)
summary(y_fit)
abline(y_fit, col='red')

###

lz.geoR = df.geoR
lz.geoR$data = log(df.geoR$data)

# example of classical variogram
lz.v = variog(lz.geoR, max.dist=1500)

# example of robust variogram
lz.v2 = variog(lz.geoR, max.dist=1500, estimator.type = c("modulus"))

# comparison of classical vs robust variogram
plot(lz.v2,pch=19)
lines(lz.v, type="p", pch=10)
legend(0, 2.0, pch=c(19,10), c("robust","classic"), cex=0.8)

# x=lz.v$u
# y1=lz.v$v
# y2=lz.v2$v
# for_plotting <- data.frame(x,y1,y2)
# require(ggplot2)
# ggplot(for_plotting, aes(x)) +                    # basic graphical object
#   geom_line(aes(y=y1), colour="red") +  # first layer
#   geom_line(aes(y=y2), colour="green")  # second layer
