<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:uuid="http://www.uuid.org"
    xmlns:etf="http://www.interactive-instruments.de/etf/2.0"
    xmlns:ii="http://www.interactive-instruments.de"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    exclude-result-prefixes="uuid xs sch"
    version="2.0">
    <xsl:output method="xml" version="1.0"
    encoding="UTF-8" indent="yes"/>

    <xsl:include href="uuid.xsl"/>
    <xsl:param name="schemaURL">
        <xsl:message terminate="yes">The url of the XSD to use.</xsl:message>
        <xsl:value-of select="''"/>
    </xsl:param>
    <xsl:param name="translationTemplateId">
        <xsl:message terminate="yes">Set the Translation Template Bundle EID from the generated ETS file (look for the 'ref' attribute in the 'etf:translationTemplateBundle' element)</xsl:message>
        <xsl:value-of select="uuid:randomUUID(uuid:_get-node())"/>
    </xsl:param>
    <xsl:param name="dependencyIdXsd">
        <xsl:message terminate="yes">ExecutableTestSuite EIDs of the tests to use for XSD validation. Without the EID prefix.</xsl:message>
        <xsl:value-of select="''"/>
    </xsl:param>
    <xsl:param name="dependencyIdGeometry">
        <xsl:message terminate="yes">ExecutableTestSuite EIDs of the tests to use for Geometry validation. Without the EID prefix.</xsl:message>
        <xsl:value-of select="''"/>
    </xsl:param>
    <xsl:param name="etsId">
        <xsl:message terminate="no">ExecutableTestSuite is generated. Defaults to a new random UUID.</xsl:message>
        <xsl:value-of select="uuid:randomUUID(uuid:_get-node())"/>
    </xsl:param>
    <!-- <xsl:param name="tagId">
        <xsl:message terminate="yes">Set the Tag ID, for example for grouping the test. Defaults to a new random UUID.</xsl:message>
        <xsl:value-of select="uuid:randomUUID(uuid:_get-node())"/>
    </xsl:param> -->
    <xsl:param name="testObjectTypeId">
        <xsl:message terminate="no">Set the testObjectType, this is an ID for the type of resource in the test from a fixed list for ETF. NOTE: don't include EID in the value. Defaults to GML Feature collections: e1d4a306-7a78-4a3b-ae2d-cf5f0810853e. For other values, see http://docs.etf-validator.net/v2.0/Developer_manuals/Developing_Executable_Test_Suites.html#basex-test-object-types </xsl:message>
        <xsl:value-of select="'e1d4a306-7a78-4a3b-ae2d-cf5f0810853e'"/>
    </xsl:param>
<xsl:template match="/etf:Tag">
<xsl:variable name="tagId" select="@id"/>

<etf:ExecutableTestSuite xmlns="http://www.interactive-instruments.de/etf/2.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:etf="http://www.interactive-instruments.de/etf/2.0"
    id="EID{$etsId}"
    xsi:schemaLocation="http://www.interactive-instruments.de/etf/2.0 http://resources.etf-validator.net/schema/v2/service/service.xsd">
    <itemHash>bQ==</itemHash>
    <remoteResource>https://github.com/interactive-instruments/etf-ets-repository</remoteResource>
    <localPath>/auto</localPath>
    <!-- TODO: get the label from the Tag file -->
    <label>Run all dependencies</label>
    <description>Run XSD and Schematron tests for <xsl:value-of select="./etf:label"/></description>
    <reference>../example-bsxets.xq</reference>
    <version>2.0.0</version>
    <author>Geonovum</author>
    <creationDate>2018-01-19T16:06:53.937+02:00</creationDate>
    <lastEditor>Geonovum</lastEditor>
    <lastUpdateDate><xsl:value-of select="current-dateTime()"/></lastUpdateDate>
    <tags>
        <tag ref="{$tagId}"/>
    </tags>
    <testDriver ref="EID4dddc9e2-1b21-40b7-af70-6a2d156ad130"/>
    <translationTemplateBundle ref="EID{$translationTemplateId}"/>
    <ParameterList name="ETF Standard Parameters for XML test objects">
        <parameter name="files_to_test" required="true">
            <defaultValue>.*</defaultValue>
            <description ref="TR.filesToTest"/>
            <allowedValues>.*</allowedValues>
            <type>string</type>
        </parameter>
        <parameter name="tests_to_execute" required="false">
            <defaultValue>.*</defaultValue>
            <description ref="TR.testsToExecute"/>
            <allowedValues>.*</allowedValues>
            <type>string</type>
        </parameter>
    </ParameterList>
  <supportedTestObjectTypes><testObjectType ref="EID{$testObjectTypeId}"/></supportedTestObjectTypes>
    <dependencies>
            <executableTestSuite ref="EID{$dependencyIdXsd}"/>
            <executableTestSuite ref="EID{$dependencyIdGeometry}"/>
    </dependencies>
    <testModules>
        <xsl:variable name="testModuleEid" select="concat('EID', uuid:randomUUID(uuid:_get-node()))"/>
        <TestModule id="{$testModuleEid}">
            <label>IGNORE</label>
            <description>IGNORE</description>
            <parent ref="EID{$etsId}"/>
            <testCases>
                <xsl:variable name="testCaseEid" select="concat('EID', uuid:randomUUID(uuid:_get-node()))"/>
                <TestCase id="{$testCaseEid}">
                    <label>Tests</label>
                    <description>...</description>
                    <parent ref="{$testModuleEid}"/>
                    <testSteps>
                        <xsl:variable name="testStepEid" select="concat('EID', uuid:randomUUID(uuid:_get-node()))"/>
                        <TestStep id="{$testStepEid}">
                            <label>IGNORE</label>
                            <description>IGNORE</description>
                            <parent ref="{$testCaseEid}"/>
                            <statementForExecution>not applicable</statementForExecution>
                            <testItemType ref="EIDf483e8e8-06b9-4900-ab36-adad0d7f22f0"/>
                            <testAssertions>
                                <xsl:variable name="testAssertionEid" select="concat('EID', uuid:randomUUID(uuid:_get-node()))"/>
                                <TestAssertion id="{$testAssertionEid}">
                                    <label>Skipped</label>
                                    <description>...</description>
                                    <parent ref="{$testStepEid}"/>
                                    <expectedResult>NOT_APPLICABLE</expectedResult>
                                    <expression>'PASSED'</expression>
                                    <testItemType ref="EIDf0edc596-49d2-48d6-a1a1-1ac581dcde0a"/>
                                </TestAssertion>
                            </testAssertions>
                        </TestStep>
                    </testSteps>
                </TestCase>
            </testCases>
        </TestModule>
    </testModules>
</etf:ExecutableTestSuite>
</xsl:template>
</xsl:stylesheet>
