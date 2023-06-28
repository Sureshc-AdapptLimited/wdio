#!/bin/bash

# oldFiles=()
# for file in jsonReport/*; do
#     oldFiles+=("$file")
# done

sh merge_script.sh

BASE_URL=https://xray.cloud.getxray.app

token=$(curl -H "Content-Type: application/json" -X POST --data @"cloud_auth.json" "$BASE_URL/api/v1/authenticate"| tr -d '"')

curl -H "Content-Type: application/json" -X POST -H "Authorization: Bearer $token"  --data @"./cucumber_json_report.json" "$BASE_URL/api/v1/import/execution/cucumber"

# curl -H "Content-Type: multipart/form-data" -X POST -F info=@issueFields.json -F results=@.tmp/json/test-login-multiple-feature_16825078511997373.json -H "Authorization: Bearer $token" https://xray.cloud.getxray.app/api/v1/import/execution/cucumber/multipart

# curl -H "Content-Type: text/xml" -X POST -H "Authorization: Bearer $token"  --data @"results/todo-results.xml" https://xray.cloud.getxray.app/api/v2/import/execution/junit?projectKey=XR&testPlanKey=XR-135

# curl -H "Content-Type: application/json" -X POST -H "Authorization: Bearer $token"  --data @"${oldFiles[@]}" "$BASE_URL/api/v2/import/execution/cucumber"
