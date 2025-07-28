#!/bin/bash

echo "🧪 Testing Docker Setup for Interview Coach"

# Function to check if a service is responding
check_service() {
    local url=$1
    local service_name=$2
    local max_attempts=30
    local attempt=1
    
    echo "⏳ Waiting for $service_name to be ready..."
    
    while [ $attempt -le $max_attempts ]; do
        if curl -f -s "$url" > /dev/null 2>&1; then
            echo "✅ $service_name is ready at $url"
            return 0
        fi
        
        echo "   Attempt $attempt/$max_attempts - $service_name not ready yet..."
        sleep 2
        attempt=$((attempt + 1))
    done
    
    echo "❌ $service_name failed to start after $max_attempts attempts"
    return 1
}

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker and try again."
    exit 1
fi

echo "✅ Docker is running"

# Check if docker-compose is available
if ! command -v docker-compose &> /dev/null; then
    echo "❌ docker-compose is not installed. Please install it and try again."
    exit 1
fi

echo "✅ docker-compose is available"

# Test production build
echo ""
echo "🚀 Testing Production Build..."
docker-compose up --build -d

# Wait for services to start
sleep 10

# Test backend health
if check_service "http://localhost:8000/health" "Backend API"; then
    echo "✅ Backend health check passed"
else
    echo "❌ Backend health check failed"
    docker-compose down
    exit 1
fi

# Test frontend
if check_service "http://localhost:3000" "Frontend"; then
    echo "✅ Frontend is accessible"
else
    echo "❌ Frontend is not accessible"
    docker-compose down
    exit 1
fi

# Test API documentation
if check_service "http://localhost:8000/docs" "API Documentation"; then
    echo "✅ API documentation is accessible"
else
    echo "❌ API documentation is not accessible"
fi

echo ""
echo "🎉 All tests passed! Your Docker setup is working correctly."
echo ""
echo "📋 Service URLs:"
echo "   Frontend: http://localhost:3000"
echo "   Backend API: http://localhost:8000"
echo "   API Docs: http://localhost:8000/docs"
echo "   Health Check: http://localhost:8000/health"
echo ""
echo "🛑 To stop the services, run: docker-compose down"

# Keep services running for manual testing
echo ""
echo "💡 Services are still running. You can test them manually or run 'docker-compose down' to stop them." 