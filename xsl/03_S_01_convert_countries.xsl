<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text"/>
	<xsl:template match="/">
		<xsl:for-each select="countries/element">
			INSERT INTO dbo.Countries2
			VALUES ( 
			'<xsl:value-of select="alpha3Code"/>',
			"<xsl:value-of select="name"/>", 
			"<xsl:value-of select="nativeName"/>", 
			'<xsl:value-of select="alpha2Code"/>', 
			
			<xsl:choose>
				<xsl:when test="area!= ''">"<xsl:value-of select="area"/>"</xsl:when>
				<xsl:otherwise>null</xsl:otherwise>
			</xsl:choose>,
			
			'<xsl:value-of select="population"/>',
			
			<xsl:choose>
				<xsl:when test="capital!= ''">"<xsl:value-of select="capital"/>"</xsl:when>
				<xsl:otherwise>null</xsl:otherwise>
			</xsl:choose>,
			
			'<xsl:value-of select="flag"/>',
			'<xsl:value-of select="location"/>',
			'<xsl:value-of select="region"/>',
		
			"<xsl:value-of select="timezones/element"/>"
			);
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>