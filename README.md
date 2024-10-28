# Setup and Access Documentation for GKE Node.js Application Monitoring

This documentation provides a detailed guide on setting up, deploying, and accessing a Node.js application on Google Kubernetes Engine (GKE), with monitoring enabled via Prometheus and Grafana.

## Overview

This project involves the deployment of a Node.js application that tracks the latest block height on the Polygon blockchain. The application is containerized with Docker, deployed to a GKE cluster, and configured for automated monitoring and visualization using Prometheus and Grafana.

## Prerequisites

- **Google Cloud Platform (GCP) Account**: Ensure access to a GCP account and $300 free credits.
- **PolygonScan API Key**: Register at polygonscan.com to obtain a free API key for accessing Polygon blockchain data.
- **GitHub Repository**: Required for CI/CD integration using GitHub Actions.

---

## Setup Process

### 1. GCP Project and Free Tier Setup

1. **Create a New GCP Project**: Log in to Google Cloud Console, create a new project, and enable billing to claim the free credits.
2. **API and Service Enablement**: Enable essential APIs, including Kubernetes Engine API, Container Registry API, and Compute Engine API.

### 2. GKE Cluster Setup with Terraform

1. **Provision VPC and GKE Cluster**: Using Terraform, set up a dedicated VPC, subnet, and GKE cluster to host the application. 

NOTE: The configuration required creating a IAM Service Account with necessary IAM roles and permissions as a pre-requisite to using Terraform to create the GCP VPC network and GKE cluster.

2. **Terraform Deployment**: 
A BASH script named as 'terraform_run.sh' is created to run Terraform commands to initialize and apply configurations, which create and configure the required infrastructure accordingly.
*** Replace -var-file=xyz.txt with your variables file and/or if you wish to use 'terraform.tfvars' instead then remove -var-file argument from the terrafor_run.sh script in line No. 40,49 and 55.

IMPORTANT:  Before the bash script is executed, please ensure that you have activated your connection with GCP. Alternatively, you use your service accounts key to connect to GCP via command like this one: 
        export GOOGLE_APPLICATION_CREDENTIALS=/path/to/your/key.json
Also, it is must to provide values to the following variables in the 'terraform.tfvars' file, for ex-: 
    credentials_path="/path/to/your/sa/key.json"
    project_id="argon-framing-xxxxxx-xx"
    region="asia-east2"

### 3. CI/CD Pipeline Configuration with GitHub Actions

There are two GitHub Actions workflows created to perform the following tasks:
1. workflow: 'docker-push-gcr.yml' => to automate docker container build and push to Google Container Registry (GCR).
2. workflow: 'deploy-to-gke.yml' => to deploy the app to GKE with Helm chart.


### 4. Monitoring Setup with Prometheus and Grafana
The GitHub Actions workflow: 'deploy-to-gke.yml' also deploys Prometheus and Grafana to the GKE cluster. Prometheus is configured to scrape metrics from the Node.js application, and Grafana is set up to visualize these metrics.

## Access Details

### Application Access

- **Application URL**: `http://35.241.77.216:8080/`
  
- **Metrics Endpoint**: `http://35.241.77.216:3000/metrics`


### Grafana Access

- **Grafana URL**: `http:/35.241.120.225:80`
  - Access Prometheus to view raw metrics and configure further custom monitoring rules if needed.



## Summary

This setup enables a fully automated deployment pipeline with monitoring for a Node.js application running on GKE. The configuration provides real-time metrics via Prometheus and visualization through Grafana, ensuring high observability and reliability of the application.
