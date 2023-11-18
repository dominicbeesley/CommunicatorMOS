<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8" indent="yes" />

	<xsl:template match="/">
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
		<html>
			<head>
				<title><xsl:value-of select="/*/@project-name" /></title>
				<link rel="stylesheet" type="text/css" href="dis65.css" />
			</head>
			<body>
			
			<xsl:apply-templates select="dis65/lines" />
			<!--xsl:apply-templates select="dis65/symbols" /-->

			</body>
		</html>
	</xsl:template>

	<xsl:template match="line">
		<span class="line">
		<xsl:if test="@address">
			<span class="address"><xsl:value-of select="@address" /></span>
		</xsl:if>
		<xsl:apply-templates />
		</span>
	</xsl:template>


	<xsl:template match="label">
		<a id="LBLLK-{@id}"></a>
		<span class="label" anno="{@anno}" id="LBL-{@id}">
			<xsl:apply-templates />
		</span>
	</xsl:template>

	<xsl:template match="opcode">
		<span class="opcode {@type}">
			<xsl:apply-templates />
		</span>
	</xsl:template>

	<xsl:template match="op-symbol">
		<a class="op-symbol" href="#LBLLK-{@symbol}" title="{@value}">
			<xsl:apply-templates />
		</a>
	</xsl:template>

	<xsl:template match="*">
		<span class="{name()}">
			<xsl:apply-templates />
		</span>
	</xsl:template>

</xsl:stylesheet>