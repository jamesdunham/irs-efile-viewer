<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:output method="html" indent="yes"/>
  <xsl:strip-space elements="*"/>  
  
  <xsl:include href="PopulateTemplate.xsl"/>
  <xsl:include href="AddHeader.xsl"/>
  <xsl:include href="CommonPathRef.xsl"/>
  <xsl:include href="AddOnTable.xsl"/>  
    
  <xsl:param name="FormData" select="$RtnDoc/CoopElectAllocateCreditPatrons"/>
  

  
  <xsl:template name="ShowCoop">

    <table class="styDepTbl">
      <thead class="styTableThead">
        <tr class="styDepTblHdr">
     
           <th class="styDepTblCell" style="width:145mm;" scope="col">Description</th>        
           <th class="styDepTblCell" style="width:42mm;" scope="col">Amount</th>        
        </tr>
      </thead>
        <tfoot/>
       <tbody>
        <xsl:for-each select="$FormData/CoopElectAllocateCrPatronsInfo">
          <tr>
            <xsl:attribute name="class">
            <xsl:choose>
               <xsl:when test="position() mod 2 = 1">styDepTblRow1</xsl:when>
               <xsl:otherwise>styDepTblRow2</xsl:otherwise>
            </xsl:choose>
            </xsl:attribute>
       
                    
            <td class="styDepTblCell" style="text-align:left;width:145mm;">
              <xsl:call-template name="PopulateText">
                <xsl:with-param name="TargetNode" select="ElectionDesc"/>
              </xsl:call-template>                  
            </td>
                        
            <td class="styDepTblCell" style="text-align:right;width:42mm;" nowrap="yes">
              <xsl:call-template name="PopulateAmount">
                <xsl:with-param name="TargetNode" select="Amt"/>
              </xsl:call-template>
            </td>        
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </xsl:template>
  
  
  <xsl:param name="depDocTitle">
    <xsl:call-template name="PopulateDisplayName"><xsl:with-param name="TargetNode" select="$FormData"/></xsl:call-template>  
  </xsl:param>
  <!-- Main template -->
  <xsl:template match="/">
    <html>
      <head>
          <title><xsl:value-of select="$depDocTitle"/></title>

         <!-- No Browser Caching -->
         <meta http-equiv="Pragma" content="no-cache"/>
         <meta http-equiv="Cache-Control" content="no-cache"/>
         <meta http-equiv="Expires" content="0"/>
         <!-- No Proxy Caching -->
         <meta http-equiv="Cache-Control" content="private"/>
         <!-- Define Character Set -->
         <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
         <meta name="Author" content="Ravi Venigalla"/>
         <meta name="Description" content="{$depDocTitle}"/> 
        
        <script language="JavaScript" src="{$ScriptPath}/FormDisplay.js" type="text/javascript"/>
        <xsl:call-template name="InitJS"/>
        
        <style type="text/css">
          <xsl:if test="not($Print) or $Print=''">
            <xsl:call-template name="AddOnStyle"/>    
          </xsl:if>
        </style>
      <xsl:call-template name="GlobalStylesDep"/>
</head>    
      <body class="styBodyClass">      
        <xsl:call-template name="DocumentHeaderDependency"/>          
        <div class="styDepTitleLine">
          <span class="styDepTitle" style="width:130mm">

            <xsl:value-of select="$depDocTitle"/>
          </span>
        </div>
        <!--Adding template for left over data  -->
        <xsl:call-template name="PopulateDepCommonLeftover"><xsl:with-param name="TargetNode" select="$FormData"/></xsl:call-template>                
        <xsl:call-template name="ShowCoop"/>          
        <br/>                      
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>