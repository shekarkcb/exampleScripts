<?php
/*
Name :	generatePassword.php
Desc :	Generate passwords using  urandom /tr / head
		THis is not pure php way. Just converting shell commands to php code so that this can be hosted
		on some webserver and people can poll this to generate some password for them.
		Replace 'noOfCharecters' variable with desired charecters.
Note: 	Not tested for any security issues.
By	:   @shekarkcb
*/
$noOfCharecters = 16;
$psd=`head -c500 /dev/urandom | tr -cd 'a-zA-Z0-9@_-' | head -c$noOfCharecters; echo`;
echo $psd;
?>
