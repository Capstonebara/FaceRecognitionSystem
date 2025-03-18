#!/bin/bash
echo "Building applications..."

# Build webapp
echo "Building webapp..."
yarn --cwd ../webapp build

# Build CMS
echo "Building CMS..."
yarn --cwd ../cms build