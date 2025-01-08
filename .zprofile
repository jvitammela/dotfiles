## If we want to use regular .profile
#emulate sh
#. ~/.profile
#emulate zsh

# Generic aliases

# ------
# ------

export GPG_TTY=$(tty)
eval $(gpg-agent --daemon)

. ~/.zshrc

#echo "RSS feed status: $(newsboat -x reload && newsboat -r -x print-unread)"
CURRENTTIME=$(date +%s)
STATUSFILE=$HOME/.newsboat/refresh.status
if [[ $(expr $CURRENTTIME - $(date -r $STATUSFILE +%s)) -gt 43200 || ! -f $STATUSFILE ]]; then
  echo "Refreshing newsboat..."
  newsboat -x reload
  touch $STATUSFILE
else
  echo "Not refreshing newsboat."
fi
echo "RSS feed status: $(newsboat -r -x print-unread)"
