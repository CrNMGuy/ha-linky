ARG BUILD_FROM
FROM $BUILD_FROM

LABEL org.opencontainers.image.source=https://github.com/CrNMGuy/ha-linky
LABEL org.opencontainers.image.description="HA Linky Add-on"
LABEL org.opencontainers.image.licenses=MIT

RUN apk add --no-cache nodejs npm

WORKDIR /linky150

# Install dependencies
COPY package.json .
COPY package-lock.json .
RUN npm ci --ignore-scripts

# Copy add-on code
COPY . .
RUN chmod a+x ./run.sh

# Transpile TypeScript
RUN npm run build

CMD [ "./run.sh" ]

