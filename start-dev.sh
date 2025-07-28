#!/bin/bash

echo "�� Starting Interview Coach Development Environment"

# Function to find available port
find_available_port() {
    local base_port=$1
    local port=$base_port
    
    while netstat -an | grep ":$port " > /dev/null 2>&1; do
        echo "   Port $port is in use, trying next..."
        port=$((port + 1))
    done
    
    echo "   Using port $port"
    echo $port
}

# Find available ports
echo "🔍 Checking port availability..."

BACKEND_PORT=$(find_available_port 8000)
FRONTEND_PORT=$(find_available_port 3000)
OLLAMA_PORT=$(find_available_port 11434)

echo "�� Port Configuration:"
echo "   Backend: $BACKEND_PORT"
echo "   Frontend: $FRONTEND_PORT"
echo "   Ollama: $OLLAMA_PORT"

# Create temporary environment file
cat > .env.temp << EOF
BACKEND_PORT=$BACKEND_PORT
FRONTEND_PORT=$FRONTEND_PORT
OLLAMA_PORT=$OLLAMA_PORT
BACKEND_URL=http://localhost:$BACKEND_PORT
FRONTEND_URL=http://localhost:$FRONTEND_PORT
OLLAMA_URL=http://localhost:$OLLAMA_PORT
EOF

# Start services
echo "🚀 Starting Docker services..."
docker-compose -f docker-compose.dev.yml --env-file .env.temp up --build

# Cleanup
rm -f .env.temp 