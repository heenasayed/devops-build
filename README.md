# React Application Deployment Using Docker, Jenkins and AWS

## About the Project

This project is about deploying a React application and automating the deployment process using DevOps tools. The main goal was to make the application easy to build, deploy, and update whenever new code is pushed to GitHub.

I used Docker to package the application, Jenkins to automate the build and deployment process, and an AWS EC2 instance to host the application. I also configured Gatus to monitor the application's availability.

## Tools and Technologies

* **AWS EC2** – To host the application and supporting services.
* **Git and GitHub** – To manage the source code and maintain separate development and production branches.
* **Docker** – To package the application into a container.
* **Docker Hub** – To store the Docker images.
* **Jenkins** – To automate the CI/CD pipelines.
* **GitHub Webhooks** – To trigger Jenkins jobs automatically when code changes are pushed.
* **Gatus** – To check whether the deployed application is responding successfully.
* **Bash scripting** – To simplify the image build and deployment process.

## How the Project Works

The application code is maintained in GitHub. When I push changes to the `dev` branch, the development pipeline in Jenkins is triggered automatically. Jenkins builds the Docker image and pushes it to the public Docker Hub repository.

When the development changes are merged into the `master` branch, the production pipeline builds and pushes the production image to a private Docker Hub repository and deploys the application on the EC2 instance.

The application is available on port 80, and Gatus checks its HTTP response to help me identify availability issues.

## Application and Project Links

* **GitHub repository:** https://github.com/heenasayed/devops-build
* **Deployed application:** http://13.221.191.232/
* **Gatus monitoring dashboard:** http://13.221.191.232:8081/
* **Development Docker image:** https://hub.docker.com/r/heenadocker5866/dev
* **Production Docker image:** https://hub.docker.com/r/heenadocker5866/prod

*Note: The production Docker Hub repository is private. Jenkins must have valid credentials to push images to it.*

## Docker Setup

I created a `Dockerfile` using Nginx to serve the built React application. The image includes the application files and exposes port 80.

To build the image locally:

+ bash
docker build -t devops-build:latest .

To run the application:

+ bash
docker run -d \
  --name react-app \
  -p 80:80 \
  devops-build:latest

The project also includes a `docker-compose.yml` file to make it easier to build and run the application.

## Bash Scripts

I added two scripts to simplify the process:

* **`build.sh`** – Builds the Docker image.
* **`deploy.sh`** – Starts the application container and checks whether the application responds successfully.

These scripts help avoid repeating the same Docker commands manually.

## Jenkins CI/CD Pipeline

Jenkins is configured to work with GitHub through webhooks, so new code changes can trigger the relevant pipeline automatically.

### Development pipeline

1. Checks out the code from the `dev` branch.
2. Builds the Docker image.
3. Pushes the image to `heenadocker5866/dev` on Docker Hub.

### Production pipeline

1. Checks out the code from the `master` branch.
2. Builds the production Docker image.
3. Pushes the image to `heenadocker5866/prod`.
4. Deploys the production container on the EC2 instance.
5. Checks that the application is responding over HTTP.

## AWS EC2 Deployment

The application runs on an AWS EC2 instance in a Docker container. Port 80 is used to access the website from a browser.

The security group should allow public HTTP traffic on port 80. SSH access should be limited to my own public IP address. Jenkins and the monitoring dashboard should also be protected by appropriate inbound rules.

## Application Monitoring

I configured Gatus to monitor the deployed application by checking its HTTP response every 60 seconds.

The health check expects an HTTP `200` response. If the application stops responding as expected, the dashboard can show the failed health check.

This setup provides a simple way to monitor application availability. External email or messaging alerts are not currently configured.

## Screenshots

The following screenshots are included with the project to show the configuration and results:

* Jenkins login and pipeline configuration
* Jenkins pipeline execution
* AWS EC2 instance and security group settings
* Docker Hub development and production repositories with image tags
* The deployed React application
* Gatus application health-check dashboard

## What I Learned

Working on this project gave me practical experience with Docker image creation, Git branching, Jenkins pipelines, GitHub webhooks, Docker Hub, and deploying an application on AWS EC2. I also learned how to add a basic health check so that application availability can be monitored after deployment.

Overall, this project helped me understand how the different DevOps tools work together to automate an application's build and deployment process.

