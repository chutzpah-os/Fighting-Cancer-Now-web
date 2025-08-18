#!/bin/bash

echo "🚀 Setting up Fighting Cancer Now development environment..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    exit 1
fi

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "❌ Python is not installed. Please install Python 3.11+ first."
    exit 1
fi

echo "✅ All prerequisites are installed"

# Copy environment file
if [ ! -f .env ]; then
    cp .env.example .env
    echo "📝 Created .env file from template"
    echo "⚠️  Please update the .env file with your configuration"
fi

# Setup frontend
echo "📦 Setting up frontend..."
cd src/frontend
if [ ! -f package.json ]; then
    npm init -y
    npm install react react-dom @mui/material @emotion/react @emotion/styled
    npm install -D @testing-library/react @testing-library/jest-dom jest
fi
cd ../..

# Setup backend
echo "🐍 Setting up backend..."
cd src/backend
if [ ! -f requirements.txt ]; then
    cat > requirements.txt << EOL
fastapi==0.104.1
uvicorn[standard]==0.24.0
pydantic==2.5.0
pymongo==4.6.0
python-jose[cryptography]==3.3.0
passlib[bcrypt]==1.7.4
python-multipart==0.0.6
EOL

    cat > requirements-dev.txt << EOL
-r requirements.txt
pytest==7.4.3
pytest-asyncio==0.21.1
httpx==0.25.2
pytest-cov==4.1.0
black==23.11.0
flake8==6.1.0
EOL
fi
cd ../..

echo "✅ Development environment setup complete!"
echo ""
echo "Next steps:"
echo "1. Update your .env file with the correct configuration"
echo "2. Run 'npm run dev' to start the development environment"
echo "3. Visit http://localhost:3000 to see the frontend"
echo "4. Visit http://localhost:8000/docs to see the API documentation"
