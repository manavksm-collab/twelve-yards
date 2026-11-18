#!/usr/bin/env bash
# Builds dist/index.html from src/game.html + src/questions.txt.
# SITE_URL=https://you.github.io/repo ./build.sh  -> full image URL for link previews
set -euo pipefail
cd "$(dirname "$0")"
OG="og.png"; [ -n "${SITE_URL:-}" ] && OG="${SITE_URL%/}/og.png"
DESC="The daily penalty-shootout quiz. Every answer is a corner of the goal: get it right and you score. 25 seconds a kick, harder every round."
python3 - "$OG" "$DESC" "${SITE_URL:-}" <<'PY'
import sys
og,desc,url=sys.argv[1:4]
body=open('src/game.html').read().replace('/*QUESTIONS*/',open('src/questions.txt').read().strip())
body=body.replace('<meta name="claude:viewport-fit-sides" content="cover">\n','')
head=f'''<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">
<meta name="description" content="{desc}">
<meta name="theme-color" content="#08111f">
<meta property="og:type" content="website">
<meta property="og:title" content="Twelve Yards: the daily penalty quiz">
<meta property="og:description" content="{desc}">
<meta property="og:image" content="{og}">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
{f'<meta property="og:url" content="{url.rstrip("/")}/">' if url else ''}
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="Twelve Yards: the daily penalty quiz">
<meta name="twitter:description" content="{desc}">
<meta name="twitter:image" content="{og}">
<link rel="icon" href="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 64 64'%3E%3Crect width='64' height='64' rx='12' fill='%2308111f'/%3E%3Cpath d='M10 18h44v34h-4V22H14v30h-4z' fill='%23f3f6f0'/%3E%3Ccircle cx='38' cy='40' r='9' fill='%23ffb31a'/%3E%3C/svg%3E">
<style>:root{{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}}body{{margin:0}}[hidden]{{display:none!important}}</style>
'''
i=body.index('</style>')+len('</style>')
open('dist/index.html','w').write(head+body[:i]+'\n</head>\n<body>\n'+body[i:]+'\n</body>\n</html>\n')
PY
echo "built dist/index.html (og:image = $OG)"
