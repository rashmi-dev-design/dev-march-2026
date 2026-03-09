#!/bin/bash
# ──────────────────────────────────────────────
# Simple load test using Apache Bench (ab)
# Pre-installed on macOS and most Linux distros
# ──────────────────────────────────────────────
# Usage: ./loadtest.sh [base_url]
# Example: ./loadtest.sh http://localhost:9999/calculator

BASE_URL="${1:-http://localhost:9999/calculator}"
REQUESTS=500
CONCURRENCY=10

echo "============================================"
echo " Load Test — Calculator Web App"
echo " Target:      $BASE_URL"
echo " Requests:    $REQUESTS"
echo " Concurrency: $CONCURRENCY"
echo "============================================"
echo ""

echo "--- Ping Endpoint ---"
ab -n $REQUESTS -c $CONCURRENCY -q "$BASE_URL/api/calculator/ping"

echo "--- Add Endpoint ---"
ab -n $REQUESTS -c $CONCURRENCY -q "$BASE_URL/api/calculator/add?x=8&y=26"

echo "--- Div Endpoint ---"
ab -n $REQUESTS -c $CONCURRENCY -q "$BASE_URL/api/calculator/div?x=12&y=4"

echo "============================================"
echo " Load test complete!"
echo "============================================"
