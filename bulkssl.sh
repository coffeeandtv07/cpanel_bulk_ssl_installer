#!/bin/bash

echo "Input the SSL Certificate code below and press CTRL+D:"
	cat > inputcert.crt
	(perl -MURI::Escape -ne 'print uri_escape($_);' inputcert.crt) > encrypted.crt
	echo -e "\n"
echo "Input the Private Key code below and press CTRL+D:"
	cat > inputkey.key
	(perl -MURI::Escape -ne 'print uri_escape($_);' inputkey.key) > encrypted.key
	echo -e "\n"

echo "Input the list of domains/subdomains (one domain per line) and press CTRL+D:"
    cat > domains.txt
    echo -e "\n" >> domains.txt
    echo -e "\n"

echo "Input the API Token and press RETURN (Enter):"
	read token
	echo -e " \n" 

crt=$(<encrypted.crt)
key=$(<encrypted.key)

cat ./domains.txt | while read domain
do
        echo -e "Attempting to install SSL on $domain"
	curl -kH"Authorization: cpanel $(whoami):${token}" "https://localhost:2083/execute/SSL/install_ssl?domain=${domain}&cert=${crt}&key=${key}"
        echo -e "\n"

done

rm encrypted.crt encrypted.key inputcert.crt inputkey.key domains.txt

echo "Reached the end of the file. Exiting."