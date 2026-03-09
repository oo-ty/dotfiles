# Source .profile for login environment setup (PATH, env vars)
if [ -f ~/.profile ]; then
  . ~/.profile
fi

# Source .bashrc for interactive shell setup (aliases, functions, etc.)
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi
