#Base image (from docker hub) as runtime environment for the application and this case i'm using node:20 docker image
FROM node:20.13.1

# Define the base directory for container (when the container is running) in this case /usr/src/app
WORKDIR /usr/src/app

# use this when you aren't created package.json file
# RUN npm init -y 

# if you have package.json file then you can use this command
COPY ./package.json ./

# Install the dependencies
RUN npm install

# Copy the source code to the container
COPY ./index.js ./

# Expose the port on which the application is running in this case using 8000
EXPOSE 8000

# Command to run the application
CMD ["node", "index.js"]
# CMD ["npm", "start"] means that the application will be started using npm start command

# Next step is to build the docker image using the Dockerfile


# Explain the build command
# docker build -t <name image file> -f <directory dockerfile> <parth to run dockerfile>

# Example
# Open terminal and run this command if you aren't set the Dockerfile

# docker build -t node-server-test -f Dockerfile .

# in this case run command: docker build -t node-server-test . cause we've already set the Dockerfile successfully in the same directory run the command below in the terminal

# docker build -t node-server-test .

# After the build is successful, you can run the "docker images" command to see the list of images that have been created an run the image using the command below

# docker run node-server-test

# if you open the browser and type http://localhost:8000 you can't see anything error and do not kill the process in terminal cause the process is running in the background, you can stop the process using the command below for stop the process

# docker rm -f $(docker ps -a -q)

# and run "docker ps"  to see the list of running containers

# And this the right way to run the container node-server-test and see the result in the browser


# docker run -d -p 8000:8000 node-server-test

# -d is used to run the container in detached mode or in the background

# -p is used to map the port from the container to localhost

# 8000:8000 means that the application is running on port 8000 in the container and will be mapped to port 8000 on localhost and "node-server-test" is the name of the image that we want to run

# After running you cannot see "localhost:8000" in the terminal, use docker ps to see the list of running containers and you can see the container id and the port that is mapped to localhost and check logs at NAMES of the container
# In this case boring_golick is the name of the container. You can run "docker logs boring_golick" to see the logs of the container and you can see "Server is running on port 8000" in the logs

# After that i change the code in the index.js file and i want to update the container with the new code, and container name is changed from boring_golick to angry_mayer (cause docker randomize the container name)

# docker rm boring_golick -f to stop the container

#  ** in case your port is already used, you can change the port from 8000 to another port in the Dockerfile and rebuild the image and run the container again

#  ** docker run -d -p 8000:8000 --name my-container node-server-test  "--name" is used to give the container a name