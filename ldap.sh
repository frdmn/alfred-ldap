#!/usr/bin/env bash

# Read LDAP configuration/settings
source ${HOME}/.alfred-ldap.conf

# Store arguments in variable and replace spaces with dots
QUERYSTRING="${*// /.}"

# Incremential helper
i=0

# Check for any arguments
if [[ -z ${QUERYSTRING} ]]; then
	echo "Error: no argument"
	exit 1
fi

# Run LDAP query and store raw response
LDAPRAW=$(ldapsearch -x -h "${LDAPHOSTNAME}" -p ${LDAPPORT} -D "${LDAPUSERNAME}" -w "${LDAPPASSWORD}" -b "${LDAPSEARCHBASE}" "(|(&(sAMAccountName=*${QUERYSTRING}*)(objectClass=organizationalPerson))(&(telephoneNumber=*${QUERYSTRING}*)(objectClass=organizationalPerson)))")
LDAPSTATUS=$?

if [[ $LDAPSTATUS -ne 0 ]]; then
	echo "<item uid=\"0\" arg=\"err503\"><title>Couldn't connect to LDAP server \""${LDAPHOSTNAME}:${LDAPPORT}\"".</title><subtitle></subtitle><icon>icon/user.png</icon></item>"
	echo "<item uid=\"1\" arg=\"err503\"><title>Please check the credentials in \"~/.alfred-ldap\"</title><subtitle></subtitle><icon>icon/user.png</icon></item>"
	exit 1
fi

# Count entries and responses
LDAPENTRIES=$(echo "${LDAPRAW}" | grep "numEntries" | sed 's/\# numEntries: //g')
LDAPRESPONSES=$(echo "${LDAPRAW}" | grep "numResponses" | sed 's/\# numResponses: //g')

# Check for empty entries
if [[ -z ${LDAPENTRIES} ]]; then
	echo "<item uid=\"0\" arg=\"err404\"><title>Couldn't find \"${QUERYSTRING}\"</title><subtitle></subtitle><icon>icon/user.png</icon></item>"
	exit 1
fi

# Set delimiter to new line
IFS="
"

# Add to arrays
PHONEARRAY=($(echo "${LDAPRAW}" | sed -n 's/^[ \t ]*telephoneNumber:[ \t ]*\(.*\)/\1/p'))
NAMEARRAY=($(echo "${LDAPRAW}" | sed -n 's/^[ \t ]*sAMAccountName:[ \t ]*\([A-Za-z ]*\)/\1/p' | sed 's/\./ /g'))

# For each array element, display name and phone number
for i in "${!PHONEARRAY[@]}"; do
	echo "<item uid=\"${i}\" arg=\"${PHONEARRAY[$i]/#$PHONEPREFIX/}\"><title>${NAMEARRAY[$i]} (${PHONEARRAY[$i]/#$PHONEPREFIX/})</title><subtitle></subtitle><icon>icon/user.png</icon></item>"
done
