alfred-ldap
==============

Alfred workflow to search for telephone numbers of coworkers through an Active Directory/LDAP directory.

![](http://up.frd.mn/eklpc.png)

## Usage

`tel Firstname [Lastname]`  

for example

`tel Jonas` or `tel Friedm`

#### Result (also sent to your clipboard)

`> Jonas Friedmann (869)`  

## Installation

1. Download the raw `alfred-ldap.alfredworkflow` file
1. Double click to execute and import that workflow into Alfred
1. Clone the repository to get access to the dotfile configuration (`.alfred-ldap.conf`):  
`git clone https://github.com/frdmn/alfred-ldap /tmp/alfred-ldap`
1. Copy the default config file out of this git repo into your $HOME:  
`cp /tmp/alfred-ldap/.alfred-ldap.conf ~/.alfred-ldap.conf`
1. Adjust the credentials to the LDAP server:  
`vi ~/.alfred-ldap.conf`
