'use strict';
const os = require('os');
const path = require('path');
const alfy = require('alfy');
const dotenv = require('dotenv');
const SimpleLDAP = require('simple-ldap-search').default;

// Load config from ~/.alfred.ldap
dotenv.config({path: path.join(os.homedir(), '.alfred-ldap.conf')});

// Create config object to use in LDAP bind
const config = {
	url: 'ldap://' + process.env.LDAPHOSTNAME + ':389',
	dn: process.env.LDAPUSERNAME,
	password: process.env.LDAPPASSWORD,
	base: process.env.LDAPSEARCHBASE
};

/**
* Async main function to search through
* LDAP and return results
*/
async function main() {
	const ldap = new SimpleLDAP(config);

	// setup a filter and attributes for your LDAP query
	const filter = `(&(objectClass=organizationalPerson)(|(telephoneNumber=*${alfy.input}*)(sAMAccountName=*${alfy.input}*)))`;
	const attributes = ['givenName', 'sn', 'telephoneNumber', 'department'];

	// Search in LDAP and store results
	const searchResult = await ldap.search(filter, attributes);
	let alfyOutput;

	if (searchResult.length === 0) {
		alfyOutput = [{
			title: `Error: No search results for "${alfy.input}"`,
			icon: {
				path: alfy.icon.error
			}
		}];
	} else {
		alfyOutput = searchResult.map(result => ({
			title: `${result.givenName} ${result.sn} (${result.telephoneNumber})`
		}));
	}

	// Return output to Alfy
	alfy.output(alfyOutput);

	// Close LDAP connnection
	ldap.destroy();
}

// Run main function
main();
