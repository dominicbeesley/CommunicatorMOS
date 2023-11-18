XSLT=xsltproc

TARGETS=MOS.mod VDU.mod ViewData.mod


all::$(addsuffix .html, $(TARGETS))

%.html:%.xml dis65.xslt
	$(XSLT) -o $@ dis65.xslt $<
