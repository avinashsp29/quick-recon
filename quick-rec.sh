#! /bin/bash

bold=`tput bold`
red=`tput setaf 1`
green=`tput setaf 2`
end=`tput sgr0`

read -p "Enter domain name : " domain
mkdir $domain
touch $domain/email.txt

emailgrab(){
echo -e "\n${bold}Collecting email IDs. This may take some time...${end}\n"
wget -qNr -l 1 "$domain" -O "$domain/$domain.txt" 
cat "$domain/$domain.txt" | grep -aoE "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" >> $domain/email.txt 
sort -u $domain/email.txt -o $domain/email.txt

if [[ $(cat $domain/email.txt | wc -l) == 0 ]]; then
	echo -e "${bold}${red}No email IDs found!${end}"
	rm $domain/email.txt
else
	cat $domain/email.txt
	echo -e "\n${bold}${green}Email IDs stored in $domain/email.txt${end}"
fi

rm $domain/$domain.txt
}

emailgrab

subdomain enumeration

#!/bin/bash
echo "finding subdomains...."
read -p "enter domain name:" domain
echo "Finding subdomains using assetfinder is time consuming please wait"
if [[ $domain != "" ]]; then
	#echo "collecting the subdomains using  assetfinder subs-only it may take some time please wait"
	touch subdomain_subs.txt subdomain_alive.txt subdomain_sorted.txt
	assetfinder --subs-only $domain > subdomain_subs.txt
	#echo "collecting the subdomains using  httprobe it may take some time please wait"
	cat subdomain_subs.txt | httprobe > subdomain_alive.txt
 	cat subdomain_alive.txt | sort -u > subdomain_sorted.txt
    cat subdomain_sorted.txt
 	count=$( wc -l < subdomain_sorted.txt )
 	echo "The total number of subdomains of $domain is $count"
 else
 	echo "please enter a domain name"
 fi
 echo "--------------------------------------------------------"
 rm subdomain_subs.txt
 rm subdomain_alive.txt

subdomain enumeration
