#!/bin/bash
effects=("grow" "wave" "any" "fade")
random_index=$(( RANDOM % ${#effects[@]} )) 
img=$(sxiv -to ~/.dotfiles/wallpapers/ | awk -F'/' '{print $NF}')
swww img -t ${effects[random_index]} ~/.dotfiles/wallpapers/$img
wallust run ~/.dotfiles/wallpapers/$img
