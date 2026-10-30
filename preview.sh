#!/usr/bin/env bash
# Preview the digital garden locally
set -e
cd "$(dirname "$0")"
npx quartz build --serve