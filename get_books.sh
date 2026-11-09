#!/bin/bash
set -euo pipefail

BUCKET="$1"
BOOK_DIR="$2"

mkdir -p "$BOOK_DIR"

aws s3 cp "s3://$BUCKET" "$BOOK_DIR" --recursive --exclude "*" --include "*.txt"

echo "File path" > book_list.txt

ABS_DIR=$(realpath "$BOOK_DIR")
find "$ABS_DIR" -name "*.txt" | sort >> book_list.txt

echo "Wrote $(tail -n +2 book_list.txt | wc -l) book files to book_list.txt"
