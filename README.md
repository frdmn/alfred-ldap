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

1. Make sure you've met all requirements
2. Install the workflow with `npm`:

    ```shell
    npm install -g alfred-ldap
    ```

3. Copy and adjust the default configuration file and make sure your LDAP credentials are set:

    ```shell
    cp ~/Library/Application\ Support/Alfred\ 3/Alfred.alfredpreferences/workflows/alfred-ldap/.alfred-ldap.conf ~/.alfred-ldap.conf
    vi ~/.alfred-ldap.conf
    ```


## Requirements

- Node / NPM

## Version

0.2.1

## License

[MIT](LICENSE)
