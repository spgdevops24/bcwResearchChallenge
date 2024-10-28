#!/bin/bash

# Attempt to initialize Terraform
echo "Attempting initial terraform init..."
terraform init
INIT_EXIT_CODE=$?

# If terraform init fails, proceed with checks and conditions
if [ $INIT_EXIT_CODE -ne 0 ]; then
    echo "Initial terraform init failed."

    # Check if a Terraform state file exists
    if terraform state list &>/dev/null; then
        echo "Error: Terraform state file detected. Please fix the issue before re-running."
        exit 1
    else
        echo "No Terraform state file found. Proceeding with renaming files and retrying..."

        # Rename .tf files to .tf.exclude
        mv backend.tf backend.tf.exclude
        mv vpc.tf vpc.tf.exclude
        mv gke.tf gke.tf.exclude

        # Retry terraform init
        echo "Retrying terraform init..."
        terraform init
        INIT_RETRY_EXIT_CODE=$?

        # Check if init succeeded on retry
        if [ $INIT_RETRY_EXIT_CODE -ne 0 ]; then
            echo "Retry of terraform init failed. Exiting."
            # Rename files back to original names before exiting
            mv backend.tf.exclude backend.tf
            mv vpc.tf.exclude vpc.tf
            mv gke.tf.exclude gke.tf
            exit 1
        else
            # Apply terraform if init succeeds on retry
            echo "Terraform init successful on retry. Running terraform apply..."
            terraform apply -var-file=../../varfile.tempo -auto-approve
            
            # Rename files back to original names after successful apply
            echo "Renaming .tf.exclude files back to original .tf names..."
            mv backend.tf.exclude backend.tf
            terraform init -migrate-state -force-copy

            mv vpc.tf.exclude vpc.tf
            mv gke.tf.exclude gke.tf
            terraform apply -var-file=../../varfile.tempo -auto-approve
            echo "SUCCESS: Terraform's very first attempt of init, apply Process completed."
        fi
    fi
else
    echo "Initial terraform init succeeded."
    terraform apply -var-file=../../varfile.tempo -auto-approve
    echo "SUCCESS: Terraform's init, apply Process completed."
fi
