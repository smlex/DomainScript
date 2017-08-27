# Project Title

Domain Script for VestaCP + WHMCS (deploy tool)



### Requirement

```
VestaCP >= 0.9.8
WHMCS >=6.0
```

### Installing

You need copy /modules/servers/vesta/vesta.php from whmcs dir to  your  <WHMCS_PATH>/modules/servers

```
cd /home/user/web/billing-site.ltd/public_html/modules/server
mkdir vesta
wget https://raw.githubusercontent.com/smlex/DomainScript/master/modules/servers/vesta/vesta.php -O vesta.php
```

And change or replace vesta bin/v-add-web-domain

```
cd /usr/local/vesta/bin/
wget https://raw.githubusercontent.com/smlex/DomainScript/master/vestacp/bin/v-add-web-domain -O v-add-web-domain
```


### Run
Pls setup Module Settings in WHMCS Edit Product.
Your script must have function deploy()  

```
#!/bin/bash
deploy(){
cp /home/robots.txt $HOMEDIR/$user/web/$domain/public_html/robots.txt
chown -R $user:$user $HOMEDIR/$user/web/$domain
chmod 777 $HOMEDIR/$user/web/$domain/public_html/
}
```
