# By choosing a small base image, we:
# - Reduce image size (speeding up build/transfer)
# - Reduce attack surface area
# - Prevent breaking due to an upstream update

From node:19.4-alpine as base


# Set MODE_ENV
#ENV NODE_ENV production

# Second, let's set the working directory (👁️)

# By default, the working directory would be the root path (/) but you should set it to something else based on the conventions of your specific language + framework.

# This will provide a dedicated place in the filesystem with your app



# Specify the working directory
WORKDIR /usr/src/app


# Third, COPY our package.json & package-lock.json files separate from our source code (🏎️)

# Docker images are cached at each layer (command). This change prevents every code change from invalidating the cache so we only need to reinstall the dependencies if we change one of them!

COPY package*.json ./

FROM base as dev 
# Install productin depencies

RUN --mount=type=cache.target=/usr/src/app/.npm \
    npm set cache /usr/src/app/app && \
    npm install

COPY . .

CMD ["npm", "run", "dev"]

# set MODE_ENV 
ENV NODE_ENV production

FROM base as production

# Copy remaining source code after installing dependencies
# Again, copy only the necessary files
# Fourth, use a non-root USER (🔒)
# If configured properly, containers provide some protection (via user namespaces) between root users inside a container, but setting to a non-root user provides another layer to our defense in depth security approach!
# Fifth, configure the app for production (🔒 + 🏎️)
# The NODE_ENV=production environment changes how certain utilities behave, increasing performance.
# Using npm ci instead of npm install ensures a reproduceable build
# --only production prevents installing needed dev dependencies
# # use non root user
# Use --chown on COPY to set file commission

RUN --mount=type=cache.target=/usr/src/app/.npm \
    npm set cache /usr/src/app/app && \
    npm ci --only=production

USER node
# Copy remaining source code After  installing depencies
# Again, copy the necassary

# Install only production dependencies


COPY  --chown=noce:node ./src/ .

COPY ./src/ .

# Sixth, use the EXPOSE instruction (👁️)

EXPOSE documents to users of the image which port the application expects to be listening on. You will still need to publish the port at runtime, but this makes it clear to end users what to expect!

EXPOSE 3000

CMD [ "node", "index.js"] dest