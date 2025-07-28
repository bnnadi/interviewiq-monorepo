# InterviewIQ

AI-powered interview coaching platform with intelligent feedback and analysis.

## Components
- **[interviewiq-service](https://github.com/bnnadi/interviewiq-service)**: FastAPI backend with AI services
- **[interviewiq-web](https://github.com/bnnadi/interviewiq-web)**: React frontend with voice recording

## 📦 Repository Structure

- **[interviewiq-service](https://github.com/bnnadi/interviewiq-service)**: FastAPI backend with AI services (Ollama + external APIs)
- **[interviewiq-web](https://github.com/bnnadi/interviewiq-web)**: React frontend with voice recording capabilities

## 🏗️ Project Structure

```
IC/
├── interviewiq-monorepo/     # This repository (orchestrates everything)
│   ├── README.md                 # This file
│   ├── setup.sh                  # One-command setup
│   ├── start-dev.sh              # Development startup with port detection
│   ├── test-docker.sh            # Docker testing utilities
│   ├── docker-compose.yml        # Production Docker setup
│   ├── docker-compose.dev.yml    # Development Docker setup
│   ├── package.json              # Monorepo scripts and metadata
│   ├── CONTRIBUTING.md           # Contribution guidelines
│   ├── LICENSE                   # MIT license
│   └── .env.example              # Environment variables template
├── interviewiq-service/       # FastAPI backend (separate repo)
└── interviewiq-web/          # React frontend (separate repo)
```

## 🚀 Quick Start

### Option 1: Automated Setup (Recommended)

```bash
# Clone this monorepo
git clone https://github.com/bnnadi/interviewiq-monorepo.git
cd interviewiq-monorepo

# Run the automated setup
./setup.sh

# Start development environment
./start-dev.sh
```

### Option 2: Manual Setup

```bash
# Clone this repository
git clone https://github.com/bnnadi/interviewiq-monorepo.git
cd interviewiq-monorepo

# Clone sub-repositories
git clone https://github.com/bnnadi/interviewiq-service.git ../interviewiq-service
git clone https://github.com/bnnadi/interviewiq-web.git ../interviewiq-web

# Copy environment template
cp .env.example .env

# Start all services
docker-compose -f docker-compose.dev.yml up --build
```

### Option 3: Individual Repositories

```bash
# Clone and run backend
git clone https://github.com/bnnadi/interviewiq-service.git
cd interviewiq-service
docker-compose -f docker-compose.dev.yml up --build

# Clone and run frontend (in another terminal)
git clone https://github.com/bnnadi/interviewiq-web.git
cd interviewiq-web
docker-compose -f docker-compose.dev.yml up --build
```

### Production Mode

To run the application in production mode:

```bash
# Build and start all services
docker-compose up --build

# Run in background
docker-compose up -d --build
```

### Development Mode

To run the application in development mode with hot reloading:

```bash
# Build and start all services with hot reloading
docker-compose -f docker-compose.dev.yml up --build

# Run in background
docker-compose -f docker-compose.dev.yml up -d --build
```

### Testing the Setup

To verify everything is working correctly:

```bash
# Run the test script
./test-docker.sh
```

## 🌐 Access Points

- **Frontend**: http://localhost:3001 (development) / http://localhost:3000 (production)
- **Backend API**: http://localhost:8000
- **API Documentation**: http://localhost:8000/docs
- **Health Check**: http://localhost:8000/health
- **Ollama**: http://localhost:11434

## 🔧 Services

### Backend (FastAPI)
- **Port**: 8000
- **Health Check**: Available at `/health`
- **API Docs**: Available at `/docs`
- **Hot Reload**: Enabled in development mode
- **AI Services**: Ollama (local) + OpenAI/Anthropic (optional)

### Frontend (React)
- **Port**: 3001 (dev) / 3000 (prod)
- **Build Tool**: Vite
- **Hot Reload**: Enabled in development mode
- **Voice Recording**: Built-in microphone support
- **API Integration**: Direct communication with backend

### Ollama (AI Service)
- **Port**: 11434
- **Local LLM**: Runs AI models locally
- **Health Check**: Available at `/api/tags`
- **Models**: Supports various open-source models

## 🛠️ Development Workflow

1. **Start Development Environment**:
   ```bash
   # From monorepo directory
   ./start-dev.sh
   
   # Or manually
   docker-compose -f docker-compose.dev.yml up --build
   ```

2. **Make Changes**: 
   - Backend changes in `../interviewiq-service/` will auto-reload
   - Frontend changes in `../interviewiq-web/` will auto-reload
   - Ollama service runs independently

3. **View Logs**:
   ```bash
   # All services
   docker-compose -f docker-compose.dev.yml logs -f
   
   # Specific service
   docker-compose -f docker-compose.dev.yml logs -f backend
   docker-compose -f docker-compose.dev.yml logs -f frontend
   docker-compose -f docker-compose.dev.yml logs -f ollama
   ```

4. **Stop Services**:
   ```bash
   docker-compose -f docker-compose.dev.yml down
   ```

5. **Test Setup**:
   ```bash
   ./test-docker.sh
   ```

## Production Deployment

1. **Build Production Images**:
   ```bash
   docker-compose up --build
   ```

2. **Run in Production**:
   ```bash
   docker-compose up -d
   ```

3. **Scale Services** (if needed):
   ```bash
   docker-compose up -d --scale backend=3
   ```

## Useful Commands

```bash
# View running containers
docker-compose ps

# View logs
docker-compose logs

# Stop all services
docker-compose down

# Remove all containers and volumes
docker-compose down -v

# Rebuild specific service
docker-compose build backend
docker-compose build frontend

# Execute commands in running containers
docker-compose exec backend python -c "print('Hello from backend')"
docker-compose exec frontend npm run lint
```

## Troubleshooting

### Port Conflicts
If ports 3000 or 8000 are already in use, modify the port mappings in `docker-compose.yml`:

```yaml
ports:
  - "3001:3000"  # Map host port 3001 to container port 3000
```

### Build Issues
If you encounter build issues:

1. **Clean Docker cache**:
   ```bash
   docker system prune -a
   ```

2. **Rebuild without cache**:
   ```bash
   docker-compose build --no-cache
   ```

### Volume Mount Issues
If hot reloading isn't working:

1. **Check volume mounts**:
   ```bash
   docker-compose exec backend ls -la /app
   ```

2. **Restart services**:
   ```bash
   docker-compose restart
   ```

## 🔧 Environment Variables

The application uses the following environment variables:

### Required
- `VITE_API_URL`: Frontend API URL (default: http://localhost:8000)
- `PYTHONPATH`: Python path for backend (set automatically)

### Optional AI Services
- `OPENAI_API_KEY`: OpenAI API key for external AI services
- `ANTHROPIC_API_KEY`: Anthropic API key for external AI services
- `OLLAMA_BASE_URL`: Ollama service URL (default: http://localhost:11434)

### Port Configuration
- `BACKEND_PORT`: Backend service port (default: 8000)
- `FRONTEND_PORT`: Frontend service port (default: 3001)
- `OLLAMA_PORT`: Ollama service port (default: 11434)

## 🌐 Network Configuration

All services are connected through a custom Docker network (`interviewiq-network`) for secure inter-service communication:

- **Backend ↔ Frontend**: Direct API communication
- **Backend ↔ Ollama**: AI model inference
- **External APIs**: Optional integration with OpenAI/Anthropic

## 📚 Additional Resources

- **[Backend Documentation](https://github.com/bnnadi/interviewiq-service)**: Detailed API documentation
- **[Frontend Documentation](https://github.com/bnnadi/interviewiq-web)**: Component library and usage
- **[Contributing Guidelines](CONTRIBUTING.md)**: How to contribute to the project
- **[License](LICENSE)**: MIT License

## 🆘 Support

If you encounter any issues:

1. Check the [troubleshooting section](#troubleshooting) below
2. Review the logs: `docker-compose -f docker-compose.dev.yml logs`
3. Open an issue in the appropriate repository
4. Check the [Contributing Guidelines](CONTRIBUTING.md) 