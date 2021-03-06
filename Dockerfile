FROM ansibleplaybookbundle/apb-base

LABEL "com.redhat.apb.spec"=\
"dmVyc2lvbjogMS4wCm5hbWU6IHNzLWdsdXN0ZXItYXBiCmRlc2NyaXB0aW9uOiBDcmVhdGUgZ2x1\
c3RlciBzdG9yYWdlIHVzaW5nIHN0YXRlZnVsIHNldHMKYmluZGFibGU6IEZhbHNlCmFzeW5jOiBv\
cHRpb25hbAptZXRhZGF0YToKICBkaXNwbGF5TmFtZTogc3MtZ2x1c3RlciAoQVBCKQogIGRlcGVu\
ZGVuY2llczogW10KcGxhbnM6CiAgLSBuYW1lOiBkZWZhdWx0CiAgICBkZXNjcmlwdGlvbjogVGhp\
cyBkZWZhdWx0IHBsYW4gZGVwbG95cyBzcy1nbHVzdGVyLWFwYgogICAgZnJlZTogVHJ1ZQogICAg\
bWV0YWRhdGE6IHt9CiAgICBwYXJhbWV0ZXJzOiBbXQ=="

COPY playbooks /opt/apb/actions
COPY roles /opt/ansible/roles
RUN chmod -R g=u /opt/{ansible,apb}
USER apb
