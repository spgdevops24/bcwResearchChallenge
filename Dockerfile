FROM node:18-alpine

# Create app directory
WORKDIR /usr/src/app

# Copy app source code
COPY package*.json app.js ./

# Accept the PolygonScan API key as a build argument
ARG POLYGONSCAN_API_KEY
ENV API_KEY=$POLYGONSCAN_API_KEY

# Install dependencies
COPY node_modules ./node_modules
#RUN npm install
 
# Expose the application on port 3000
EXPOSE 3000

# Run the application
CMD [ "node", "app.js" ]


#Finish remaining steos in order to successfully build Docker-image
