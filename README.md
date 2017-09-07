# docker-bamboo-6.1-agent-android
Dockerfile Bamboo 6.1 Agent to build Android APK

<img width="200" src="https://www.docker.com/sites/default/files/Whale%20Logo332_5.png"/><img width="300" src="https://wac-cdn.atlassian.com/dam/jcr:4f99ae3f-808f-44f1-9647-2b7cb87bb0e6/bamboo_rgb_slate.png?cdnVersion=fr"/><img width="150" src="https://mir-s3-cdn-cf.behance.net/project_modules/disp/cc14679984981.560dd8d3aa5e4.png"/>

# Building
Clone the project to your directory
```bash
git clone https://github.com/Ismail-AlJubbah/docker-bamboo-6.1-agent-android
```
Then build the image
```bash
docker build -t jubba/docker-bamboo-6.1-agent-android:latest .
```

# Running
Run this command to run the container 
```bash
docker run -d -u=root -h bamboo-android-agent-1 --name bamboo-android-agent-1 -e BAMBOO_SERVER=http://YOUR-BAMBOO-SERVER-IP:PORT/agentServer/ -e BAMBOO_TOKEN=OPTIONAL_TOKEN  jubba/docker-bamboo-6.1-agent-android:latest
```
# Connect the Agent to Bamboo server
Follow the following steps to make sure your Bamboo agent can connect to Bamboo server:
1. Go to your Bamboo server settings -> System -> General Configureation: 
   Make sure Broker client URL is not pointing to localhost, it shoud point to your server ip or hostname
2. Make sure the ports 54663 443 80 in your Bamboo server are open, try to telnet it from the agent host:
   ```bash
   telnet BAMBOO-SERVER 54663
   telnet BAMBOO-SERVER 443
   telnet BAMBOO-SERVER 80
   ```
3. If you would like to forse agent to use authentication token: 
	Go to your Bamboo server settings -> Agents, click on Enable Authentication Token, then click on Install Remote Agent, copy the token after -t from the command
4. Go to your Bamboo server settings -> Agents -> Agent authentication: and aprrove the agent request.
5. Go to your Bamboo server settings -> Agents -> Online Remote Agent: and wait unit the agent register it self to the server, it may take 2 mins (you may need to refresh the page manually).
6. Kepp running the following command to check the output of the agent
    ```bash
    docker logs bamboo-base-agent
    ```

# Configure Build Plan:
1. Go to Configure Plan in your plan settings, in Task, click Add task, select Command, and enter the following values:
        a. Task description: Build APK
        b. Executable: gradelw

# Links
More information can be found on the following links:

1. [Original Java Repo by cogniteev](https://github.com/cogniteev/docker-oracle-java/tree/master/oracle-java8)
