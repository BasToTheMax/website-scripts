#!/bin/bash

source config

for i in *.org; do
	[ -f "$i" ] || break
	hname=$(echo "$i" | cut -f 1 -d '.')'.html'
  sname=`echo $hname | sed 's/.html$/.asc/'`
	#echo $i;
	#echo $hname;

	title=`cat "$i" | head | grep "#+TITLE:" | cut -b10-`

  echo "Generating $title ($i -> $hname & $sname)";

	cat > $hname <<EOF
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>$title - ${site_title}</title>
    <meta name="author" content="$author" />
    <link rel="stylesheet" type="text/css" href="$2style.css" />
    <meta name="viewport" content="width=device-width">
  </head>
  <body>
    <div id="content" class="post">
      <h1 class="title">$title</h1>
EOF

	pandoc $i >> $hname

  if [ ! $i = "index.org"   ] ; then

    cat >> $hname <<EOF
      
  </div>
    <div id="postamble">
      <p><a href="$2index.html">&larr; Home</a></p>
      <p class="small">Copyright $copyright $author (compiled: $(date +"%a %d %B %Y"))</p>
    </div>
  </body>
</html>
EOF

  else 

    cat >> $hname <<EOF
	
	</div>
    <div id="postamble">
      <p class="small">Copyright $copyright $author (compiled: $(date +"%a %d %B %Y"))</p>
    </div>
  </body>
</html>
EOF

  fi

done

