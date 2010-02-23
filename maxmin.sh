awk 'length==33' auto.csv | awk -F, '{b=substr($1,0,10)} $3>m[b] {m[b]=$3} $3<n[b] || n[b]==0 {n[b]=$3} END{for(i in m){printf("%s,%s,%s\n",i,n[i],m[i])}}'  | sort -n
