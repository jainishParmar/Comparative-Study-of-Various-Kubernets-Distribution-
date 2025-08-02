#!/bin/bash

# Number of iterations
ITERATIONS=5

# Configuration files (update as needed)
RESULT_DIR="kube-burner-results"
CONFIG="config.yaml"
NAMESPACE="pod-scheduling-40-test-0"

for i in $(seq 1 $ITERATIONS); do
  echo "👉 Running iteration $i..."

  # Run kube-burner
  kube-burner init -c "$CONFIG"

  # Create destination directory
  DEST_DIR="final_result/iteration_result_$i"
  mkdir -p "$DEST_DIR"

  # Move results
  mv ${RESULT_DIR}/* "$DEST_DIR/"

  echo "📁 Results for iteration $i saved to $DEST_DIR"

  # Delete the namespace to clean up resources
  echo "🧹 Deleting namespace $NAMESPACE..."
  kubectl delete ns "$NAMESPACE" --wait=true

  echo "✅ Iteration $i complete."
done

echo "🏁 All $ITERATIONS iterations completed successfully."
