<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" queryBinding="xslt3">
    <title>XSD Styleguide Validation Schematron</title>
    <ns prefix="f" uri="http://www.whatever.org"/>
    <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
    <pattern>
        
        <rule context="xs:schema">
            <assert test="@xs:xmlws">
                A Core Vocabulary doesn’t define occurrence indicators, hence minOccurs = 0.
            </assert>
            
            <assert test="./xs:import" role="info">
                If available, import the foreign xsd of which you want to reuse elements and/or attributes.
            </assert>
            
            <assert test="./xs:annotation/xs:documentation" role="info">
                Documentation CAN be added to the schema for human consumption.
            </assert>
        </rule>
        
        <!--Guideline 100-->
        <rule context="xs:schema">
            <assert test="./xmlns and ./targetNameSpace and ./version and (./xmlns/text() = ./targetNameSpace/text())">
                The root element of the XSD Schema SHALL specify default namespace, targetNamespace and version.
                Both, default and target namespaces SHALL be identical.
            </assert>
        </rule>
        
        <rule context="xs:schema">
            <assert test="./attributeFormDefault" role="info">
                No attributeFormDefault attribute has been specified. Please, note that the attributeFormDefault CAN be "unqualified".
            </assert>
        </rule>
        
        <rule context="xs:import">
            <assert test="@namespace">
                A namespace needs to be specified for any element imported from other external vocabularies and libraries of commonly reused components.
            </assert>
        </rule>
        
        <!--Guideline 101--> 
        
        <rule context="xs:import">
            <assert test="contains(string(./@schemaLocation), '../')" role="info">
                Please, note that absolute paths are strongly discouraged. Use relative paths instead.
            </assert>
        </rule>
        
        <!--Guideline 102--> 
        <rule context="xs:element[parent::xs:schema and not(xs:complexType)]">
 
            <assert test="matches(string(./@name), '^[A-Z]([A-Z0-9]*[a-z][a-z0-9]*[A-Z]*|[a-z0-9]*[A-Z][A-Z0-9]*[a-z])[A-Za-z0-9]*')" role="info">
                A global element declaration using the same name as the class name, using the same naming convention being UpperCamelBack.
                The Data and Object properties shall use the naming convention lowerCamelBack, not appending the word Type at the end, except if it is a code (guideline 110).
            </assert>
            
            <xsl:variable name="complexTypeName" select="concat(string(./@name), 'Type')"/>
            
            <assert test="boolean(/xs:schema/xs:complexType[@name=$complexTypeName])" role="info">
                A named complexType definition using the name as the class name and same naming convention as for the class name, concatenated with ‘Type’.
            </assert>
     
            <assert test="//xs:complexType[@name=$complexTypeName]/xs:complexContent/xs:sequence/xs:element[@name='id' or @name='identifier'] or
                         //xs:complexType[@name=$complexTypeName]/xs:complexContent/xs:extension/xs:sequence/xs:element[@name='id' or @name='identifier']">
                Every instance element SHALL be uniquely identifiable. Hence, addition of the attribute ID to the content model of all globally declared elements SHALL be implemented.
            </assert>
    
            <assert test="./xs:annotation/xs:documentation" role="info">
                Documentation CAN be added to the element for human consumption.
            </assert>
        </rule>
        
        <!--Guideline 108-->
        <rule context="xs:schema">
            <assert test="//xs:complexType[@abstract='false']" role="info">
                Classes in XML can be declared abstract, however they SHOULD NOT be declared abstract in an eGovernment Core Vocabulary.
                Declaring classes as ‘abstract’ would impose a restriction that could be inconvenient at XML instance production time.
            </assert>
        </rule>
        
        <!--Guideline 110-->
        <rule context="xs:sequence/xs:element">
            <assert test="matches(string(./@name), '^[a-z]([a-z0-9]*[A-Z][A-Z0-9]*[a-z]*|[A-Z0-9]*[a-z][a-z0-9]*[A-Z])[a-zA-Z0-9]*')">
                The name of any property shall follow the lowerCamelBack syntax.
                The name of a property shall not append the word Type at the end, except if it is a code
            </assert>
        </rule>
        
        <!--Guideline 114-->
        <rule context="//xs:element[not(parent::xs:schema)]">
            <assert test="@xs:minOccurs = 0">
                A Core Vocabulary doesn’t define occurrence indicators, hence minOccurs = 0.
                This is meant to provide developers of application profiles with the maximum flexibility to define the cardinality they may need. 
            </assert>
        </rule>
        
        <rule context="//xs:element[not(parent::xs:schema) and (@name = 'id' or @name='identifier')] ">
            <assert test="@xs:maxOccurs = unbounded" role="info">
                The cardinality of identifiers should be always 0..n.
            </assert>
        </rule>
        
        <rule context="//xs:element[not(parent::xs:schema) and
                      (@content castable as xs:string or @content castable as xs:normalizedString) and
                      (contains(./@type, 'Text'))]">
            <assert test="@xs:maxOccurs = unbounded" role="info">
                The cardinality of names, description and other text data types should be multiple.
            </assert>
        </rule>
        
    </pattern>
</schema>