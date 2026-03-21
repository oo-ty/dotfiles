# Environment setup (NVM, cargo, bun, opencode) is in ~/.profile
# which is sourced by ~/.bash_profile before this file.
# Only set them here as fallback for non-login interactive shells.
if [ -z "$__profile_sourced" ]; then
  . "$HOME/.local/bin/env"
  export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  . "$HOME/.cargo/env"
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
  export PATH="$HOME/.opencode/bin:$PATH"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

export PYTHONWARNINGS="ignore"
alias s3='aws --no-verify-ssl s3'

mmdc() {
  awk '/^```mermaid/{p=1; next} p && /^```/{exit} p' "$1" | xclip -selection clipboard
}

alias ll='ls -la'

o() {
  explorer.exe $(wslpath -w $1)
}

paste-img() {
  powershell.exe -NoProfile -Command "
  Add-Type -AssemblyName System.Windows.Forms;
  if ([System.Windows.Forms.Clipboard]::ContainsImage()) {
    \$img = [System.Windows.Forms.Clipboard]::GetImage();
    \$img.Save('fs_architecture.png', [System.Drawing.Imaging.ImageFormat]::Png);
    Write-Host 'Success: Saved to fs_architecture.png';
  } else {
    Write-Error 'No image found in Windows clipboard.';
  }
"
}

alias v=nvim

# Append to the history file, don't overwrite it
shopt -s histappend

# Save and reload history after every command
export PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"
