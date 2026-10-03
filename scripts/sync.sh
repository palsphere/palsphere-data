#!/usr/bin/env bash
# Pull the latest sphere-data/v1 dumps from the live site into data/.
set -euo pipefail

BASE="${PALSPHERE_DATA_URL:-https://palsphere.app/data/v1}"
DIR="$(cd "$(dirname "$0")/.." && pwd)/data"
mkdir -p "$DIR"

curl -fsSL "$BASE/manifest.json" -o "$DIR/manifest.json"
python3 - "$DIR/manifest.json" <<'PY' | while read -r path; do
import json, sys
m = json.load(open(sys.argv[1]))
for d in m["datasets"]:
    for p in d["formats"].values():
        print(p.rsplit("/", 1)[-1])
PY
  curl -fsSL "$BASE/$path" -o "$DIR/$path"
done
echo "Synced $(ls "$DIR" | wc -l) files from $BASE"
