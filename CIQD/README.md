# Kubernetes, Kong and KeyCloak
# Install Kubernetes. Options for single node cluster are microK8s, minikube
# Deploy service to Kubernetes cluster
See https://kubernetes.io/docs/reference/kubectl/docker-cli-to-kubectl/      
See https://microk8s.io/docs/ for microk8s configuration
# Setup Kong and KeyCloak
# Build Kong Docker Image
sudo docker build -t kong:1.2-centos-oidc docker/kong/
# Spin up Kong DB
sudo docker-compose up -d kong-db
# Verify kong-db service is running
docker-compose ps
# Run migration
sudo docker-compose run --rm kong kong migrations bootstrap
# Spin up Kong
sudo docker-compose up -d kong
# Verify admin api and oidc plugin available. Should return true
curl -s http://localhost:8001 | jq .plugins.available_on_server.oidc
# Add service to Kong. See kong_addsvc.sh for example.
sh kong_addsvc.sh "service name" "service url"  
### Record the ID key from the previous command ###
# Add routes to Kong. See kong_addroute.sh for sample
sh kong_addroute.sh "service id" "path" 
# Verify service is accessible in Kong with "path" from previous command
curl -s http://localhost:8000/"path from kong route"
# Setup KeyCloak
# Bring up keycloak DB
sudo docker-compose up -d keycloak-db
# Spin up KeyCloak service
sudo docker-compose up -d keycloak
# Add Kong as client to KeyCloak. 
Open KeyCloak admin UI with url http://localhost:8180 
Click on the "Administrative Console" link               
On the next page, type in  username and password (admin:admin) and login.         
To add a client, click the "Clients" link in the sidebar, and then the "Create" button           
On the Add Client page  fill in the "Client ID" as "kong" and click the "Save" button.              
On the details page, set the "Access Type" to "Confidential", the "Root URL" to "http://localhost:8000" and the "Valid Redirect URIs" to "/"path from Kong route"/*" Click the "Save Button".                
After Save, a new tab, "Credentials" should appear on the details page. Click on that. Record the Client Secret.                
# Add a user to KeyCloak         
To add a user, click the "Users" tab on the left sidebar, then click the "Add user" button on the ride side of the window.               
On the next page, set the "Username" to "user" and set the "Email Verified" switch to "On". Then, click the "Save" button.               
Click on the "Credentials" tab, and enter in a password, confirmation, and make sure the "Temporary" switch is set to "off". Then, click the "Save" button.               
# Setup Kong to work with KeyCloak
# Configure Kong OIDC Plugin. See kong_oidcconfig.sh for sample
sh kong_oidcconfig.sh "host ip" "client secret id from KeyCloak"         
# Verify Kong-KeyCloak setup
Hit url http://localhost:8000/"path from kong route" 
Kong should be redirected to log in to Keycloak.                    
Log in as the user created in Keycloak earlier                    
Browser will be redirected to the original page requested.                     



    


