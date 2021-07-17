#!/bin/zsh
# Scan entire network and produce a report
sudo nmap -sP "$1" | awk '/Nmap scan report for/{printf $5;}/MAC Address:/{print " => "$3;}' | sort
