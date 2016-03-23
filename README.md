alfred-ldap
==============

Alfred workflow to search for telephone numbers of coworkers through an Active Directory/LDAP directory.

![](http://up.frd.mn/eklpc.png)

![](http://up.frd.mn/ZIoKs.png)

## Usage

`ldap [first <last_name>]`  
`ldap [phone_number]`  

for example

`ldap Jonas` or `ldap Friedm` as well as `ldap 869`

#### Result (also sent to your clipboard)

`> Jonas Friedmann (869)`  

## Installation

1. Download the raw [`alfred-ldap.alfredworkflow`](https://github.com/frdmn/alfred-ldap/releases) file from GitHub releases
1. Double click to execute and import that workflow into Alfred
1. Copy the default config file `.alfred-ldap.conf` into your home folder:  
`curl -s https://raw.githubusercontent.com/frdmn/alfred-ldap/master/.alfred-ldap.conf -o ~/.alfred-ldap.conf`
1. Adjust the credentials to the LDAP server:  
`vi ~/.alfred-ldap.conf`

## Version

0.1.6

## License

[MIT](LICENSE)
