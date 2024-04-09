#!/bin/bash
dirname="$(ls ./convert)"
newdirname="$(ls ./convert)$(echo " Linux")"
nwpackage="$(ls ./nw)"
mkdir "$(echo "./convert/")$newdirname"
cd ./nw
tar -xzvf "$nwpackage"
rm "$nwpackage"
cd ..
nwpackage="$(ls ./nw)"
cp -r -v "$(echo "./nw/")$nwpackage$(echo "/.")" "$(echo "./convert/")$newdirname"
cp -r -v "$(echo "./convert/")$dirname$(echo "/www")" "$(echo "./convert/")$newdirname"
cp -v "$(echo "./convert/")$dirname$(echo "/package.json")" "$(echo "./convert/")$newdirname"
cp -v ./script.py "$(echo "./convert/")$newdirname"
cd "$(echo "./convert/")$newdirname"
python ./script.py
rm ./script.py
cd ..
cd ..
cp -r -f -v ./patch/. "$(echo "./convert/")$newdirname"
sed -i 's+<script type="text/javascript" src="js/rpg_core.js"></script>+<script type="text/javascript" src="js/libs/lzma-d-min.js"></script>\n        <script type="text/javascript" src="js/rpg_core.js"></script>+g' "$(echo "./convert/")$newdirname$(echo "/www/index.html")"
chmod +x "$(echo "./convert/")$newdirname$(echo "/nw")"
chmod +x "$(echo "./convert/")$newdirname$(echo "/game.sh")"
sed -i "$(echo 's+"name": ""+"name": "')$dirname$(echo '"+g')" "$(echo "./convert/")$newdirname$(echo "/package.json")"

