<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text" encoding="UTF-8"/>
	<xsl:template match="/">
		USE [CountryInfo]
		INSERT INTO [dbo].[Countries2] VALUES
		<xsl:for-each select="countries/element">
			 (
			'<xsl:value-of select="alpha3Code"/>',
			N'<xsl:call-template name="escapeQuotes"><xsl:with-param name="txt" select="name"/></xsl:call-template>',
			N'<xsl:call-template name="escapeQuotes"><xsl:with-param name="txt" select="nativeName"/></xsl:call-template>',
			'<xsl:value-of select="alpha2Code"/>',
			'<xsl:call-template name="escapeQuotes"><xsl:with-param name="txt" select="area"/></xsl:call-template>',
			<xsl:value-of select="population"/>,
			<xsl:choose>
				<xsl:when test="capital!= ''">N'<xsl:call-template name="escapeQuotes"><xsl:with-param name="txt" select="capital"/></xsl:call-template>'</xsl:when>
				<xsl:otherwise>null</xsl:otherwise>
			</xsl:choose>,
			'<xsl:call-template name="escapeQuotes"><xsl:with-param name="txt" select="flag"/></xsl:call-template>',
			<xsl:choose>
				<xsl:when test="latlng!= ''">
					geography::Point(<xsl:value-of select="latlng/element[1]"/>, <xsl:value-of select="latlng/element[2]"/>, 4326)
				</xsl:when>
				<xsl:otherwise>null</xsl:otherwise>
			</xsl:choose>,
			'<xsl:call-template name="escapeQuotes"><xsl:with-param name="txt" select="region"/></xsl:call-template>',
			'<xsl:call-template name="escapeQuotes"><xsl:with-param name="txt" select="timezones/element"/></xsl:call-template>'
			)<xsl:if test="position() != last()">,</xsl:if>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="escapeQuotes">
		<xsl:param name="txt"/>
		<!-- MsSql escape -->
		<xsl:variable name="backSlashQuote">&#39;&#39;</xsl:variable>
		<xsl:variable name="singleQuote">&#39;</xsl:variable>

		<xsl:choose>
			<xsl:when test="string-length($txt) = 0">
				<!-- ... -->
			</xsl:when>

			<xsl:when test="contains($txt, $singleQuote)">
				<xsl:value-of disable-output-escaping="yes" select="concat(substring-before($txt, $singleQuote), $backSlashQuote)"/>

				<xsl:call-template name="escapeQuotes">
					<xsl:with-param name="txt" select="substring-after($txt, $singleQuote)"/>
				</xsl:call-template>
			</xsl:when>

			<xsl:otherwise>
				<xsl:variable name="escapedQuotesResult" select="$txt"/>
				<xsl:value-of disable-output-escaping="yes" select="translate($escapedQuotesResult, 'äëöü','&#228;&#235;&#246;&#252;')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>