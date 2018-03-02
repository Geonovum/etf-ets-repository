<?xml version="1.0" encoding="UTF-8"?>
<!-- ########################################################################################## -->
<!--
    This stylesheet can be used to transform a Schematron file to an ETF version 2.0.x
    Executable Test Suite.

    Please note that test expressions may be adjusted manually.

    Created by Jon Herrmann, (c) 2017 interactive instruments GmbH. This file is licensed
    under the European Union Public Licence 1.2
-->
<!-- ########################################################################################## -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:uuid="http://www.uuid.org"
    xmlns:etf="http://www.interactive-instruments.de/etf/2.0"
    xmlns:ii="http://www.interactive-instruments.de"
    xmlns:sch="http://purl.oclc.org/dsdl/schematron"
    exclude-result-prefixes="uuid xs sch"
    version="2.0">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:include href="uuid.xsl"/>
    <!-- ####################################  Parameters  ######################################## -->
    <!-- Optional etsId -->
    <xsl:param name="etsId">
        <xsl:message terminate="no">Optional $etsId parameter not set. The parameter has to be set if an existing ETS is updated, in order to provide consistent IDs in ETF</xsl:message>
        <xsl:value-of select="uuid:randomUUID(.)"/>
    </xsl:param>
    <!-- Mandatory if etsId is set otherwise version 1.0.0 is set -->
    <xsl:param name="etsVersion">
        <xsl:if test="not($etsId)">
            <xsl:message terminate="yes">$etsId parameter set but not $etsVersion parameter: Set the new version of this ETS (1.0.0 -> 1.1.0)</xsl:message>
        </xsl:if>
        <xsl:value-of select="'1.0.0'"/>
    </xsl:param>
    <!-- Mandatory if etsId is set otherwise a random EID is generated -->
    <xsl:param name="translationTemplateId">
        <xsl:if test="not($etsId)">
            <xsl:message terminate="yes">$etsId parameter set but not $translationTemplateId parameter: Reference an exisiting Translation Template Bundle</xsl:message>
        </xsl:if>
        <xsl:value-of select="uuid:randomUUID(.)"/>
    </xsl:param>
    <!-- Optional tagId -->
    <xsl:param name="tagId"/>

    <!-- Optional Test Object Type. Default: GML feature collections,
        see http://docs.etf-validator.net/Developer_manuals/Developing_Executable_Test_Suites.html#basex-test-object-types
        for other types
    -->
    <xsl:param name="testObjectTypeId">EIDe1d4a306-7a78-4a3b-ae2d-cf5f0810853e</xsl:param>
    <!-- ########################################################################################## -->

    <xsl:template match="/etf:Tag">
        <xsl:variable name="tagId" select="@id"/>
        <etf:ExecutableTestSuite xmlns="http://www.interactive-instruments.de/etf/2.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:etf="http://www.interactive-instruments.de/etf/2.0"
	id="EID{$etsId}"
	xsi:schemaLocation="http://www.interactive-instruments.de/etf/2.0 http://resources.etf-validator.net/schema/v2/service/service.xsd">
	<itemHash>bQ==</itemHash>
	<remoteResource>https://github.com/interactive-instruments/etf-ets-repository/example/geometrytest</remoteResource>
	<localPath>/auto</localPath>
	<label>Geometry tests</label>
	<description>...</description>
	<reference>../example-bsxets.xq</reference>
	<version>2.0.0</version>
	<author>interactive instruments GmbH, Geonovum</author>
	<creationDate>2015-08-18T12:00:00.000+02:00</creationDate>
	<lastEditor>Transformer for geometry tests BSX</lastEditor>
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
	<supportedTestObjectTypes>
		<testObjectType ref="EID{$testObjectTypeId}"/>
	</supportedTestObjectTypes>
	<testModules>
        <xsl:variable name="testModuleEid" select="concat('EID', uuid:randomUUID(uuid:_get-node()))"/>
		<TestModule id="{$testModuleEid}">
			<label>IGNORE</label>
			<description>IGNORE</description>
			<parent ref="EID{$etsId}"/>
			<testCases>
                <xsl:variable name="testCaseEid" select="concat('EID', uuid:randomUUID(uuid:_get-node()))"/>
                <TestCase id="{$testCaseEid}">
					<label>Geometry tests</label>
					<description>...</description>
					<parent ref="{$testModuleEid}"/>
					<testSteps>
                        <xsl:variable name="testStepEid" select="concat('EID', uuid:randomUUID(uuid:_get-node()))"/>
                        <TestStep id="{$testStepEid}">
							<label>IGNORE</label>
							<description>IGNORE</description>
                            <parent ref="{$testModuleEid}"/>
							<statementForExecution>not applicable</statementForExecution>
							<testItemType ref="EIDf483e8e8-06b9-4900-ab36-adad0d7f22f0"/>
							<testAssertions>
                                <xsl:variable name="testAssertionEid" select="concat('EID', uuid:randomUUID(uuid:_get-node()))"/>
                                <TestAssertion id="{$testAssertionEid}">
									<!--GML.Geometry.01-->
									<label>Check CRS</label>
									<description>...</description>
									<parent ref="{$testStepEid}"/>
									<expectedResult>NOT_APPLICABLE</expectedResult>
									<expression>
										let $featuresWithErrors := $features[//@srsName[.!='http://www.opengis.net/def/crs/EPSG/0/28992' and .!='EPSG:28992' and .!='urn:ogc:def:crs:EPSG::28992']][position() le $limitErrors]
										return
										(if ($featuresWithErrors) then 'FAILED' else 'PASSED',
										local:error-statistics('TR.featuresWithErrors', count($featuresWithErrors)),
										for $feature in $featuresWithErrors
										order by $feature/@gml:id
										return local:addMessage('TR.example.crsNot28992', map { 'filename': local:filename($feature), 'featureType': local-name($feature), 'gmlid': string($feature/@gml:id), 'crs': data(($feature//@srsName[.!='http://www.opengis.net/def/crs/EPSG/0/28992' and .!='EPSG:28992' and .!='urn:ogc:def:crs:EPSG::28992'])[1])  }))
</expression>
									<testItemType ref="EIDf0edc596-49d2-48d6-a1a1-1ac581dcde0a"/>
								</TestAssertion>
                                <xsl:variable name="testAssertionEid2" select="concat('EID', uuid:randomUUID(uuid:_get-node()))"/>
                                <TestAssertion id="{$testAssertionEid2}">
									<!--GML.Geometry.02-->
									<label>Valid GML geometry (2D) all at once</label>
									<description>Test geometry on being valid GML geometry for 2D, all tests at once</description>
									<parent ref="{$testStepEid}"/>
									<expectedResult>NOT_APPLICABLE</expectedResult>
									<expression>
										let $messages := for $feature in $features
										return
										try {
										let $vr := ggeo:validateAndReport($feature,'111')
										return
										if (xs:boolean($vr/ggeo:isValid)) then ()
										else
										for $message in $vr/ggeo:message[@type='ERROR']
										return
										local:addMessage('TR.invalidGeometry', map { 'filename': local:filename($feature), 'featureType': local-name($feature), 'gmlid': string($feature/@gml:id), 'text': $message/text() })
										} catch * {
										}
										return
										(if ($messages) then 'FAILED' else 'PASSED',
										local:error-statistics('TR.featuresWithErrors', count(fn:distinct-values($messages//etf:argument[@token='gmlid']/text()))),
										$messages)
</expression>
									<testItemType ref="EIDf0edc596-49d2-48d6-a1a1-1ac581dcde0a"/>
								</TestAssertion>
                                <xsl:variable name="testAssertionEid3" select="concat('EID', uuid:randomUUID(uuid:_get-node()))"/>
                                <TestAssertion id="{$testAssertionEid3}">
									<!--GML.Geometry.03-->
									<label>Valid GML geometry (2D) General Validation</label>
									<description>Test geometry on being valid GML geometry for 2D - General Validation</description>
									<parent ref="{$testStepEid}"/>
									<expectedResult>NOT_APPLICABLE</expectedResult>
									<expression>
										let $messages := for $feature in $features
										return
										try {
										let $vr := ggeo:validateAndReport($feature,'1')
										return
										if (xs:boolean($vr/ggeo:isValid)) then ()
										else
										for $message in $vr/ggeo:message[@type='ERROR']
										return
										local:addMessage('TR.invalidGeometry', map { 'filename': local:filename($feature), 'featureType': local-name($feature), 'gmlid': string($feature/@gml:id), 'text': $message/text() })
										} catch * {
										}
										return
										(if ($messages) then 'FAILED' else 'PASSED',
										local:error-statistics('TR.featuresWithErrors', count(fn:distinct-values($messages//etf:argument[@token='gmlid']/text()))),
										$messages)
</expression>
									<testItemType ref="EIDf0edc596-49d2-48d6-a1a1-1ac581dcde0a"/>
								</TestAssertion>
                                <xsl:variable name="testAssertionEid4" select="concat('EID', uuid:randomUUID(uuid:_get-node()))"/>
                                <TestAssertion id="{$testAssertionEid4}">
									<!--GML.Geometry.04-->
									<label>Valid GML geometry (2D) Polygon Patch Connectivity</label>
									<description>Test geometry on being valid GML geometry for 2D - Polygon Patch Connectivity</description>
									<parent ref="{$testStepEid}"/>
									<expectedResult>NOT_APPLICABLE</expectedResult>
									<expression>
										let $messages := for $feature in $features
										return
										try {
										let $vr := ggeo:validateAndReport($feature,'01')
										return
										if (xs:boolean($vr/ggeo:isValid)) then ()
										else
										for $message in $vr/ggeo:message[@type='ERROR']
										return
										local:addMessage('TR.invalidGeometry', map { 'filename': local:filename($feature), 'featureType': local-name($feature), 'gmlid': string($feature/@gml:id), 'text': $message/text() })
										} catch * {
										}
										return
										(if ($messages) then 'FAILED' else 'PASSED',
										local:error-statistics('TR.featuresWithErrors', count(fn:distinct-values($messages//etf:argument[@token='gmlid']/text()))),
										$messages)
</expression>
									<testItemType ref="EIDf0edc596-49d2-48d6-a1a1-1ac581dcde0a"/>
								</TestAssertion>
                                <xsl:variable name="testAssertionEid5" select="concat('EID', uuid:randomUUID(uuid:_get-node()))"/>
                                <TestAssertion id="{$testAssertionEid5}">
									<!--GML.Geometry.05-->
									<label>Valid GML geometry (2D) Repetition of Position in CurveSegments</label>
									<description>Test geometry on being valid GML geometry for 2D - Repetition of Position in CurveSegments</description>
									<parent ref="{$testStepEid}"/>
									<expectedResult>NOT_APPLICABLE</expectedResult>
									<expression>
										let $messages := for $feature in $features
										return
										try {
										let $vr := ggeo:validateAndReport($feature,'001')
										return
										if (xs:boolean($vr/ggeo:isValid)) then ()
										else
										for $message in $vr/ggeo:message[@type='ERROR']
										return
										local:addMessage('TR.invalidGeometry', map { 'filename': local:filename($feature), 'featureType': local-name($feature), 'gmlid': string($feature/@gml:id), 'text': $message/text() })
										} catch * {
										}
										return
										(if ($messages) then 'FAILED' else 'PASSED',
										local:error-statistics('TR.featuresWithErrors', count(fn:distinct-values($messages//etf:argument[@token='gmlid']/text()))),
										$messages)
</expression>
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
