#proc settings
  encodenames: yes
  enable_suscripts: yes
  dateformat: yyyy-mm-dd

#set p = 0.30
#set w = 0.05
#set minp = $arith(@p-@w)
#set maxp = $arith(@p+@w)

#proc getdata
 pathname: sorted.csv
 select: @@3 < @maxp && @@3 > @minp
 delim: comma
showdata: yes
filter: 
##set TIME = $substring(@@1,12,15)
##set DATE = $substring(@@1,1,10)
##print @@1,@@2,@@3,@@TIME,@@DATE

#proc areadef
titledetails: size=6 align=C
title: @minp < avg.brightness < @maxp
rectangle: 1 1 8 4
xscaletype: time
yscaletype: date
  xrange: 05:00 20:00
  yautorange: datafield=1

 #proc xaxis
stubs: inc 1 hour
stubcull: yes
minorticinc: 15 minutes
minorticlen: 0 0.05
ticincrement: 1 hour
ticlen: 0.05 0
stubdetails: size=6

  #proc yaxis
  stubs: datematic
stubformat: Mmm dd
  stubcull: yes
automonths: no
autoyears: no
stubdetails: size=6

stubcull: yes
labeldistance: 0.55

#proc getdata
 pathname: usno.csv
 delim: comma

#proc lineplot
xfield: 2
yfield: 1
linedetails: width=0.2 color=rgb(0.4,1.0,0.4)
select: @@1 < @YMAX
legendlabel: USNO sunrise

#proc lineplot
xfield: 3
yfield: 1
linedetails: width=0.2 color=rgb(1.0,0.4,0.4)
select: @@1 < @YMAX
legendlabel: USNO sunset

#proc getdata
 pathname: sorted.csv
 select: @@3 < @maxp && @@3 > @minp
 delim: comma
filter: 
##set TIME = $substring(@@1,12,15)
##set DATE = $substring(@@1,1,10)
##print @@1,@@2,@@3,@@TIME,@@DATE

#proc scatterplot
xfield: 4
yfield: 5
symbol: shape=pixsquare color=blue radius=0.01 style=solid

#proc legend
format: down
location: 12:00(s) max-0.5
textdetails: size=6
