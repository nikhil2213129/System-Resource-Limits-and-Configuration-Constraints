#!/bin/bash
NEW_LIMIT=65535
echo "Current open files limit:"
ulimit -n
ulimit -n $NEW_LIMIT
echo "New open files limit for current session:"
ulimit -n
if [ "$(ulimit -n)" -lt "$NEW_LIMIT" ]; then
  echo "Warning: Unable to set the desired limit for the current session."
else
  echo "Temporary limit updated successfully."
fi
LIMITS_CONF="/etc/security/limits.conf"
BACKUP_FILE="/etc/security/limits.conf.bak"
sudo cp $LIMITS_CONF $BACKUP_FILE
USERNAME=$(whoami)
sudo bash -c "echo '$USERNAME                soft    nofile          $NEW_LIMIT' >> $LIMITS_CONF"
sudo bash -c "echo '$USERNAME                hard    nofile          $NEW_LIMIT' >> $LIMITS_CONF"
echo "Updated $LIMITS_CONF for user $USERNAME with new open file limits."
echo "Please log out and log back in for changes to take effect system-wide."
