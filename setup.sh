#!/bin/bash

echo "🚀 Notion-Hugo Blog Setup"
echo "========================"

# Check if Hugo is installed
if ! command -v hugo &> /dev/null; then
    echo "❌ Hugo is not installed. Please install Hugo first:"
    echo "   macOS: brew install hugo"
    echo "   Linux: snap install hugo"
    echo "   Windows: choco install hugo"
    exit 1
fi

# Copy config file
if [ ! -f config.toml ]; then
    echo "📝 Creating config.toml from template..."
    cp config.toml.example config.toml
    echo "✅ Created config.toml - Please edit it with your settings"
fi
# Copy .env file
if [ ! -f .env ]; then
    echo "🔑 Creating .env file from template..."
    cp .env.example .env
    echo "✅ Created .env - Please add your Notion API credentials"
fi

# Create necessary directories
echo "📁 Creating directory structure..."
mkdir -p content/posts
mkdir -p static/images
mkdir -p static/videos
mkdir -p static/audio
mkdir -p themes

# Install Python dependencies
if command -v python3 &> /dev/null; then
    echo "🐍 Installing Python dependencies..."
    uv venv --python 3.10
    source .venv/bin/activate
    uv pip install -r requirements.txt
    echo "✅ Python dependencies installed"
else
    echo "⚠️  Python 3 not found. Please install Python dependencies manually."
fi

# Theme installation reminder
echo ""
echo "📚 Next steps:"
echo "1. Install a Hugo theme in the 'themes' directory"
echo "   Example: git submodule add https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod"
echo "2. Edit config.toml with your settings"
echo "3. Add your Notion credentials to .env"
echo "4. Run 'python scripts/notion_sync.py' to sync content"
echo "5. Run 'hugo server -D' to start the development server"
