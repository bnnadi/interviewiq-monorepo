#!/bin/bash

echo "🚀 Setting up Interview Coach Monorepo"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Git is installed
if ! command -v git &> /dev/null; then
    print_error "Git is not installed. Please install Git and try again."
    exit 1
fi

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed. Please install Docker and try again."
    exit 1
fi

# Check if docker-compose is available
if ! command -v docker-compose &> /dev/null; then
    print_error "docker-compose is not installed. Please install it and try again."
    exit 1
fi

print_success "All required tools are installed"

# Clone sub-repositories if they don't exist
print_status "Checking sub-repositories..."

if [ ! -d "interview-coach-service" ]; then
    print_status "Cloning interview-coach-service..."
    git clone https://github.com/bnnadi/interview-coach-service.git
    if [ $? -eq 0 ]; then
        print_success "interview-coach-service cloned successfully"
    else
        print_error "Failed to clone interview-coach-service"
        exit 1
    fi
else
    print_warning "interview-coach-service already exists"
fi

if [ ! -d "interview-coach-web" ]; then
    print_status "Cloning interview-coach-web..."
    git clone https://github.com/bnnadi/interview-coach-web.git
    if [ $? -eq 0 ]; then
        print_success "interview-coach-web cloned successfully"
    else
        print_error "Failed to clone interview-coach-web"
        exit 1
    fi
else
    print_warning "interview-coach-web already exists"
fi

# Make scripts executable
print_status "Making scripts executable..."
chmod +x start-dev.sh
chmod +x test-docker.sh
chmod +x wait-for-it.sh

print_success "Scripts are now executable"

# Create environment file template
if [ ! -f ".env.example" ]; then
    print_status "Creating environment file template..."
    cat > .env.example << 'EOF'
# API Configuration
VITE_API_URL=http://localhost:8000

# Ollama Configuration
OLLAMA_BASE_URL=http://localhost:11434

# Optional: External AI Services
OPENAI_API_KEY=your_openai_api_key_here
ANTHROPIC_API_KEY=your_anthropic_api_key_here

# Port Configuration (if needed)
BACKEND_PORT=8000
FRONTEND_PORT=3001
OLLAMA_PORT=11434
EOF
    print_success "Environment file template created"
fi

print_success "Monorepo setup completed!"
echo ""
echo "📋 Next steps:"
echo "   1. Copy .env.example to .env and configure your environment variables"
echo "   2. Run './start-dev.sh' to start the development environment"
echo "   3. Run './test-docker.sh' to test the setup"
echo ""
echo "🌐 Service URLs (after starting):"
echo "   Frontend: http://localhost:3001"
echo "   Backend API: http://localhost:8000"
echo "   API Docs: http://localhost:8000/docs"
echo "   Ollama: http://localhost:11434" 