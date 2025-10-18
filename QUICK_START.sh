#!/bin/bash

# Recruitmentapk-website Quick Start Script
# Automated setup voor development environment

set -e  # Exit on any error

echo "🚀 Starting Recruitmentapk-website Quick Setup..."

# Kleur functies voor output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Check if Node.js is installed
print_status "Checking Node.js installation..."
if ! command -v node &> /dev/null; then
    print_error "Node.js is not installed. Please install Node.js 18+ first."
    echo "Visit: https://nodejs.org/"
    exit 1
fi

NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
if [ "$NODE_VERSION" -lt 18 ]; then
    print_error "Node.js version 18+ required. Current version: $(node -v)"
    exit 1
fi

print_success "Node.js $(node -v) detected"

# Check if npm is installed
print_status "Checking npm installation..."
if ! command -v npm &> /dev/null; then
    print_error "npm is not installed. Please install npm first."
    exit 1
fi

print_success "npm $(npm -v) detected"

# Install dependencies
print_status "Installing dependencies..."
npm install

print_success "Dependencies installed successfully"

# Create basic project structure
print_status "Setting up project structure..."

# Create directories
mkdir -p src/{components,pages,utils,hooks,types,styles,assets}
mkdir -p public
mkdir -p docs

# Create basic files if they don't exist
if [ ! -f "src/index.tsx" ]; then
    cat > src/index.tsx << 'EOF'
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'
import './styles/index.css'

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
)
EOF
fi

if [ ! -f "src/App.tsx" ]; then
    cat > src/App.tsx << 'EOF'
import React from 'react'
import './styles/App.css'

function App() {
  return (
    <div className="app">
      <header className="app-header">
        <h1>RecruitmentAPK</h1>
        <p>AI-Powered Recruitment Intelligence Platform</p>
      </header>
      <main>
        <div className="welcome-section">
          <h2>Welcome to RecruitmentAPK</h2>
          <p>Transform your recruitment process with intelligent assessments.</p>
        </div>
      </main>
    </div>
  )
}

export default App
EOF
fi

if [ ! -f "src/styles/index.css" ]; then
    cat > src/styles/index.css << 'EOF'
/* Global Styles */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', sans-serif;
  line-height: 1.6;
  color: #333;
  background-color: #f5f5f5;
}

#root {
  width: 100%;
  min-height: 100vh;
}
EOF
fi

if [ ! -f "src/styles/App.css" ]; then
    cat > src/styles/App.css << 'EOF'
.app {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.app-header {
  background: linear-gradient(135deg, #FF6B35, #1E3A8A);
  color: white;
  padding: 2rem;
  text-align: center;
}

.app-header h1 {
  font-size: 3rem;
  margin-bottom: 0.5rem;
  font-weight: 700;
}

.app-header p {
  font-size: 1.2rem;
  opacity: 0.9;
}

main {
  flex: 1;
  padding: 2rem;
  max-width: 1200px;
  margin: 0 auto;
  width: 100%;
}

.welcome-section {
  background: white;
  padding: 3rem;
  border-radius: 12px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  text-align: center;
}

.welcome-section h2 {
  color: #FF6B35;
  margin-bottom: 1rem;
  font-size: 2.5rem;
}

.welcome-section p {
  font-size: 1.1rem;
  color: #666;
  max-width: 600px;
  margin: 0 auto;
}
EOF
fi

if [ ! -f "index.html" ]; then
    cat > index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/favicon.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="AI-Powered Recruitment Intelligence Platform" />
    <title>RecruitmentAPK - Intelligent Recruitment Assessments</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/index.tsx"></script>
  </body>
</html>
EOF
fi

if [ ! -f "vite.config.ts" ]; then
    cat > vite.config.ts << 'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
    host: true,
  },
  build: {
    outDir: 'dist',
    sourcemap: true,
  },
  resolve: {
    alias: {
      '@': '/src',
    },
  },
})
EOF
fi

if [ ! -f "tsconfig.json" ]; then
    cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    }
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
EOF
fi

if [ ! -f "tsconfig.node.json" ]; then
    cat > tsconfig.node.json << 'EOF'
{
  "compilerOptions": {
    "composite": true,
    "skipLibCheck": true,
    "module": "ESNext",
    "moduleResolution": "bundler",
    "allowSyntheticDefaultImports": true
  },
  "include": ["vite.config.ts"]
}
EOF
fi

# Create README if it doesn't exist
if [ ! -f "README.md" ]; then
    cat > README.md << 'EOF'
# RecruitmentAPK Website

AI-Powered Recruitment Intelligence Platform

## Quick Start

### Option A: Use Quick Start Script (Recommended)
```bash
./QUICK_START.sh
```

### Option B: Manual Setup
```bash
npm install
npm run dev
```

## Available Scripts

- `npm run dev` - Start development server
- `npm run build` - Build for production
- `npm run preview` - Preview production build
- `npm run lint` - Run ESLint
- `npm run type-check` - Run TypeScript type checking
- `npm run test` - Run tests

## Project Structure

```
src/
├── components/     # Reusable UI components
├── pages/         # Page components
├── utils/         # Utility functions
├── hooks/         # Custom React hooks
├── types/         # TypeScript type definitions
├── styles/        # CSS and styling
└── assets/        # Static assets
```

## Development

This project uses:
- React 18 with TypeScript
- Vite for build tooling
- ESLint for code quality
- Vitest for testing

## Deployment

```bash
npm run deploy
```

Built with ❤️ by Recruitin B.V.
EOF
fi

print_success "Project structure created"

# Run type check
print_status "Running type check..."
npm run type-check

print_success "Type check passed"

# Create .gitignore if it doesn't exist
if [ ! -f ".gitignore" ]; then
    cat > .gitignore << 'EOF'
# Dependencies
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Production build
dist/
build/

# Environment files
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# IDE files
.vscode/
.idea/
*.swp
*.swo
*~

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Logs
logs
*.log

# Runtime data
pids
*.pid
*.seed
*.pid.lock

# Coverage directory used by tools like istanbul
coverage/
*.lcov

# Cache
.cache/
.parcel-cache/

# Temporary folders
tmp/
temp/
EOF
fi

print_success ".gitignore created"

# Final success message
echo ""
echo "🎉 Setup completed successfully!"
echo ""
echo "Next steps:"
echo "1. cd recruitmentapk-website"
echo "2. npm run dev"
echo ""
echo "The development server will start at http://localhost:3000"
echo ""
print_success "Happy coding! 🚀"