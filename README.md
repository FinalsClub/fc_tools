Finals Club Tools & Script repo
================================

I. Introduction
--------------------------------------
The Finals Club Foundation has been providing free and
open education resources to students since 2008. As of
2011, FCF has made all services and tools free and open
to those who would like to re-deploy services offered by
FCF. This document shows how all services are deployed
in production and what is used for best practice in a
real world environment.


#### Current Structure ####

 + /scripts is where all scripts and utilities are kept. All
   scripts will be re-written in ruby for more abstractness.

 + /node-proxy is the old implementation of node-http-proxy
   that was used for routing traffic around the server.

 + /nginx_conf contains our nginx configuration files.


II. Basic Model
--------------------------------------

All services deployed by the Finals Club Foundation are
based upon the following stack:
	 ________________________________________________
	|                   |		       |	 |
	|	App.(n)     |	   App.(n)     |  etc..  |
	|                   |                  |         |
	 ------------------------------------------------
	|		      |				 |
	|	Node.Js       |     django / python      |
	| 		      |				 |
	 ------------------------------------------------
	|						 |
	|	    GNU/Linux (ubuntu / Debian )	 |
	| 						 |
	|________________________________________________|

Base: GNU/Linux:
--------------------------------------
All servers that run services for the Finals Club Foundation
start off with a generic GNU/Linux stack with:

* Ubuntu-Server 11.10+
* Mongodb-server
* Node.Js V.0.6.13+
* npm current
* Monit (optional, but recommended for basic monitoring).
* Dev. Tools: gcc, git, curl, make 
* Node Modules for each app. / service
* Nginx 1.18 Web Server
* Django-1.4
* PostgreSQL-1.9+

While the previous is an extensive list, it is not everything. See
what is included with ubuntu-server 11.10+ for other tools are
on our servers.

Middle Node.js:
--------------------------------------

Node.js is a new system for writing and deploying web applications
that are able to scale and update user information in real time. We
used Node.js because it is a new technology that is in its infancy, but
is becoming commonly used in the development of new web applications and tools. 
Etherpad-lite (Collaborative editor used in Finalsclub.org) is one of the many 
components in our many services that are written in Node.Js.


Middle Django / Python:
--------------------------------------
Karma Notes http://karmanotes.org is written using the django web framework
and uses uWSGI + Nginx to provide resources. Nginx was used instead of Apache
because of Apache's age and security shortcomings. 


Top: App.(n)...
--------------------------------------
Some of our apps / services are written for node.js
	
	* Finals Club.org
	* Node HTTP proxy (for routing traffic around the server).


III. Deployment:
--------------------------------------

a. Finals Club
----------------------

Deployment is fairly straight forward.

1. install git, curl, npm, node.js, mongodb-server, gcc, g++

2. git clone https://github.com/FinalsClub/FinalsClub.git
 Please put this in a common Dir. In production we use:

/var/www/$(Service)

If the server is shared with users you do not directly know, then
you should create a "system user" and home for your web services.
Creating a special user and home for services allows server admins.
to track the activity of services and can prevent damage to the system
if the App. / service is compromised.

3. git checkout devel # In FinalsClub src. Root.

4. git submodule init && git submodule update

5. Move "setup.sh" to another location and update to
reflect the configuration of your environment.

6. if everything is deployed and setup properly (including sys. user
 account), you should be able to run "sudo start&" as the user that
was created.


b. Karma Notes
----------------------

This part is still in the air! Check back in a day or so :)


If the previous documentation seems off or out of date, please email:

IV. Backup / Management
--------------------------------------

To backup our static files and DB(s), we use fairly generic scripts. In the future
we are looking to bup for clean incremental backups that will not take up so much space.

To use our backup.sh script, you need to define all missing env. vars and use the following structure:


Mongodb:
	backup.sh -m

Postgres:
	backup.sh -p


