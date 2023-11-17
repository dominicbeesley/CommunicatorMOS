XSLT=xsltproc

TARGETS=MOS.mod VDU.mod


all::$(addsuffix .html, $(TARGETS))

%.html:%.xml dis65.xslt
	$(XSLT) -o $@ $<
