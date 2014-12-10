---
layout: post
title: Chapter 8 confirm table
converted: yes
---
Capital in the 21st Century: Chapter 8 confirm table
========================================================
 

{% highlight r %}
library(ggplot2)
library(xlsx)
library(reshape2)
{% endhighlight %}
 

{% highlight r %}
## Table DetailsWTIDSeries
fname="../_data/Chapter8TablesFigures.xlsx"
tabname="DetailsWTIDSeries"
 
dWTID = read.xlsx(fname,sheetName=tabname,rowIndex=4:147,colIndex=1:126,header=TRUE,keepFormulas=TRUE)
dWTID<-dWTID[c(-1,-2),]
names(dWTID)[1]<-"YEAR"
columns.France<-c(1,grep("France",names(dWTID)))
recoTS81<-dWTID[,columns.France]
columns.USA<-c(1,grep("United.States",names(dWTID)))
recoTS82<-dWTID[,columns.USA]
{% endhighlight %}
