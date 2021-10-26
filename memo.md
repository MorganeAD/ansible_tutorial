

Ansible server:
The machine where Ansible is installed and from which all tasks and playbooks will be ran

Module:
Basically, a module is a command or set of similar Ansible commands meant to be executed on the client-side

Task:
A task is a section that consists of a single procedure to be completed

Role:
A way of organizing tasks and related files to be later called in a playbook

Fact:
Information fetched from the client system from the global variables with the gather-facts operation

Inventory:
File containing data about the ansible client servers. Defined in later examples as hosts file

Play:
Execution of a playbook

Handler:
Task which is called only if a notifier is present

Notifier:
Section attributed to a task which calls a handler if the output is changed

Tag:
Name set to a task which can be used later on to issue just that specific task or group of tasks.

