<?xml version="1.0" encoding="UTF-8"?>
<!--
    
    Copyright (C) 2018 toop.eu
    
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    
    http://www.apache.org/licenses/LICENSE-2.0
    
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    
-->
<schema xmlns="http://purl.oclc.org/dsdl/schematron" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    queryBinding="xslt2" 
    >
    <title>TOOP Business Rules (specs Version 1.4.0)</title>
    <ns prefix="toop" uri="urn:eu:toop:ns:dataexchange-1p40"/>
    
    <!--Check for a valid split: only a DataElementRequest or a DocumentRequest-->
    <pattern>
        <rule context="toop:Request | toop:Response">
            <report test="( (exists(toop:DataElementRequest)) and (exists(toop:DocumentRequest)) )"  flag='ERROR' id="mandatory_split">
                The message cannot contain a request both for Data Elements and Documents. Please split the message.
            </report>
        </rule>
    </pattern>
    
    <pattern>
        <rule context="/">
            <assert test="( (exists(./toop:Request)) or (exists(./toop:Response)) )"  flag='ERROR' id="mandatory_request_or_response">
                The message must contain a Request or a Response. Please check if the namespace is correct.
            </assert>
        </rule>
    </pattern>
    
    <pattern>
        <rule context="toop:DataRequestSubject">
            <assert test="( (exists(./toop:LegalPerson)) or (exists(./toop:NaturalPerson)) )"  flag='ERROR' id="mandatory_legal_or_natural_person">
                The message must contain at least one Legal or Natural Person as a Data Request Subject. 
            </assert>
        </rule>
    </pattern>
    
    <!--Check the format of the UUID's-->
    <pattern>
        <rule context="toop:DocumentUniversalUniqueIdentifier | toop:DataRequestIdentifier | toop:DocumentRequestIdentifier">
            <assert test="matches(normalize-space(text()),'^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$','i')" flag='ERROR' id="wrong_uuid_format">
                Rule: The UUID MUST be created following the UUID Version 4 specification. 
                Copies of a document must be identified with a different UUID. 
                Compulsory use of schemeAgencyID attribute. Please check <value-of select="name(.)"/>.</assert>
        </rule>
    </pattern>
    
    <!--Check DataRequest specific rules-->
    <pattern>
        <rule context="toop:Request">
            <report test="exists(toop:DataRequestIdentifier)" flag='ERROR' id="misplaced_dr_id">
                A Request should not contain a DataRequestIdentifier, which is used in the response to link to the request.
            </report>
            <report test="( (exists(//toop:DocumentResponse)) or (exists(//toop:DataElementResponseValue)) )"  flag='ERROR' id="misplaced_response">
                A Request can not contain a DocumentResponse or any DataElementResponseValue element.
            </report>
            <report test="exists(./toop:DataProvider)" flag='ERROR' id="misplaced_data_provider">
                A Request should not contain information about the DataProvider.
            </report>
            <assert test="matches(toop:SpecificationIdentifier/text(),'urn:eu:toop:ns:dataexchange-1p40::Request')" flag='ERROR' id="mandatory_req_specs_id">
                Rule: A Toop data request MUST have the specification identifier "urn:eu:toop:ns:dataexchange-1p40::Request".
            </assert>

        </rule>
    </pattern>
    
    <!--Check DocumentRequest specific rules-->
    <pattern>
        <rule context="toop:DocumentRequest">
            <assert test="exists(toop:DocumentRequestTypeCode | toop:DocumentURI)" flag='ERROR' id="mandatory_doc_code_or_uri">
                Either oneDocumentRequestTypeCode or one DocumentURI element MUST be present in a Document Request.
            </assert>
        </rule>
    </pattern>
            
    <!--Check DataResponse specific rules-->
    <pattern>
        <rule context="toop:Response">
            <assert test="exists(toop:DataRequestIdentifier)" flag='ERROR' id="mandatory_dr_id">
                A Response must contain a DataRequestIdentifier. 
                UNCHECKED: Use the same value that was used in the corresponding Toop Request (path: Request/DocumentUniversalUniqueIdentifier).
            </assert>
            <report test="matches(toop:DataRequestIdentifier/text(),toop:DocumentUniversalUniqueIdentifier/text())"  flag='ERROR' id="duplicate_req_id">
                The DocumentUniversalUniqueIdentifier cannot be identical to the DataRequestIdentifier (which is copied from the Request).
            </report>
            <assert test="matches(toop:SpecificationIdentifier/text(),'urn:eu:toop:ns:dataexchange-1p40::Response')" flag='ERROR' id="mandatory_res_specs_id">
                Rule: A Toop data response MUST have the specification identifier "urn:eu:toop:ns:dataexchange-1p40::Response".
            </assert>
            <assert test="exists(toop:RoutingInformation/toop:DataProviderElectronicAddressIdentifier)"  flag='ERROR' id="mandatory_res_dp_electronic_address_id">
                Rule: A Toop data response MUST contain the DataProviderElectronicAddressIdentifier in the Routing information. 
            </assert>
        </rule>
    </pattern>
    
    <!--Check the schemeID of the DocumentTypeIdentifier and SpecificationIdentifier-->
    <pattern>
        <rule context="toop:DocumentTypeIdentifier | toop:SpecificationIdentifier">
            <let name="varschemeID" value="@schemeID"/>
            <assert test="matches($varschemeID,'^toop-doctypeid-qns$')" flag='ERROR' id="mandatory_scheme_docid">
                Compulsory use of attributes schemeID "toop-doctypeid-qns" (instead of <value-of select="$varschemeID"/>). Please check <value-of select="name(.)"/>.    
            </assert>
        </rule>
    </pattern>
       
    
    <!--Check the schemeID of the ProcessIdentifier-->
    <pattern>
        <rule context="toop:ProcessIdentifier">
            <let name="varschemeID" value="@schemeID"/>
            <assert test="matches($varschemeID,'^toop-procid-agreement$')" flag='ERROR' id="mandatory_scheme_processid">
                Compulsory use of attributes schemeID "toop-procid-agreement" (instead of <value-of select="$varschemeID"/>). Please check <value-of select="name(.)"/>.    
            </assert>
        </rule>
    </pattern>
    
    <!--Check for the existance of the SchemeId attribute when mandatory-->
    <pattern>
        <rule context="toop:DCElectronicAddressIdentifier | toop:DPElectronicAddressIdentifier">
            <assert test="@schemeID"  flag='ERROR' id="mandatory_address_schemeid">
                Rule: An electronic address identifier MUST have a scheme identifier attribute. Please check <value-of select="name(.)"/>. 
            </assert>
        </rule>
    </pattern>
    
    <pattern>
        <rule context="toop:AlternativeLegalPersonIdentifier | toop:AlternativeNaturalPersonIdentifier">
            <assert test="@schemeID"  flag='ERROR' id="mandatory_person_scheme_id">
                Rule: Compulsory use of the scheme ID. Please check <value-of select="name(.)"/>.
            </assert>
        </rule>
    </pattern>
    
    
    <!--Check the schemeID of the ElectronicAddressIdentifiers-->
    <pattern>
        <rule context="toop:DCElectronicAddressIdentifier | toop:DPElectronicAddressIdentifier">
            <let name="varschemeID" value="@schemeID"/>
            <assert test="matches($varschemeID,'^iso6523-actorid-upis$')" flag='ERROR' id="mandatory_scheme_address">
                Compulsory use of attributes schemeID "iso6523-actorid-upis" (instead of <value-of select="$varschemeID"/>). Please check <value-of select="name(.)"/>.
            </assert>
        </rule>
    </pattern>

    <!--Check if an identifier is valid according to the eIDAS specifications-->
    <pattern>
        <rule context="toop:LegalPersonUniqueIdentifier | toop:PersonIdentifier">
            <assert test="matches(normalize-space(text()),'^[a-z]{2}/[a-z]{2}/(.*?)','i')"  flag='ERROR' id="wrong_id_format">
                Rule: The uniqueness identifier consists of:
                1. The first part is the Nationality Code of the identifier. This is one of the ISO 3166-1 alpha-2 codes, followed by a slash ("/"))
                2. The second part is the Nationality Code of the destination country or international organization. This is one of the ISO 3166-1 alpha-2 codes, followed by a slash ("/")
                3. The third part a combination of readable characters. This uniquely identifies the identity asserted in the country of origin but does not necessarily reveal any discernible correspondence with the subject's actual identifier (for example, username, fiscal number etc).
                Please check <value-of select="name(.)"/>.
            </assert>
        </rule>
    </pattern>
    
    <!--Check for the existance of the SchemeAgencyId attribute when mandatory-->
    <pattern>
        <rule context="toop:DataConsumerDocumentIdentifier | toop:DPIdentifier | toop:DocumentUniversalUniqueIdentifier | toop:DCUniqueIdentifier | toop:DocumentIssuerIdentifier | toop:DataConsumerGlobalSessionIdentifier | toop:DataRequestIdentifier | toop:DocumentRequestIdentifier">
            <assert test="@schemeAgencyID"  flag='ERROR' id="mandatory_schemeagency">
                Rule: The schemeAgencyID attribute is mandatory. Please check <value-of select="name(.)"/>.
            </assert>
        </rule>
    </pattern>
    
    <!--Check for the ConceptDefinition of a DC concept-->
    <pattern>
        <rule context="toop:ConceptRequest">
            <!--        <let name="conceptNamespaces" value="count(toop:ConceptNamespace)"/>  -->
            <!--        <let name="conceptNames" value="count(./toop:ConceptName)"/> -->
            <let name="conceptDefinitions" value="count(./toop:ConceptDefinition)"/> 
            <report test="matches(toop:ConceptTypeCode,'DC') and ($conceptDefinitions!=1)"  flag='ERROR' id="wrong_dc_concept_def_cardinality">
                Rule: If the Concept Type Code is set on "Data Consumer" the cardinality of the ConceptDefinition element MUST be set to 1...1 (instead of <value-of select="$conceptDefinitions"/>).
            </report>
        </rule>
    </pattern>
    
    
    <!--Check for the existence of a DataElementResponseValue only in the deepest level of a ConceptRequest ("TC" or "DP")-->
    <pattern>
        <rule context="toop:Response/toop:DataElementRequest/toop:ConceptRequest">
            <let name="responseValues" value="count(.//toop:DataElementResponseValue)"/> 
            <let name="conceptRequests" value="count(..//toop:ConceptRequest)"/> 
            <let name="toopErrors" value="count(//toop:Error)"/>
            <assert test="( (($responseValues=0 or $responseValues=1) and 
                   (($conceptRequests=1) and(exists(./toop:DataElementResponseValue))
                or (($conceptRequests=2) and(exists(./toop:ConceptRequest/toop:DataElementResponseValue)) )
                or (($conceptRequests=3) and(exists(./toop:ConceptRequest/toop:ConceptRequest/toop:DataElementResponseValue)) )))               
                or ($toopErrors>0 and $responseValues=0)     
                )"  flag='ERROR' id="wrong_dp_response_value_cardinality">
                Only one DataElementeResponseValue can be added at the deepest level of a ConceptRequest (found <value-of select="$responseValues"/> value(s) and <value-of select="$conceptRequests"/> level(s)). 
                Rule:  If the ConceptTypeCode of a ConceptRequest is set on "Data Provider" ("DP") or "TOOP Concept" ("TC") and the hierarchy of a concept request is at its maximum, the cardinality of this element MUST be set to 1…n in the TOOP Response. 
            </assert>
        </rule>
    </pattern>
    
    
    <!--Check if the AuthorizedRepresentativeIdentifier links to the personIdentifier-->
    <pattern>
        <rule context="toop:AuthorizedRepresentativeIdentifier">
            <assert test="normalize-space(text())=normalize-space(//toop:DataRequestSubject/toop:NaturalPerson/toop:PersonIdentifier)"  flag='ERROR' id="unmatched_person_rep_id">
                Rule: Use the value that is used in the element: DataSubject/NaturalPerson/PersonIdentifier.
            </assert>
        </rule>
    </pattern>
    
    <!--Check the format of a e-mail address-->
    <!--pattern>
        <rule context="toop:ContactEmailAddress"-->
            <!-- [ph] changed RegEx -->
            <!--assert test="matches(text(),'[a-z0-9!#\$%&amp;''*+/=?^_`{{|}}~-]+(?:\.[a-z0-9!#\$%&amp;''*+/=?^_`{{|}}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?','i')"  flag='warning' id="invalid_email">
                The e-mail address format looks invalid.
            </assert>
        </rule>
    </pattern-->
    
    <!--Check the length of the LEI code.-->
    <pattern>
        <rule context="toop:LegalEntityIdentifier">
            <let name="varleilength" value="string-length(normalize-space(text()))"/>
            <assert test="$varleilength=20"  flag='warning' id="invalid_euid_length">
                The LEI code length should be 20 (instead of <value-of select="$varleilength"/>).
            </assert>
        </rule>
    </pattern>
    
    <!--Check the validity of a boolean value (true or false)-->
    <pattern>
        <rule context="toop:DataElementResponseValue/toop:ResponseIndicator | toop:ErrorIndicator | toop:CopyIndicator | toop:SemanticMappingExecutionIndicator | toop:AlternativeResponseIndicator">
            <assert test="( (matches(normalize-space(text()),'^true$','i')) or (matches(normalize-space(text()),'^false$','i')) )" flag='ERROR' id="value_is_true_or_false">
                The provided value should be a boolean: true or false. Please check <value-of select="name(.)"/>.
            </assert>
        </rule>
    </pattern>
    
    <!--Check for currency attribute-->
    <pattern>
        <rule context="toop:DataElementResponseValue/toop:ResponseAmount">
            <assert test="@currencyID"  flag='ERROR' id="mandatory_currency_id">
                Rule: The currencyID attribute is mandatory (e.g. "EUR"). Please check <value-of select="name(.)"/>.
            </assert>
        </rule>
    </pattern>
    
    <!--Check the validity of a numeric response-->
    <pattern>
        <rule context="toop:DataElementResponseValue/toop:ResponseNumeric">
            <report test="matches(normalize-space(text()),'%')" flag='ERROR' id="avoid_percentage">
                Rule: do not format the percentage "%" symbol with the response value, just provide a float value (e.g. 0.4). Please check <value-of select="name(.)"/>.
            </report>
        </rule>
    </pattern>
    
    <!--Check if the DataProviderID contained in an Error matches the ID of a DataProvider in the message-->
    <pattern>
            <let name="dataproviderids" value="//toop:DataProvider/toop:DPIdentifier" /> 
            <rule context="toop:Error/toop:DataProviderIdentifier" flag='ERROR' id='check_matching_dataprovider_id'> 
                <assert test="$dataproviderids[normalize-space(.) = normalize-space(current()/.)]">
                    The DataProviderID contained in an Error must match the ID of a DataProvider in this message.
                </assert> 
            </rule> 
    </pattern>

    
    <!--Check if the languageID of an ErrorText is unique in the context of one Error-->  
    <pattern>
        <rule context="toop:Error" id='check_errortext_unique_lang'>
            <assert test="count(toop:ErrorText) = count(distinct-values(toop:ErrorText/@languageID))">
                When more than one ErrorText is present, they all need to have a different language ID.
            </assert>
        </rule>
    </pattern>
    
    <!--Check if the languageID of an ErrorText is unique in the context of one Error-->  
    <pattern>
        <rule context="toop:DocumentResponse" id='check_documentremarks_unique_lang'>
            <assert test="count(toop:DocumentRemarks) = count(distinct-values(toop:DocumentRemarks/@languageID))">
                The Document Remarks can contain more than one Remark, but they must be in different languages (using different languageID's).
            </assert>
        </rule>
    </pattern>
    
    
    <!--Check for the ConceptDefinition of a DC concept--> 
    <pattern>
        <rule context="toop:Response">
            <let name="dataProviderCount" value="count(./toop:DataProvider)"/>  
            <let name="errorCount" value="count(//toop:Error[toop:Severity='FAILURE'])"/>  
            <report test="$dataProviderCount>1"  flag='ERROR' id="one_data_provider">
                Rule: At maximum one DataProvider must be present in a Response.
            </report>
            <report test="($dataProviderCount=0) and ($errorCount=0)"  flag='ERROR' id="mandatory_data_provider">
                Rule: The DataProvider in a Response is mandatory if there is no fatal error.
            </report>
        </rule>
    </pattern>
    
   
    
    <!-- RULES USING CODELISTS -->
    
    <!--Check codelist for document type identifier-->
    <pattern> 
        <let name="doctypes" value="document('..\codelists\dynamic\ToopDocumentTypeIdentifiers-v2.gc')//Value[@ColumnRef='doctypeid']" />
        <rule context="toop:Request/toop:RoutingInformation/toop:DocumentTypeIdentifier" flag='ERROR' id='mandatory_req_doc_id'> 
            <assert test="$doctypes/SimpleValue[normalize-space(.) = normalize-space(current()/.)]">A Request DocumentTypeIdentifier must always be specified using the correct code list. (list: <value-of select="$doctypes"/> found:<value-of select="toop:RoutingInformation//toop:DocumentTypeIdentifier/text()"/>)</assert> 
        </rule> 
        <rule context="toop:Response/toop:RoutingInformation/toop:DocumentTypeIdentifier" flag='ERROR' id='mandatory_res_doc_id'> 
            <assert test="$doctypes/SimpleValue[normalize-space(.) = normalize-space(current()/.)]">A Response DocumentTypeIdentifier must always be specified using the correct code list.</assert> 
        </rule> 
    </pattern> 
    
    
    <!--Check codelist for country-->
    <pattern> 
        <let name="countrycodes" value="document('..\codelists\std-gc\CountryIdentificationCode-2.1.gc')//Value[@ColumnRef='code']" />
        <rule context="toop:DCLegalAddress/toop:CountryCode | toop:DPLegalAddress/toop:CountryCode | toop:RoutingInformation/toop:DataConsumerCountryCode | toop:RoutingInformation/toop:DataProviderCountryCode" flag='ERROR' id='gc_check_country_countrycode'> 
            <assert test="$countrycodes/SimpleValue[normalize-space(.) = normalize-space(current()/.)]">The country code must always be specified using the correct code list. Please check <value-of select="name(.)"/>.</assert> 
        </rule> 
        <rule context="toop:NaturalPersonLegalAddress/toop:CountryCode | toop:LegalPersonLegalAddress/toop:CountryCode" flag='warning' id='gc_warn_country_countrycode'> 
            <assert test="$countrycodes/SimpleValue[normalize-space(.) = normalize-space(current()/.)]">The country code SHOULD always be specified using the correct code list. Please check <value-of select="name(.)"/>.</assert> 
        </rule> 
        <rule context="toop:LegalPersonUniqueIdentifier | toop:PersonIdentifier" flag='ERROR' id='gc_check_id_countrycode'>
            <assert test="$countrycodes/SimpleValue[normalize-space(.) = (tokenize(normalize-space(current()/.),'/')[1])]">The country code in the first part of the identifier must always be specified using the correct code list (found:<value-of select="(tokenize(normalize-space(current()/.),'/')[1])"/>).</assert> 
            <assert test="$countrycodes/SimpleValue[normalize-space(.) = (tokenize(normalize-space(current()/.),'/')[2])]">The country code in the second part of the identifier must always be specified using the correct code list (found:<value-of select="(tokenize(normalize-space(current()/.),'/')[2])"/>).</assert> 
        </rule>
    </pattern> 
    
    <!--Check codelist for data request subject type-->
    <pattern> 
        <let name="subjecttypecodes" value="document('..\codelists\gc\DataRequestSubjectTypeCode-CodeList.gc')//Value[@ColumnRef='code']" />
        <rule context="toop:DataRequestSubjectTypeCode" flag='ERROR' id='gc_check_subject_type_code'> 
            <assert test="$subjecttypecodes/SimpleValue[normalize-space(.) = normalize-space(current()/.)]">A subject type code must always be specified using the correct code list.</assert> 
        </rule> 
    </pattern> 
    
    <!--Check codelist for gender-->
    <pattern> 
        <let name="gendertypecodes" value="document('..\codelists\gc\Gender-CodeList.gc')//Value[@ColumnRef='code']" />
        <rule context="toop:GenderCode" flag='ERROR' id='gc_check_gender_code'> 
            <assert test="$gendertypecodes/SimpleValue[normalize-space(.) = normalize-space(current()/.)]">A gender code must always be specified using the correct code list.</assert> 
        </rule> 
    </pattern> 
    
    <!--Check codelist for concept-->
    <pattern> 
        <let name="concepttypecodes" value="document('..\codelists\gc\ConceptTypeCode-CodeList.gc')//Value[@ColumnRef='code']" />
        <rule context="toop:ConceptTypeCode" flag='ERROR' id='gc_check_concept_code'> 
            <assert test="$concepttypecodes/SimpleValue[normalize-space(.) = normalize-space(current()/.)]">A concept type code must always be specified using the correct code list.</assert> 
        </rule> 
    </pattern> 
    
    <!--Check codelist for currency-->
    <pattern> 
        <let name="currencytypecodes" value="document('..\codelists\std-gc\CurrencyCode-2.1.gc')//Value[@ColumnRef='code']" />
        <rule context="toop:ResponseAmount" flag='ERROR' id='gc_check_currency_code'> 
            <let name="varcurrencyID" value="@currencyID"/>
            <assert test="$currencytypecodes/SimpleValue[normalize-space(.) = $varcurrencyID]">A currency type code must always be specified using the correct code list (found:<value-of select="$varcurrencyID"/>).</assert> 
        </rule> 
    </pattern> 
    
    <!--Check codelist for standard industrial class code-->
    <pattern> 
        <let name="industrialtypecodes" value="document('..\codelists\gc\StandardIndustrialClassCode-CodeList.gc')//Value[@ColumnRef='code']" />
        <rule context="toop:StandardIndustrialClassification" flag='warning' id='gc_check_industrial_code'> 
            <assert test="$industrialtypecodes/SimpleValue[normalize-space(.) = normalize-space(current()/.)]">A standard industrial classification code must always be specified using the correct code list.</assert> 
        </rule> 
    </pattern> 
    
    <!--Check codelist for data element response error code-->
    <pattern> 
        <let name="dataelementresponseerrorcodes" value="document('..\codelists\gc\DataElementResponseErrorCode-CodeList.gc')//Value[@ColumnRef='code']" />
        <rule context="toop:DataElementResponseValue//toop:ErrorCode" flag='ERROR' id='gc_check_error_data_element_response'> 
            <assert test="$dataelementresponseerrorcodes/SimpleValue[normalize-space(.) = normalize-space(current()/.)]">An error code must always be specified using the correct code list.</assert> 
        </rule> 
    </pattern> 
    
    <!--Check codelist for document response error code-->
    <pattern> 
        <let name="documentresponseerrorcodes" value="document('..\codelists\gc\DocumentResponseErrorCode-CodeList.gc')//Value[@ColumnRef='code']" />
        <rule context="toop:DocumentResponse//toop:ErrorCode" flag='ERROR' id='gc_check_error_document_response'> 
            <assert test="$documentresponseerrorcodes/SimpleValue[normalize-space(.) = normalize-space(current()/.)]">An error code must always be specified using the correct code list.</assert> 
        </rule> 
    </pattern> 
    
    <!--Check codelist for document request type code-->
    <pattern> 
        <let name="docrequesttypecodes" value="document('..\codelists\gc\DocumentRequestTypeCode-CodeList.gc')//Value[@ColumnRef='code']" />
        <rule context="toop:DocumentRequestTypeCode | toop:DocumentTypeCode" flag='warning' id='gc_check_doc_req_type'> 
            <assert test="$docrequesttypecodes/SimpleValue[normalize-space(.) = normalize-space(current()/.)]">A document type code must always be specified using the correct code list.</assert> 
        </rule> 
    </pattern> 
    
    <!--Check codelist for mimetype code-->
    <pattern> 
        <let name="mimetypecodes" value="document('..\codelists\std-gc\BinaryObjectMimeCode-2.1.gc')//Value[@ColumnRef='code']" />
        <rule context="toop:PreferredDocumentMimeTypeCode | toop:DocumentMimeTypeCode" flag='warning' id='gc_check_doc_mime_type'> 
            <assert test="$mimetypecodes/SimpleValue[normalize-space(.) = normalize-space(current()/.)]">A mimetype code must always be specified using the correct code list.</assert> 
        </rule> 
    </pattern> 
    
    <!--Check codelist for process identifier-->
    <pattern> 
        <let name="processidcodes" value="document('..\codelists\dynamic\ToopProcessIdentifiers-v2.gc')//Value[@ColumnRef='id']" />
        <rule context="toop:ProcessIdentifier" flag='ERROR' id='gc_check_process_id'> 
            <assert test="$processidcodes/SimpleValue[normalize-space(.) = normalize-space(current()/.)]">A process identifier must always be specified using the correct code list.</assert> 
        </rule> 
    </pattern> 
    
    <!--Check codelist for SchemeAgencyID-->
    <pattern> 
        <let name="agencyids" value="document('..\codelists\dynamic\ToopParticipantIdentifierSchemes-v2.gc')//Value[@ColumnRef='iso6523']" />
        <rule context="toop:DCElectronicAddressIdentifier | toop:DPElectronicAddressIdentifier" flag='ERROR' id='mandatory_schemeagency_actors'> 
            <let name="thisId" value="@schemeAgencyID"/>
            <assert test="$agencyids/SimpleValue[normalize-space(.)] = @schemeAgencyID">A schemeAgencyID must always be specified using the correct code list (found:<value-of select="$thisId"/>).</assert> 
        </rule> 
    </pattern> 
    
    <!--Check codelist for error origin in an Error Response-->
    <pattern> 
        <let name="errororigincodes" value="document('..\codelists\gc\ErrorOrigin-CodeList.gc')//Value[@ColumnRef='code']" />
        <rule context="toop:Error//toop:Origin" flag='ERROR' id='gc_check_error_origin'> 
            <assert test="$errororigincodes/SimpleValue[normalize-space(.) = normalize-space(current()/.)]">An error origin code must always be specified using the correct code list.</assert> 
        </rule> 
    </pattern> 
    
    <!--Check codelist for error category in an Error Response-->
    <pattern> 
        <let name="errorcategorycodes" value="document('..\codelists\gc\ErrorCategory-CodeList.gc')//Value[@ColumnRef='code']" />
        <rule context="toop:Error//toop:Category" flag='ERROR' id='gc_check_error_category'> 
            <assert test="$errorcategorycodes/SimpleValue[normalize-space(.) = normalize-space(current()/.)]">An error category code must always be specified using the correct code list.</assert> 
        </rule> 
    </pattern> 
    
    <!--Check codelist for error severity in an Error Response-->
    <pattern> 
        <let name="errorseveritycodes" value="document('..\codelists\gc\ErrorSeverity-CodeList.gc')//Value[@ColumnRef='code']" />
        <rule context="toop:Error//toop:Severity" flag='ERROR' id='gc_check_error_severity'> 
            <assert test="$errorseveritycodes/SimpleValue[normalize-space(.) = normalize-space(current()/.)]">An error severity code must always be specified using the correct code list.</assert> 
        </rule> 
    </pattern> 
    
    <!--Check codelist for error code in an Error Response-->
    <pattern> 
        <let name="errorcodecodes" value="document('..\codelists\gc\ErrorCode-CodeList.gc')//Value[@ColumnRef='code']" />
        <rule context="toop:Error//toop:ErrorCode" flag='ERROR' id='gc_check_error_code'> 
            <assert test="$errorcodecodes/SimpleValue[normalize-space(.) = normalize-space(current()/.)]">An error code must always be specified using the correct code list.</assert> 
        </rule> 
    </pattern> 
    
    <!--Check if the mandatory Level of Assurance has been set and includes one of the codelist values-->
    <pattern> 
        <let name="loacodes" value="document('..\codelists\gc\LevelsOfAssuranceCode-CodeList.gc')//Value[@ColumnRef='code']" />
        <rule flag='ERROR' id='gc_check_loi' 
              context="toop:LegalPerson/toop:LegalPersonUniqueIdentifier 
                      |toop:LegalPerson/toop:LegalName  
                      |toop:LegalPerson/toop:VATRegistrationNumber 
                      |toop:LegalPerson/toop:TaxReferenceNumber
                      |toop:LegalPerson/toop:BusinessCodes 
                      |toop:LegalPerson/toop:LegalEntityIdentifier 
                      |toop:LegalPerson/toop:EORIIdentifier 
                      |toop:LegalPerson/toop:SEEDIdentifier 
                      |toop:LegalPerson/toop:StandardIndustrialClassification 
                      |toop:LegalPersonLegalAddress/toop:AddressLine 
                      |toop:LegalPersonLegalAddress/toop:StreetName 
                      |toop:LegalPersonLegalAddress/toop:StreetNumber
                      |toop:LegalPersonLegalAddress/toop:City 
                      |toop:LegalPersonLegalAddress/toop:PostCode 
                      |toop:LegalPersonLegalAddress/toop:Country 
                      |toop:NaturalPerson/toop:PersonIdentifier 
                      |toop:NaturalPerson/toop:FamilyName
                      |toop:NaturalPerson/toop:FirstName
                      |toop:NaturalPerson/toop:BirthDate
                      |toop:NaturalPerson/toop:BirthFamilyName
                      |toop:NaturalPerson/toop:BirthPlace
                      |toop:NaturalPerson/toop:GenderCode
                      |toop:NaturalPersonLegalAddress/toop:AddressLine
                      |toop:NaturalPersonLegalAddress/toop:StreetName
                      |toop:NaturalPersonLegalAddress/toop:StreetNumber
                      |toop:NaturalPersonLegalAddress/toop:City
                      |toop:NaturalPersonLegalAddress/toop:PostCode
                      |toop:NaturalPersonLegalAddress/toop:Country
                      "> 
            <assert test="@levelOfAssurance" flag='ERROR'>
                The level of assurance always has to be provided. In case you are not using eIDAS for authentication the value must be "None". Please check <value-of select="name(.)"/>.
            </assert>
            <let name="thisLOA" value="@levelOfAssurance"/>
            <assert test="$loacodes/SimpleValue[normalize-space(.)] = @levelOfAssurance">
                A level of assurance must always be specified using the correct code list. Please check <value-of select="name(.)"/>. Found: <value-of select="$thisLOA"/>).
            </assert> 
        </rule> 
    </pattern> 
    
</schema>