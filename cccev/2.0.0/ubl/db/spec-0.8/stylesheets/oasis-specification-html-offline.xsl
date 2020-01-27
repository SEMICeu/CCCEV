<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY logo  SYSTEM '../OASISLogo.png' NDATA dummy>
  <!ENTITY css   SYSTEM '../css/' NDATA dummy>
  <!NOTATION dummy SYSTEM "">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">
<!-- $Id: oasis-specification-html-offline.xsl,v 1.5 2018/12/02 23:20:31 admin Exp $ -->

<!-- Imported stylesheet is a customization of the DocBook XSL Stylesheets -->
<!-- from http://docs.oasis-open.org/templates/
     to have resource locations parameterized -->
<!-- See http://sourceforge.net/projects/docbook/ -->
<xsl:import href="oasis-specification-html.xsl"/>

<!-- ============================================================ -->
<!-- Parameters -->

<xsl:param name="css.path">
  <xsl:for-each select="document('')">
    <xsl:value-of select="unparsed-entity-uri('css')"/>
  </xsl:for-each>
</xsl:param>

<xsl:param name="oasis.logo">
  <xsl:for-each select="document('')">
    <xsl:value-of select="unparsed-entity-uri('logo')"/>
  </xsl:for-each>
</xsl:param>

<xsl:param name="oasis-base" select="'no'"/>

</xsl:stylesheet>
