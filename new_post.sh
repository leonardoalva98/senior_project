#!/usr/bin/env bash
# Usage: ./new_post.sh my-new-post "My New Post Title" "Author Name"
# https://github.com/marimo-team/quarto-marimo

set -e

if [ "$#" -lt 3 ]; then
  echo "Usage: $0 slug \"Post Title\" \"Author Name\""
  exit 1
fi

SLUG="$1"
TITLE="$2"
AUTHOR="$3"
DATE=$(date +%Y-%m-%d)
POST_DIR="posts/${SLUG}"

mkdir -p "${POST_DIR}"

cat > "${POST_DIR}/index.qmd" <<EOF
---
title: "${TITLE}"
description: ""
author: "${AUTHOR}"
date: "${DATE}"
categories: []
draft: true
---


## Explore a marimo based post

This repository provides a framework for integrating
[`Quarto`](https://quarto.org) with [`marimo`](https://marimo.io),
enabling markdown documents to be executed in a `marimo` environment, and
reactive in page.

\`\`\`{python.marimo}
import marimo as mo
\`\`\`

\`\`\`{python.marimo}
slider = mo.ui.slider(start=1, stop=10)
slider
\`\`\`

\`\`\`{python.marimo}
#| echo: true
mo.md(f'''
  # Hello from marimo!{'!' * slider.value}

  This is a raw, reactive python cell.
  You can edit it, and the output will change on run.
''').callout("info")
\`\`\`

Write your post here.
EOF

echo "Created ${POST_DIR}/index.qmd"
