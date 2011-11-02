<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" indent="yes" />
	<xsl:template match="/">
		<html>
			<head>
				<title>Test Report</title>
			</head>
			<body>
				<h1>Test Report</h1>
				<xsl:apply-templates />
				<xsl:call-template name="summary"/>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template name="summary">
		<div style="border: solid; border-width: 1px; margin-bottom: 30px;">
			<h2 style="margin: 0;">Summary</h2>
			<div><b>Passed Tests: </b><xsl:value-of select="count(//result/passed)"/></div>
			<div><b>Failed Tests: </b><xsl:value-of select="count(//result/failed)"/></div>
			<!-- 
			 -->
		</div>
	</xsl:template>

	<xsl:template match="testcase">
		<xsl:variable name="colorOfSuccess">
			<xsl:choose>
				<xsl:when test="result/passed">
					green
				</xsl:when>
				<xsl:when test="result/failed">
					red
				</xsl:when>
				<xsl:otherwise>
					white
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<div style="border: solid; border-width: 1px; margin-bottom: 30px;">
		<xsl:element name="h2">
		<xsl:attribute name="style">background-color: <xsl:value-of select="$colorOfSuccess"/>; margin: 0;</xsl:attribute>
			Test Case:
			<xsl:value-of select="description/p" />
		</xsl:element>
		<xsl:apply-templates select="steps" />
		<xsl:if test="result/failed">
			<xsl:apply-templates select="result/description"/>
		</xsl:if>
		</div>
	</xsl:template>

	<xsl:template match="steps">
		<div>
			<div style="background-color: gray; font-size: big;">Steps</div>
			<ol>
				<xsl:apply-templates />
			</ol>
		</div>
	</xsl:template>

	<xsl:template match="step">
		<li>
			<xsl:apply-templates select="p" />
		</li>
	</xsl:template>

	<xsl:template match="button">
		<span style="background-color: gray; border: solid; border-width: 1px; padding: 0px 5px 0px 5px">
			<xsl:apply-templates />
		</span>
	</xsl:template>
	
	<xsl:template match="menuitem">
		<span style="font-style: italic;"> '<xsl:apply-templates/>' </span>
	</xsl:template>
	
	<xsl:template match="description">
		<div>
			<div style="background-color: gray; font-size: big;">Findings</div>
			<div style="padding: 2px;">
				<xsl:apply-templates />
			</div>
		</div>
	</xsl:template>
	
</xsl:stylesheet>