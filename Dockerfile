# Stage 1: Build the application
FROM node:14 as builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build

# Stage 2: Create the production image
FROM node:14-alpine
WORKDIR /app
COPY --from=builder /app/package.json /app/package-lock.json ./
RUN npm ci --only=production
COPY --from=builder /app/dist ./dist
CMD [ "npm", "start" ]
