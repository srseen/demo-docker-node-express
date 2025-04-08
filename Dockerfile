# ---------- Stage 1: Build dependencies ----------
FROM node:18-alpine as builder

WORKDIR /app

# copy only package files
COPY package*.json ./

# install dependencies
RUN npm install --production

# copy source code
COPY . .

# ---------- Stage 2: Final image ----------
FROM node:18-alpine

WORKDIR /app

# copy only built dependencies and app code from builder stage
COPY --from=builder /app /app

# expose port
EXPOSE 3000

# run the app
CMD ["node", "server.js"]
