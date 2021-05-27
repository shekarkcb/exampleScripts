<?php
/*
Name: dbCOnnectionCheck.php
Desc: Can be used in loadbalaner to figure out if the db connection is working/to do failover
	  OR may be a wrapper to see if db is connecting and post a status
	  Replace / edit statements accordingly !!!
Variables : 
	dbHostName - HostName / IP to connect to.
	dbName     - name of the database to connect to.
	userName   - Connection username.
	psd		   - Password for the connection.
By: @shekarkcb
*/
$dbHostName = "localhost";
$dbName = "dataBaseName";
$userName = "userName";
$psd = "Password";
$connection = mysql_connect($dbHostName, $userName, $psd);
if (!$connection){
	#die("Database Connection Failed" . mysql_error());
	echo "ERROR: Unable to connect to database !!!";
}
$select_db = mysql_select_db($dbName);
if (!$select_db){
	#die("Database Selection Failed" . mysql_error());
	echo "ERROR: Unable to connect to database !!!";
} else {
	echo "Success: connected to $dbName database !!!";
}
