# Udacity Project - Deploy a high-availability web app using CloudFormation

### Detailed Infrastructure Architecture

![alt text][architecture]

[architecture]: https://github.com/amanbedi23/udacity-cloud-devops/blob/master/HA%20Web%20App%20Architecture%20Diagram.png "Architecture Diagram"

### Steps to deploy

#### To deploy network resources - 
./awscf.sh UDHAProjectStackInfra infra.yml infra-params.json 

#### To deploy server resources - 
./awscf.sh UDHAProjectStackServers servers.yml servers-params.json 

Go to Outputs tab in the UDHAProjectStackServers stack in CloudFormation and you will find the DNS Host for the load balancer. Once you click that you should see the Udagram website
