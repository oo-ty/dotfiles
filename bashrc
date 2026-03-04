export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

export PYTHONWARNINGS="ignore"
alias s3='aws --no-verify-ssl s3'

. "$HOME/.cargo/env"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# opencode
export PATH=/home/toby/.opencode/bin:$PATH

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
