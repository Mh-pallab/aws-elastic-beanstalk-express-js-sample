# Use Node.js 16 as required by the assessment
FROM node:16

# Set the application directory
WORKDIR /app

# Copy package files first for better Docker layer caching
COPY package*.json ./

# Install production dependencies
RUN npm ci --omit=dev

# Copy application source
COPY app.js ./

# Application listens on port 8080
EXPOSE 8080

# Start the application
CMD ["npm", "start"]
