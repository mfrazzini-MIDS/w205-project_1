# w205-project_1
Project Team Members:
  Maura Cullen  ,  Bala Ganeshan  ,  Jonah Smith  ,  Mike Frazzini

## Overview:

The retail industry continues its prolonged crisis with the disruption the Internet and technology have brought over the past decade.  The surface area for delivering the customer value proposition as a retailer has dramatically thinned, shifted, and is more dynamic than ever.  In this crisis and transformational environment, advanced product expertise and authority is a winning strategy for a retailer.  Currently almost all expert product attribution and classification is manual, labor intensive, and time consuming.  This project prsents a solution to the problem in three key ways:

1.)  A working proof of concept implementation of an end-to-end solution for extracting, storing, retreiving, and analyzing retail e-commerce events and data to provide a basis for determing product that is in need of improved product information and attribution.  

2.)  A serving system providing faceted search and analysis to evaluate product information and attribution.  

3.)  Basic and advanced analytics to detect and predict improved product information and attribution.  

##Operating Instructions:   

Important:  You will not be able to access the files on S3 unless you have provided your Amazon Cannonical User ID - the 64 character user id found in AWS under "My Security Credentials" under the "Account Identifiers" section.  More information on this can be found here: http://docs.aws.amazon.com/general/latest/gr/acct-identifiers.html  Please email one of the project group members with your name and a request for access and your request will be addressed as soon as possible.  You will also need to set Access Keys in the Hive ETL scripts that process the data from the Amazon AWS S3 cloud.  Access keys are created and managed under "My Security Credentials" under the "Access Keys" section.  Very Important: Amazon AWS Access Keys should be kept secure and not shared.  For more information on Access Keys, see this link: http://docs.aws.amazon.com/general/latest/gr/aws-access-keys-best-practices.html   

1.)  Create and/or launch MIDS 205 AMI instance on instance type m3.Large or better
(Detailed Instructions in Lab 1 Here: https://github.com/UC-Berkeley-I-School/w205-summer-17-labs-exercises/blob/master/lab_1/Lab1-w205.md)

2.)  Setup block storage and Hadoop
(Detailed Instructions in Lab 2 Here: https://github.com/UC-Berkeley-I-School/w205-summer-17-labs-exercises/blob/master/lab_2/Lab2.md)

3.)  As root, setup Hive xml drivers.
#
```
$cd /usr/lib/hadoop-0.20-mapreduce/lib
$wget -O hivexmlserde-1.0.5.3.jar http://search.maven.org/remotecontentfilepath=com/ibm/spss/hive/serde2/xml/hivexmlserde/1.0.5.3/hivexmlserde-1.0.5.3.jar
$chmod 777 hivexmlserde-1.0.5.3.jar
```

4.)  As w205, define class path so aws classes can be utilizd.
#
```
$su w205,
$export HADOOP_CLASSPATH=/usr/lib/hadoop/client
```

5.)  As w205, setup third party data for user-agent validation and data cleansing.
#
```
-- #For user-agents.org data
$cd /home/w205/
$mkdir project_1
$cd project_1
$wget http://www.user-agents.org/allagents.xml
$hdfs dfs -mkdir /user/w205/project_1
$hdfs dfs -mkdir /user/w205/project_1/user-agents
$hdfs dfs -put "/home/w205/project_1/allagents.xml" /user/w205/project_1/user-agents/allagents.xml
```

6.)  Run Hive (as w205)
#
```
SET fs.s3.impl=org.apache.hadoop.fs.s3native.NativeS3FileSystem;
SET fs.s3.awsSecretAccessKey=INSERT SECRET ACCESS KEY FROM AWS ACCOUNT HERE;
SET fs.s3.awsAccessKeyId=INSERT ACCESS KEY FROM AWS ACCOUNT HERE;

add jar /usr/lib/hadoop-0.20-mapreduce/lib/hivexmlserde-1.0.5.3.jar;
```
Run the commands in the following Hive scripts:
run weblog_pipeline_hive.sql (https://github.com/mfrazzini-MIDS/w205-project_1/blob/master/weblog/weblog_pipeline_hive.sql)
run product_catalog_pipeline_hive.sql (https://github.com/mfrazzini-MIDS/w205-project_1/blob/master/product_catalog/product_catalog_pipeline_hive.sql)

7.)  Populate PostgreSQL RDBMS tables by following instructions here:
https://github.com/mfrazzini-MIDS/w205-project_1/blob/master/Hive_to_Postgresql.md

8.)  Elasticsearch serving layer setup and integration instructions here:
https://github.com/mfrazzini-MIDS/w205-project_1/blob/master/ElasticSearch/ES_Setup.sh  

9.)  Basic and Advanced analytic scripts done in R can be found here (input data can be pulled from RDBMS or direct csv export):
https://github.com/mfrazzini-MIDS/w205-project_1/tree/master/Analytics

## Outcome

*Data pipelines to support hourly performance statistics of product demand
**Visitor based Product Views / Product Cart Adds
**Optimizes focus and resource allocation for product information and attribution improvements weighted by demand and opportunity


*Statistical model for optimal product information and attributes
**Optimal number of product images = 6+
**Optimal number of product features = 6 to 10
**Statistical evidence that increased facets drive increased product views


*Framework for Machine Learning Advanced Analytics
**Product Information Score and Prediction of Improved Product Information and Attribution
