

paru -Sy discord-canary
sleep 3
killall discord-canary
sh -c "$(curl -sS https://raw.githubusercontent.com/Vendicated/VencordInstaller/main/install.sh)"
