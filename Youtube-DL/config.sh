#!/bin/bash

mkdir -p ~/.config/youtube-dl/
cat > ~/.config/youtube-dl/config <<EOF
-o "[%(upload_date)s][%(id)s] %(title)s (by %(uploader)s).%(ext)s"
--external-downloader aria2c
--external-downloader-args "-c -j 3 -x 3 -s 3 -k 1M"
EOF

