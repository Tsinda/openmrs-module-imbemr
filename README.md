openmrs-module-imbemr
===================================

Using the OpenMRS SDK to create a Rwanda development enviroment
---------------------------------------------------------------

1) Install the OpenMRS SDK as described here: https://wiki.openmrs.org/display/docs/OpenMRS+SDK#OpenMRSSDK-Installation
2) Clone this project
3) Run "mvn clean install" on this project
3) Make sure that the "properties" variables in the main IMB pom are all set the proper versions of modules you want to run
4) Run "mvn openmrs-sdk:setup" (from any directory)
    **Note** if the build fails at any time during this process because it is saying it can't find a module in the Maven repo, you may need
    to check out that module and install it locally ("mvn clean install")
    a) Pick the name of the server (this will determine the subdirectory off ~/openmrs/ where it created the information for this server--in my case, I used 'rwanda'
    b) For "Distribution" or "Platform" chose "Distribution"
    c) For distribution version chose "Other...."
    d) For the distribution, use this module "org.openmrs.module:imbemr:1.0-SNAPSHOT" (or whatever the current version of this module is)
    e) Choose port 1044 for debugging
    f) Chose "1) Mysql" (assuming you have mysql installed--the mysql-via-docker option may also work, but I haven't tried it)
    g) For the DB name, chose some temporary DB name (ie, jdbc:mysql://localhost:3306/openmrs_temp)
        I believe that the SDK will create a database with this name, so if you have an existing DB you want to use, *don't* 
        that name or the SDK will overwrite it--we will fix the DB name later
    h) Enter mysql user/password for a uesr that has rights to create databases, etc
    i) Chose the JAVA HOME you want to use        
    
5) Go to the directory where setup configured the new module (probably ~/openmrs/[server_name] and open "openmrs-server.properties"
    a) Change the property "connection_url" to reference your existing OpenMRS database
6) Run "mvn openmrs-sdk:run"   
7) Note that this currently (as of Nov 23th 2016) does *not* include the MOH billing module


Updating your Rwanda development environment when module versions change
------------------------------------------------------------------------

1) *From the base directory of this module*, run: ""
2) Then just restart the server via "mvn openmrs-sdk:run"


Other OpenMRS SDK tips and tricks
---------------------------------

You can use the OpenMRS SDK to "watch" modules (so that an openmrs-sdk:run automatically deploys any changes you make to those modules).  


For more details, read more about the SDK here:

https://wiki.openmrs.org/display/docs/OpenMRS+SDK#OpenMRSSDK-Installation