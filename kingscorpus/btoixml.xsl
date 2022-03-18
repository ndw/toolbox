<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="xs"
                version="3.0">

<xsl:output method="text" encoding="utf-8" indent="no"/>
<xsl:strip-space elements="*"/>

<xsl:variable static="yes" name="debug" select="false()"/>

<xsl:mode on-no-match="shallow-copy"/>

<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="grammar">
  <xsl:text>{ </xsl:text>
  <!-- hack to get rid of trailing | -->
  <xsl:variable name="text">
    <xsl:apply-templates select="rule[1]" mode="input"/>
  </xsl:variable>
  <xsl:variable name="string" select="string($text)"/>
  <xsl:value-of select="substring($string, 1, string-length($string) - 1)"/>
  <xsl:text> }&#10;&#10;</xsl:text>

  <xsl:apply-templates select="rule"/>
  <xsl:text>-s: -'|' .&#10;&#10;</xsl:text>
</xsl:template>

<xsl:template match="rule">
  <xsl:sequence select="nonterminal"/>
  <xsl:text>: </xsl:text>
  <xsl:apply-templates select="rhs"/>
  <xsl:text> .&#10;</xsl:text>
</xsl:template>

<xsl:template match="rhs">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="choice">
  <xsl:for-each select="sequence">
    <xsl:if test="position() gt 1">; </xsl:if>
    <xsl:apply-templates select="."/>
  </xsl:for-each>
</xsl:template>

<xsl:template match="sequence">
  <xsl:for-each select="*">
    <xsl:if test="position() gt 1">, s, </xsl:if>
    <xsl:apply-templates select="."/>
  </xsl:for-each>
</xsl:template>

<xsl:template match="literal">
  <xsl:text>'</xsl:text>
  <xsl:sequence select="."/>
  <xsl:text>'</xsl:text>
</xsl:template>

<xsl:template match="token">
  <xsl:variable name="name" select="./string()"/>
  <xsl:choose>
    <xsl:when test="/grammar/tokens/token[. = $name]">
      <xsl:text>"</xsl:text>
      <xsl:sequence select="."/>
      <xsl:text>"</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:sequence select="."/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="epsilon">
  <xsl:text>{}</xsl:text>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="rule" mode="input">
  <xsl:choose>
    <xsl:when test="rhs/choice">
      <xsl:apply-templates select="rhs/choice[1]" mode="input"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="rhs/sequence[1]" mode="input"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="choice" mode="input">
  <xsl:choose>
    <xsl:when test="sequence/epsilon">
      <xsl:apply-templates select="(sequence/epsilon)[1]" mode="input"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="sequence[1]" mode="input"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="sequence" mode="input">
  <xsl:message use-when="$debug" select="'  s: ' || count(*)"/>
  <xsl:apply-templates mode="input"/>
</xsl:template>

<xsl:template match="literal" mode="input">
  <xsl:message use-when="$debug" select="ancestor::rule[1]/nonterminal || '  l: ' || ."/>
  <xsl:value-of select="string(.) || '|'"/>
</xsl:template>

<xsl:template match="epsilon" mode="input">
  <xsl:message use-when="$debug" select="ancestor::rule[1]/nonterminal || '  ε'"/>
  <xsl:value-of select="string(.) || '|'"/>
</xsl:template>

<xsl:template match="token" mode="input">
  <xsl:variable name="name" select="."/>
  <xsl:choose>
    <xsl:when test="/grammar/tokens/token[. = $name]">
      <xsl:message use-when="$debug" select="ancestor::rule[1]/nonterminal || '  t: ' || ."/>
      <xsl:value-of select="string(.) || '|'"/>
    </xsl:when>
    <xsl:otherwise>
  <xsl:message use-when="$debug" select="ancestor::rule[1]/nonterminal || '  T: ' || ."/>
      <xsl:apply-templates select="/grammar/rule[nonterminal = $name]" mode="input"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
