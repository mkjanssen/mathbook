<?xml version="1.0" encoding="UTF-8" ?>

<!-- Customizations for HTML runs -->
<!DOCTYPE xsl:stylesheet [
    <!ENTITY % entities SYSTEM "../xsl/entities.ent">
    %entities;
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- Conveniences for classes of similar elements -->
  
<!-- Assumes current file is in mathbook/user, so it must be copied there -->
<xsl:import href="../xsl/pretext-html.xsl" />

<!-- List Chapters and Sections in sidebar Table of Contents -->
<!-- <xsl:param name="toc.level" select="'2'" /> -->

<!-- Examples and inline exercises are knowlized by default -->
<!-- We disable this behavior  -->
<xsl:param name="html.knowl.example" select="'no'" />
<xsl:param name="html.knowl.exercise.inline" select="'no'" />

<!-- Exercises may have hint, answer, and solution -->
<xsl:param name="exercise.divisional.statement" select="'yes'" />
<xsl:param name="exercise.divisional.hint" select="'yes'" />
<xsl:param name="exercise.divisional.answer" select="'no'" />
<xsl:param name="exercise.divisional.solution" select="'no'" />
<xsl:param name="exercise.inline.statement" select="'yes'" />
<xsl:param name="exercise.inline.hint" select="'yes'" />
<xsl:param name="exercise.inline.answer" select="'no'" />
<xsl:param name="exercise.inline.solution" select="'no'" />

<xsl:param name="project.statement" select="'yes'" />
<xsl:param name="project.hint" select="'yes'" />
<xsl:param name="project.answer" select="'no'" />
<xsl:param name="project.solution" select="'no'" />


<!-- Specify the color scheme to use for HTML -->
<xsl:param name="debug.colors" select="'blue_grey'" />

<!-- Kill all proofs in output -->
<xsl:template match="proof" />



<!-- create iframe embedded video                     -->
<!-- dimensions and autoplay as parameters            -->
<!-- Normally $preview is true, and not passed in     -->
<!-- 'false' is an override for standalone pages      -->
<!-- Templates, on a per-service basis, supply a URL, -->
<!-- and any attributes on the "iframe" element which -->
<!-- are not shared                                   -->
<!-- <xsl:template match="video[@youtube|@youtubeplaylist|@vimeo|@ee]" mode="media-embed">
    <xsl:param name="preview" select="'true'" />
    <xsl:param name="autoplay" select="'false'" />

    <xsl:variable name="hid">
        <xsl:apply-templates select="." mode="html-id" />
    </xsl:variable>
    <xsl:variable name="source-url">
        <xsl:apply-templates select="." mode="video-embed-url">
            <xsl:with-param name="autoplay" select="$autoplay" />
        </xsl:apply-templates>
    </xsl:variable>
    <xsl:variable name="source-url-autoplay-on">
        <xsl:apply-templates select="." mode="video-embed-url">
            <xsl:with-param name="autoplay">
                <xsl:choose> -->
                    <!-- the YouTube autoplay won't wait for the poster -->
                    <!-- to be withdrawn, so two clicks are needed,     -->
                    <!-- perhaps this is true of *all* services?        -->
                    <!-- <xsl:when test="@youtube|@youtubeplaylist">
                        <xsl:text>false</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>true</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:with-param>
        </xsl:apply-templates>
    </xsl:variable> -->
    <!-- allowfullscreen is an iframe parameter,   -->
    <!-- not a video-embedding parameter, but it's -->
    <!-- use enables the "full screen" button      -->
    <!-- http://w3c.github.io/test-results/html51/implementation-report.html -->
    <!-- <xsl:choose>
        <xsl:when test="($preview = 'true') and @preview and not(@preview = 'default')"> -->
            <!-- hide behind a preview image, code from post at -->
            <!-- https://stackoverflow.com/questions/7199624    -->
            <!-- <div onclick="this.nextElementSibling.style.display='block'; this.style.display='none'">
                <xsl:choose>
                    <xsl:when test="@preview = 'generic'">
                        <xsl:call-template name="generic-preview-svg"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <img src="{@preview}" class="video-poster"
                            alt="Video cover image"/>
                    </xsl:otherwise>
                </xsl:choose>
            </div>
            <div class="hidden-content"> -->
                <!-- Hidden content in here                   -->
                <!-- Turn autoplay on, else two clicks needed -->
                <!-- <iframe id="{$hid}" class="video" 
                    allowfullscreen="" src="{$source-url-autoplay-on}">
                    <xsl:apply-templates select="." mode="video-iframe-attributes">
                        <xsl:with-param name="autoplay" select="'true'"/>
                    </xsl:apply-templates>
                </iframe>
            </div>
        </xsl:when>
        <xsl:otherwise>
            <iframe id="{$hid}"  class="video"
                allowfullscreen="" src="{$source-url}">
                <xsl:apply-templates select="." mode="video-iframe-attributes">
                    <xsl:with-param name="autoplay" select="$autoplay"/>
                </xsl:apply-templates>
            </iframe>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template> -->

<!-- Special for YouTube API setup on Runestone  -->
<!-- Uses pixels (to match containing video-box) -->
<!-- so is exceptional and featureless           -->
<!-- TODO: are start/end attributes useful?      -->

<!-- <xsl:template match="video[@youtube]" mode="runestone-youtube-embed">
    <xsl:param name="width"/>
    <xsl:param name="height"/>

    <xsl:variable name="hid">
        <xsl:apply-templates select="." mode="html-id"/>
    </xsl:variable>

    <div id="{$hid}" data-component="youtube" class="align-left youtube-video"
         data-video-height="{$height}" data-video-width="{$width}"
         data-video-videoid="{@youtube}" data-video-divid="{$hid}"
         data-video-start="0" data-video-end="-1"/>
</xsl:template> -->

<!-- Creates a YouTube URL for embedding for use in an iframe -->
<!-- Autoplay option is conveyed in the URL query options     -->
<!-- Autoplay is for popout, otherwise not                    -->
<!-- <xsl:template match="video[@ee]" mode="video-embed-url">
    <xsl:param name="autoplay" select="'false'" />-->
    <!-- use &amp; separator for remaining options -->
    <!-- <xsl:text>&amp;modestbranding=1</xsl:text> -->
    <!-- kill related videos at end -->
    <!-- <xsl:text>&amp;rel=0</xsl:text> -->
    <!-- start and end times; for a playlist these are applied to first video -->
    <!-- <xsl:if test="@start">
        <xsl:text>&amp;start=</xsl:text>
        <xsl:value-of select="@start" />
    </xsl:if>
    <xsl:if test="@end">
        <xsl:text>&amp;end=</xsl:text>
        <xsl:value-of select="@end" />
    </xsl:if> -->
    <!-- default autoplay is 0, don't -->
    <!-- <xsl:if test="$autoplay = 'true'">
        <xsl:text>&amp;autoplay=1</xsl:text>
    </xsl:if>
</xsl:template> -->
<!-- <div style="position: relative; width: 100%; height: 0; padding-bottom: 75%;"><iframe style="position: absolute; width: 100%; height: 100%; border: 0;" src="https://expl.ai/" allowfullscreen="allowfullscreen" data-mce-fragment="1"></iframe></div> -->
<!-- Creates an EE URL for embedding, typically in an iframe  -->


<xsl:template match="video[@ee]" mode="media-embed">
    <xsl:param name="preview" select="'true'" />
    <xsl:param name="autoplay" select="'false'" />

    <xsl:variable name="hid">
        <xsl:apply-templates select="." mode="html-id" />
    </xsl:variable>
    <xsl:variable name="source-url">
        <xsl:apply-templates select="." mode="video-embed-url">
            <xsl:with-param name="autoplay" select="$autoplay" />
        </xsl:apply-templates>
    </xsl:variable>
    <xsl:variable name="source-url-autoplay-on">
        <xsl:apply-templates select="." mode="video-embed-url">
            <xsl:with-param name="autoplay">
                <xsl:choose>
                    <!-- the YouTube autoplay won't wait for the poster -->
                    <!-- to be withdrawn, so two clicks are needed,     -->
                    <!-- perhaps this is true of *all* services?        -->
                    <xsl:when test="@youtube|@youtubeplaylist">
                        <xsl:text>false</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>true</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:with-param>
        </xsl:apply-templates>
    </xsl:variable>
    <!-- allowfullscreen is an iframe parameter,   -->
    <!-- not a video-embedding parameter, but it's -->
    <!-- use enables the "full screen" button      -->
    <!-- http://w3c.github.io/test-results/html51/implementation-report.html -->
    <xsl:choose>
        <xsl:when test="($preview = 'true') and @preview and not(@preview = 'default')">
            <!-- hide behind a preview image, code from post at -->
            <!-- https://stackoverflow.com/questions/7199624    -->
            <div onclick="this.nextElementSibling.style.display='block'; this.style.display='none'">
                <xsl:choose>
                    <xsl:when test="@preview = 'generic'">
                        <xsl:call-template name="generic-preview-svg"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <img src="{@preview}" class="video-poster"
                            alt="Video cover image"/>
                    </xsl:otherwise>
                </xsl:choose>
            </div>
            <div class="hidden-content">
                <!-- Hidden content in here                   -->
                <!-- Turn autoplay on, else two clicks needed -->
                <iframe id="{$hid}" class="video" 
                    allowfullscreen="" src="{$source-url-autoplay-on}">
                    <xsl:apply-templates select="." mode="video-iframe-attributes">
                        <xsl:with-param name="autoplay" select="'true'"/>
                    </xsl:apply-templates>
                </iframe>
            </div>
        </xsl:when>
        <xsl:otherwise>
            <iframe id="{$hid}"  class="video"
                allowfullscreen="" src="{$source-url}">
                <xsl:apply-templates select="." mode="video-iframe-attributes">
                    <xsl:with-param name="autoplay" select="$autoplay"/>
                </xsl:apply-templates>
            </iframe>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="video[@ee]" mode="video-embed-url">
    <xsl:param name="autoplay" select="'false'" />
    <xsl:text>https://expl.ai/</xsl:text>
    <xsl:value-of select="@ee"/>
    <xsl:text>?mode=embed</xsl:text>
</xsl:template>

<!-- These are additional attributes on the "iframe" which seem specific to EE -->
<!-- N.B. the autoplay seems ineffective                                          -->
<xsl:template match="video[@ee]" mode="video-iframe-attributes">
    <xsl:param name="allowfullscreen" select="'allowfullscreen'" />
    <!-- <xsl:attribute name="frameborder">
        <xsl:text>0</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="allow">
        <xsl:if test="$autoplay = 'true'">
            <xsl:text>autoplay; </xsl:text>
        </xsl:if>
        <xsl:text>fullscreen</xsl:text>
    </xsl:attribute> -->
</xsl:template>



</xsl:stylesheet>
