#!/usr/bin/env python3
import json
import lzma
import os
from pathlib import PurePosixPath

real_path = []
# Set the directory you want to start from
rootDir = 'www'
base = PurePosixPath("/")
for dir_name, _, fileList in os.walk(rootDir):
    for file_name in fileList:
        real_path.append(base.joinpath(dir_name, file_name))

file_map={}
enc_file_map={}
for path in real_path:
    p = PurePosixPath(path)
    inputSuffix = p.suffix
    if(inputSuffix == ".webp"):
        inputSuffix = ".png"
    p_str = str(p.parent.joinpath(str(p.stem)+inputSuffix))
    p_str_lc = p_str.lower()
    if p_str_lc in file_map:
        print("Upper case/lower case collision with %s" % p_str)
        exit(1)
    else:
        if(p_str_lc != p_str):
            enc_file_map[p_str_lc]=p_str
            file_map[p_str_lc] = str(p)
        elif(p.suffix == ".webp"):
            file_map[p_str_lc] = str(p)
my_filters = [
    {"id": lzma.FILTER_LZMA1, "preset": 2}
]

with lzma.open("pathdata.xz", "w",format=lzma.FORMAT_ALONE, filters=my_filters) as f:
    f.write(bytes(json.dumps(file_map, separators=(',', ':')), "utf-8"))

with lzma.open("pathdata.enc.xz", "w",format=lzma.FORMAT_ALONE, filters=my_filters) as f:
    f.write(bytes(json.dumps(enc_file_map, separators=(',', ':')), "utf-8"))