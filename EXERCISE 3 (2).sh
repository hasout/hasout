#!/bin/bash

USERNAME="project"

echo "Current password expiry information for user $USERNAME:"
chage -l $USERNAME

echo "Seting password to expire in 365 days for user $USERNAME..."
chage -m 0 -M 365 -I 7 -W 7 -E 2024-08-12 $USERNAME

echo "Forcing user to change password at next login for user $USERNAME..."
chage -d 0 $USERNAME

echo "Disabling password expiration for user $USERNAME..."
chage -m 0 -M 99999 $USERNAME

echo "Updated password expiry information for user $USERNAME:"
chage -l $USERNAME