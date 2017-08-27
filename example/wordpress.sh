#!/bin/bash
deploy(){
cnpass=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 13)
password=$(LC_CTYPE=C tr -dc A-Za-z0-9_\!\@\#\$\%\^\&\*\(\)-+= < /dev/urandom | head -c 12)
password=$cnpass
dbname=${domain//./}
dbname=`echo $dbname | cut -c1-4`
username=$user"_"$dbname
$BIN/v-add-database $user $dbname $dbname $cnpass mysql localhost

rm -rf $HOMEDIR/$user/web/$domain/public_html/*
WPATH=$HOMEDIR"/"$user"/web/"$domain"/public_html/"


WP_CLI="/usr/local/bin/wp --allow-root  --quiet --path="$WPATH
$WP_CLI core download
$WP_CLI core config --dbname=$username --dbuser=$username --dbpass=$cnpass
$WP_CLI db create
$WP_CLI core install --url="http://$domain/" --title="$domain" --admin_user="$user" --admin_password="$password" --admin_email="wp@example.com"
$WP_CLI plugin install drafts-scheduler --activate
$WP_CLI plugin install cybersyn --activate
$WP_CLI plugin install rss-post-importer --activate

cp /home/robots.txt $HOMEDIR/$user/web/$domain/public_html/robots.txt
chown -R $user:$user $HOMEDIR/$user/web/$domain
chmod 777 $HOMEDIR/$user/web/$domain/public_html/

log_history "Install wp. <a target="_black" href="http://$domain/wp-admin">$domain</a>  $user:$password db $username  $cnpass  "
}