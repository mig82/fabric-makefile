SHELL = /usr/bin/env bash

F_CLI_V=9.2.0.0

#fabric_cmd=fabric
fabric_cmd=java -jar mfcli.jar

#############################################################################################
# IMPORTANT:
# Run 'make setup' before adding your user and password to this file
# and pushing it to SCM.
#############################################################################################

fabric_dir=fabric
fabric_proj=FooApp
# Note: Set these three as environment variables so that switching branches won't blank them.
# The 9 digit Fabric account ID —e.g.: 100000001
fabric_acct=100000001
# The developer's user for the Fabric Console —e.g.: jimi.hendrix@purple.com
fabric_user=user@foo.com
# The developer's password for the Fabric Console.
fabric_pssw=1234

# Get the Fabric JAR and avoid pushing your Fabric password to source control.
setup:
	curl -O https://plugins-updatesite-prod.s3.amazonaws.com/onpremise/mobilefabric/mobilefabricCLI/$(F_CLI_V)/mfcli.jar

clean:
	find . -name '*.zip' -delete

# Zip up the Fabric app for import/upload.
zip:
	cd $(fabric_dir)/$(fabric_proj) && zip --recurse-paths --display-bytes ../../$(fabric_proj).zip * --exclude \*.DS_Store \*thumbs.db \*.desktop.ini

show:
	printf "acct: %s\nuser: %s\npssw: %s\n" $(fabric_acct) $(fabric_user) $(fabric_pssw)

# Export/download the Fabric app from the Fabric Console and decompress it to the local file system.
export:
	rm -f $(fabric_proj).zip
	${fabric_cmd} export --account $(fabric_acct) --user $(fabric_user) --password $(fabric_pssw) --app $(fabric_proj) --file $(fabric_proj).zip
	rm -rf fabric/$(fabric_proj)
	mkdir -pv fabric/$(fabric_proj)
	unzip $(fabric_proj).zip -d fabric/$(fabric_proj)
	rm $(fabric_proj).zip

# Import/upload the already compressed Fabric app into the Fabric Console.
import: clean zip
	$(fabric_cmd) import --account $(fabric_acct) --user $(fabric_user) --password $(fabric_pssw) --file $(fabric_proj).zip
