<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!-- Generate a key listing of the action types -->
  <xsl:key name="action-types" match="//events/event/action" use="@type"/>

  <!-- Generate a key listing of the reference types -->
  <xsl:key name="reference-types" match="//events/event/references/reference" use="@type"/>

  <!-- Build the main body -->
  <xsl:template match="/">
    <html>
      <head>
        <title>Daily Activity Log</title>
        <link href="http://fonts.googleapis.com/css?family=Fauna+One" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="events.css" />
        <script src="events.js"></script>
      </head>
      <body>
        <div class="header fixed at-top">What's happening ...</div>
          <div class="container update-block">
            <div class="container flex-column" style="flex-shrink: 1;">
              <label><small>Activity: </small></label>
              <input list="actions" />
            </div>
            <datalist id="actions">
              <!-- Generate list of actions based on the recorded ones -->
              <xsl:call-template name="action-list" />
            </datalist>
            <div class="container flex-column" style="flex-grow: 1;">
              <label><small>Description: </small></label>
              <input type="text" id="description" />
            </div>

            <div class="container flex-column" style="flex-shrink: 1; ">
              <input  type="button" onclick="addRef()" value="Add Ref" />
            </div>
            <div class="container flex-column" style="flex-shrink: 1;">
              <input  type="submit" value="Update" />
            </div>
          </div>
          <div class="container reference-block" id="references">
            <datalist id="types">
              <!-- Generate list of references based on the recorded ones -->
              <xsl:call-template name="reference-list" />
            </datalist>
          </div>        
          <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <!-- Create option list of the various actions -->
  <xsl:template name="action-list">
    <xsl:for-each select="//events/event/action[generate-id() = generate-id(key('action-types',@type)[1])]">
      <option>
        <xsl:attribute name="value">
          <xsl:value-of select="@type"/>
        </xsl:attribute>
      </option>
    </xsl:for-each>
  </xsl:template>

  <!-- Create option list of the various references -->
  <xsl:template name="reference-list">
    <xsl:for-each select="//events/event/references/reference[generate-id() = generate-id(key('reference-types',@type)[1])]">
      <option>
        <xsl:attribute name="value">
          <xsl:value-of select="@type"/>
        </xsl:attribute>
      </option>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="events">
    <ul>
      <xsl:apply-templates select="event"/>
    </ul>
  </xsl:template>

  <xsl:template match="event">
    <li class="event">
      <xsl:apply-templates select="action"/>
      <br/>
      <small>
        <xsl:value-of select="@date"/>
        <xsl:apply-templates select="references"/>
      </small>
    </li>
  </xsl:template>

  <xsl:template match="action">
    <span class="action-type"><xsl:value-of select="@type"/></span>
    <span class="event-title"><xsl:value-of select="."/></span>
  </xsl:template>

  <xsl:template match="references">
    <span class="references">
      (<xsl:apply-templates select="reference"/>)
    </span>
  </xsl:template>

  <xsl:template match="reference">
      <a target="_blank">
        <xsl:attribute name="href">
          <xsl:value-of select="@src"/>
        </xsl:attribute>
        <xsl:value-of select="@type"/>
    </a>
    <xsl:if test="position() != last()">, </xsl:if>
  </xsl:template>

</xsl:stylesheet>
