FROM node:alpine as dependencies
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

FROM node:alpine as builder
WORKDIR /app
COPY . .
COPY --from=dependencies /app/node_modules ./node_modules
RUN rm -rf ./.next
RUN yarn build
RUN rm -rf ./.next/cache


FROM node:alpine as runner

# WORKDIR /app
RUN mkdir -p /home/node/app
WORKDIR /home/node/app

ENV PORT 3000
ENV NODE_ENV production
ENV APP_ENV production
ENV HOST_NAME 0.0.0.0
# COPY --from=builder --chown=node:node /app/.env ./
COPY --from=builder --chown=node:node /app/next.config.js /home/node/app/
COPY --from=builder --chown=node:node /app/public /home/node/app/public
COPY --from=builder --chown=node:node /app/.next /home/node/app/.next
COPY --from=builder --chown=node:node /app/server.js /home/node/app/
COPY --from=builder --chown=node:node /app/adminConfig.js /home/node/app
COPY --from=builder --chown=node:node /app/certificate /home/node/app/certificate
COPY --from=builder --chown=node:node /app/node_modules /home/node/app/node_modules
COPY --from=builder --chown=node:node /app/package.json /home/node/app/package.json

RUN mkdir /.yarn \
    && chmod -R 775 /.yarn \
    && chown -R node:0 /.yarn \
    && chmod -R 775 /home/node/app \
    && chown -R node:node /home/node/app
USER node

EXPOSE 3000
ENTRYPOINT [ "yarn", "start-ssl" ]

