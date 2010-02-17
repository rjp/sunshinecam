base=/Users/rjp/tmp/snowcam
cd $base

mkdir -p raw clean
if [ ! -d frames ]; then
	mkdir -p frames
	echo 0 > frames/.counter
fi
date=$(date +%Y%m%d%H%M%S)
jdate=$(date +%Y%m%d)
if [ ! -d frames/$jdate ]; then
	mkdir -p frames/$jdate
	echo 0 > frames/$jdate/.counter
fi
mkdir -p raw/$jdate clean/$jdate 
if /opt/local/bin/wget --timeout=15 -q -O raw/$jdate/$date.jpg http://10.0.0.9/Jpeg/CamImg.jpg ; then
	/opt/local/bin/convert -geometry 320x240 raw/$jdate/$date.jpg clean/$jdate/$date.jpg
	
	counter=$(cat frames/.counter)
	ln -s $base/clean/$jdate/$date.jpg $base/frames/$(printf %05d $counter).jpg
	counter=$((counter+1))
	echo $counter > frames/.counter
	
	counter=$(cat frames/$jdate/.counter)
	ln -s $base/clean/$jdate/$date.jpg $base/frames/$jdate/$(printf %05d $counter).jpg
	counter=$((counter+1))
	echo $counter > frames/$jdate/.counter
	
	file=clean/$jdate/$date.jpg
	ds=$(date -j -f %C%y%m%d%H%M%S $date +%s)
	dt=$(date -j -f %C%y%m%d%H%M%S $date +%Y-%m-%d.%H:%M)
	/bin/echo -n "$dt,$ds," >> clean/auto.csv
	convert -geometry 32x24 $file ppm:- | ppmhist -float -sort frequency - | awk '{a+=$4*$5;b+=$5}END{printf("%.3f\n",a/b)}' >> clean/auto.csv
fi
