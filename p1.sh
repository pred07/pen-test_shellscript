#! /bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

#Author:Brijith,Gautham,Kiran,Joyal,Stephen

#assetfinder|httprobe|xsstrike|gobuster
#nmap

echo -e "${RED}Welcome $USER! You are using $SHELL for script 
execution.${RESET}"

subenum()
{
	echo -e "${GREEN}Enter domain name:${RESET}"
	read dom
	nslookup $dom
	if ping -c 1 $dom &> /dev/null	#ping
	then
	  echo "Host is alive"
	else
	  echo "Target not found"
	fi
	echo ""
	
#subdomain enumeration	
	if [ -f subs.txt ]; then	#removing subs.txt if exist
    		rm -r subs.txt
	fi
	if [ -f alive.txt ]; then	#removing alive.txt if exist
    		rm -r alive.txt
	fi

	assetfinder -subs-only $dom >> subs.txt		#assetfinder
		cat subs.txt | httprobe > alive.txt     #httprobe
		sorted_fruits=$(sort alive.txt | uniq)  #sorting unique domains
		echo "$sorted_fruits" > domains.txt
		sed -i '/^http:/d' domains.txt          #removing domains starting with http:
		echo "Result is stored in domains.txt"
}
#network map features
kithu()
{
	tcpconnectscan()
	{
		echo "Enter domain name:"
		read nmapdom

		sudo nmap -sT $nmapdom -oN nmaptcp.txt > /dev/null
		echo "Result is stored in nmaptcp.txt !"
	}
	
	udpscan()
	{
		echo "Enter domain name:"
		read nmapdom

		sudo nmap -sU $nmapdom -oN nmapudp.txt > /dev/null
		echo "Result is stored in nmapudp.txt !"
	}

	ackprobe()
	{
		echo "Enter domain name:"
		read nmapdom

		sudo nmap -sA $nmapdom -oN nmapack.txt > /dev/null      
		echo "Result is stored in nmapack.txt !"
	}

	serviceandos()
	{
		echo "Enter domain name:"
		read nmapdom

		sudo nmap -sV -O $nmapdom -oN nmapsno.txt > /dev/null  
		echo "Result is stored in nmapsno.txt !"
	}

	stealthscan()
	{
		echo "Enter domain name:"
		read nmapdom

		sudo nmap -sS $nmapdom -oN nmapstealth.txt > /dev/null    
		echo "Result is stored in nmapstealth.txt !"
	}
	
	aggressivescan()
	{
		echo "Enter domain name:"
		read nmapdom

		sudo nmap -A $nmapdom -oN nmapaggr.txt > /dev/null       
		echo "Result is stored in nmapaggr.txt !"
	}

	echo -e "${YELLOW}Enter number corresponding to required operation !${RESET}"
	echo -e "${YELLOW}1. TCP connect scan !${RESET}"
	echo -e "${YELLOW}2. UDP scan !${RESET}"
	echo -e "${YELLOW}3. ACK probe !${RESET}"
	echo -e "${YELLOW}4. Service version & OS Detection !${RESET}"
	echo -e "${YELLOW}5. Stealth scan !${RESET}"
	echo -e "${YELLOW}6. Aggressive scan !${RESET}"

	read choice1

	case $choice1 in
	    1) tcpconnectscan ;;
	    2) udpscan ;;
	    3) ackprobe ;;
	    4) serviceandos ;;
	    5) stealthscan ;;
	    6) aggressivescan ;;
	    *) echo "Invalid choice" ;;
	esac
}
	
#bug bounty templates
bbtemplate()
{
	normal()
	{
		cat bbformat.txt
	}
	
	subdtakeover()
	{
		cat subdtakeover.txt
	}

	xss()
	{
		cat xss.txt
	}

	ssrf()
	{
		cat ssrf.txt
	}

	clickjacking()
	{
		cat clickjacking.txt
	}
	
	sqli ()
	{
		cat sqli.txt
	}

	echo -e "${YELLOW}Enter number corresponding to required operation ${RESET}"
	echo -e "${YELLOW}1. Reporting format ${RESET}"
	echo -e "${YELLOW}2. Subdomain Takeover report ${RESET}"
	echo -e "${YELLOW}3. Cross Site Scripting report ${RESET}"
	echo -e "${YELLOW}4. Server side Request Forgery report ${RESET}"
	echo -e "${YELLOW}5. Clickjacking report ${RESET}"
	echo -e "${YELLOW}6. SQL injection report ${RESET}"

	read choice1

	case $choice1 in
	    1) normal ;;
	    2) subdtakeover ;;
	    3) xss ;;
	    4) ssrf ;;
	    5) clickjacking ;;
	    6) sqli ;;
	    *) echo "Invalid choice" ;;
	esac	
}

xsstrike()
{
	echo -e "${BLUE}Enter domain name:${RESET}"
	read dom
	python3 /home/pr3dat0r47/XSStrike/xsstrike.py -u https://$dom >> xsstrike.txt
	echo "Report in xsstrike.txt"
}
#gobuster
gobuster()
{
	if [ -f gobuster_results.txt ]; then
		rm -r gobuster_results.txt
	fi
	echo -e "${BLUE}Enter URL !${RESET}"
	read -r url123
	echo -e "${BLUE}Enter wordlist location!${RESET}"
	read -r wordlist
	dirsearch -u "$url123" -w "$wordlist" #-o dirsearch.txt
	#echo -e "${BLUE}Output is stored in dirsearch.txt !${RESET}" 
}
#build
build()
{
	echo "build???"
}

echo -e "${GREEN}Enter number corresponding to required operation !${RESET}"
echo -e "${GREEN}1. Subdomain Enumeration !${RESET}"
echo -e "${GREEN}2. nmap Scanning !${RESET}"
echo -e "${GREEN}3. Cross Site Scripting !${RESET}"
echo -e "${GREEN}4. Bug bounty Templates !${RESET}"
echo -e "${GREEN}5. Find hidden directories !${RESET}"          
#echo -e "${GREEN}6. build !${RESET}"	###############

read choice

case $choice in
    1) subenum ;;
    2) kithu ;;
    3) xsstrike ;;
    4) bbtemplate ;;
    5) gobuster ;;
    6) build ;;
    *) echo "Invalid choice" ;;
esac
