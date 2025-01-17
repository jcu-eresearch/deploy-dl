
ENVIRONMENT:=local
ENV_LIST:=local jcu qa production
HOSTS=

# make each envrionment a target which sets
# the ENVIRONMENT variable
$(ENV_LIST):
	$(eval ENVIRONMENT:=$@)

# make host targets to limit the applicable hosts
standalone:
	$(eval HOSTS=standalone)

echo:
	$(info using envrionment $(ENVIRONMENT))

# run ansible
#
# the patsubst will only add a -l option if any hosts have been declared. Otherwise Ansible will run the play for every host declared in the inventory.
deploy:
	ansible-playbook playbook.yml -i inventory/$(ENVIRONMENT) --ask-vault-pass $(patsubst %,-l %,$(HOSTS)) $(EXTRA)

reindex:
	ansible-playbook reindex-everything.yml -i inventory/$(ENVIRONMENT) --ask-vault-pass $(patsubst %,-l %,$(HOSTS)) $(EXTRA)


.PHONY: $(ENV_LIST) standalone echo deploy reindex
