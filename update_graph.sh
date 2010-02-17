# everything lives under here
cd ~/tmp/snowcam/clean
# previousdata.csv holds values from before auto.csv existed
# length==33 avoids some corrupt lines due to my bad coding of snowcam.sh
# scur is a shell alias that copies the file to a webserver
cat previousdata.csv auto.csv | awk 'length==33' | sort -t, -k2 -n > sorted.csv && pl -maxrows 100000 -svg -o ~/usnoauto.svg scatplot.plt && scur ~/usnoauto.svg
