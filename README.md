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



