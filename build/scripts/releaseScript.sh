#!/bin/bash
# Script to Upload Data to Salesforce 

ant -Dsf_sb.user=${SFUSER} -Dsf_sb.pass=${SFPASS} deployProd
deploysuccess=$?
if [ $deploysuccess -ne 0 ]; then
	exit 1;
fi

