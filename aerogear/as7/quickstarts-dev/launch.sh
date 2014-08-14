#!/bin/bash

##############################################################
# Run Maven, deploy the war file and start the server
##############################################################

source $HOME/bin/quickstart-config.sh

launch() {
  if [ -d $HOME/$REPO_NAME ] && [ -f $CONFIG_FILE ];then
    echo "We are about to download the whole internet, be patient" | cowsay
    #cd $HOME/$REPO_NAME && mvn -s quickstart-settings.xml clean install -DskipTests=true
    mvn -s $HOME/$REPO_NAME/quickstart-settings.xml clean install -DskipTests=true
    cp $HOME/$REPO_NAME/server/contacts-mobile-picketlink-secured/target/jboss-contacts-mobile-picketlink-secured.war $JBOSS_HOME/standalone/deployments/
  fi
  $JBOSS_HOME/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0; /bin/bash
}

##############################################################
# Check if the argument was informed during the boot time
# otherwise just call bash
##############################################################
if [ ! -z "$CONFIG" ]; then
  cd $HOME/$REPO_NAME && git checkout origin/jboss-as7
  echo $CONFIG > $CONFIG_FILE
  launch
elif [ "$1" = "setup" ]; then
  config
else
  /bin/bash
fi

