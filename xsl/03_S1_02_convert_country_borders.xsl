<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="text" encoding="UTF-8"/>
    <xsl:template match="/">
        USE [CountryInfo]
        INSERT INTO [dbo].[Country_Borders2] VALUES
        <xsl:for-each select="countries/element">
            <xsl:variable name="currentCountryAlpha3Code" select="alpha3Code"/>
            <xsl:variable name="isLastCountry" select="position() = last()"/>
            <xsl:for-each select="borders/element">
                ('<xsl:value-of select="$currentCountryAlpha3Code"/>',
                '<xsl:value-of select="."/>')<xsl:if test="not((position() = last()) and $isLastCountry)">,</xsl:if>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>