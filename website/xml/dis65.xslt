<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8" indent="yes" />

	<xsl:template match="/">
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
		<html>
			<head>
				<title><xsl:value-of select="/*/@project-name" /></title>
				<link rel="stylesheet" type="text/css" href="dis65.css" />
  			<meta name="viewport" content="width=device-width, initial-scale=1" />
			</head>
			<body>

				<script
  				src="https://code.jquery.com/jquery-3.7.1.min.js"
  				integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
  				crossorigin="anonymous"></script>
  			<script src="dis65.js"></script>
			
				<span id="tooltipbind-opsymbol">
					<xsl:apply-templates select="dis65/lines" />
					<!--xsl:apply-templates select="dis65/symbols" /-->
				</span>			

				<div id="tool-symbol"></div>

			</body>
		</html>
	</xsl:template>

	<xsl:template match="line">
		<xsl:variable name="anch">
			<xsl:text>ADDR_</xsl:text>
			<xsl:call-template name="url-encode">
				<xsl:with-param name="str" select="@address" />
			</xsl:call-template>
		</xsl:variable>
		<span>
			<xsl:attribute name="class">
				<xsl:text>line </xsl:text>
				<xsl:value-of select="@type" />
			</xsl:attribute>
			<xsl:if test="@address">
				<a id="{$anch}"></a>
				<span class="address"><a href="#{$anch}"><xsl:value-of select="@address" /></a></span>
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
		<a class="op-symbol" href="#LBLLK-{@symbol}" title="{@value}" symbol-type="{@symbol-type}" symbol-source="{@symbol-source}">
			<xsl:apply-templates />
		</a>
	</xsl:template>

	<xsl:template match="*">
		<span class="{name()}">
			<xsl:apply-templates />
		</span>
	</xsl:template>

	<!-- simplified from https://stackoverflow.com/questions/2425516/xslt-version-1-url-encoding -->
 	<xsl:variable name="safe">!'()*-.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_abcdefghijklmnopqrstuvwxyz~</xsl:variable>
	<xsl:template name="url-encode">
		<xsl:param name="str" />
		<xsl:if test="$str">
		  <xsl:variable name="first-char" select="substring($str,1,1)"/>
      <xsl:choose>
        <xsl:when test="contains($safe,$first-char)">
          <xsl:value-of select="$first-char"/>
        </xsl:when>
        <xsl:otherwise>
        	<xsl:text>_</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="string-length($str) &gt; 1">
        <xsl:call-template name="url-encode">
          <xsl:with-param name="str" select="substring($str,2)"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:if>
  </xsl:template>



</xsl:stylesheet>