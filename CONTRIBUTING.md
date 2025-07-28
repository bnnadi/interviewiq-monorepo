# Contributing to Interview Coach

Thank you for your interest in contributing to the Interview Coach project! This document provides guidelines for contributing to both the backend and frontend components.

## Project Structure

This monorepo contains two main components:

- **interview-coach-service**: FastAPI backend with AI services
- **interview-coach-web**: React frontend with voice recording

## Development Setup

### Prerequisites

- Docker and Docker Compose
- Git
- Node.js (for local frontend development)
- Python 3.11+ (for local backend development)

### Quick Start

1. **Clone the monorepo**:
   ```bash
   git clone https://github.com/bnnadi/interview-coach-monorepo.git
   cd interview-coach-monorepo
   ```

2. **Run the setup script**:
   ```bash
   ./setup.sh
   ```

3. **Start development environment**:
   ```bash
   ./start-dev.sh
   ```

## Development Workflow

### Backend Development (interview-coach-service)

1. **Navigate to the backend directory**:
   ```bash
   cd interview-coach-service
   ```

2. **Install dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

3. **Run locally**:
   ```bash
   uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
   ```

4. **Run tests**:
   ```bash
   pytest
   ```

### Frontend Development (interview-coach-web)

1. **Navigate to the frontend directory**:
   ```bash
   cd interview-coach-web
   ```

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Run locally**:
   ```bash
   npm run dev
   ```

4. **Run tests**:
   ```bash
   npm test
   ```

## Docker Development

### Using Docker Compose

```bash
# Development mode with hot reloading
docker-compose -f docker-compose.dev.yml up --build

# Production mode
docker-compose up --build

# Stop services
docker-compose down
```

### Useful Commands

```bash
# View logs
docker-compose logs -f

# Rebuild specific service
docker-compose build backend
docker-compose build frontend

# Execute commands in containers
docker-compose exec backend python -c "print('Hello')"
docker-compose exec frontend npm run lint
```

## Code Style

### Backend (Python)

- Follow PEP 8 style guidelines
- Use type hints
- Write docstrings for functions and classes
- Use Black for code formatting
- Use isort for import sorting

### Frontend (React/JavaScript)

- Use ESLint and Prettier
- Follow React best practices
- Use functional components with hooks
- Write meaningful component and function names

## Testing

### Backend Testing

```bash
cd interview-coach-service
pytest
pytest --cov=app
```

### Frontend Testing

```bash
cd interview-coach-web
npm test
npm run test:coverage
```

## Pull Request Process

1. **Fork the repository**
2. **Create a feature branch**:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**
4. **Add tests** for new functionality
5. **Update documentation** if needed
6. **Commit your changes** with descriptive commit messages
7. **Push to your fork**
8. **Create a Pull Request**

### Commit Message Format

Use conventional commit format:

```
type(scope): description

[optional body]

[optional footer]
```

Examples:
- `feat(backend): add user authentication`
- `fix(frontend): resolve voice recording issue`
- `docs: update API documentation`

## Issues

When creating issues, please:

1. Use the appropriate issue template
2. Provide clear description of the problem
3. Include steps to reproduce
4. Add relevant logs or error messages
5. Specify the environment (OS, Docker version, etc.)

## Questions or Need Help?

- Open an issue for bugs or feature requests
- Check existing issues and pull requests
- Review the documentation in each sub-repository

Thank you for contributing! 🚀 