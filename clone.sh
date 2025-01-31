#!/bin/sh

echo "Cloning repositories..."

CODE=$HOME/Code

git config --global user.email "chaitanya.a.90@gmail.com"
git config --global user.name "Chaitanya Anand"

# Personal
git clone https://github.com/decisive-moment/learning.git $CODE/learning