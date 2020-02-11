# Messaging Model Package v1.4.1 
Introducing:
- better performance times (updated on January 23rd 2020)
- mostly bugfixing

##Content of the package
- TOOP Data Exchange Model Specification
- XSD version 1.4.1
- XML example instances for Requests, Responses and ErrorMessage
- Schematron file to perform Business Rules checks
- Updated Codelists used for the Business Rules checks
- Codelists Specification

### TOOP ErrorMessage Specification v1.4.0.xlsx 

- all changes are shown in the "Change Log" tab of the Excel file, and shown in red in the other tabs

### Included XML instance examples

several examples of XML instances are provided for two PA's
```
PA2-CONNECTEDCOMPANYDATA
data-request-example.xml
data-response-example.xml
data-request-document-example.xml
data-response-document-example.xml
data-response-with-ERROR-example.xml

PA3-MARITIME
MARITIME-STEP1a-request-list-of-ship-certificates.xml
MARITIME-STEP1b-response-list-of-ship-certificates.xml
MARITIME-STEP2a-data-request-document-example.xml
MARITIME-STEP2b-data-response-document-example.xml
```

The following examples (and inline comments) have been edited to adhere to the new 1.4.1 specifications:
```
data-response-example.xml
data-response-document-example.xml
MARITIME-STEP2b-data-response-document-example.xml
```


### Included Codelists
Several Genericode codelists are included.

From previous releases:
DataRequestSubjectTypeCode-CodeList.gc (changed "Legal Entity" to "Legal Person")
LevelsOfAssurance-CodeList.gc (added "None")
DocumentRequestTypeCode-CodeList.gc (added "LIST")
ConceptTypeCode-CodeList.gc
DataElementResponseErrorCode-CodeList.gc
DocumentRequestTypeCode-CodeList.gc
DocumentResponseErrorCode-CodeList.gc
ErrorCategory-CodeList.gc
ErrorCode-CodeList.gc
ErrorOrigin-CodeList.gc
ErrorSeverity-CodeList.gc
Gender-CodeList.gc
InformationSource-CodeList.gc
StandardIndustrialClassCode-CodeList.gc

BinaryObjectMimeCode-2.1.gc
CountryIdentificationCode-2.1.gc
CurrencyCode-2.1.gc
```

(the following codelists are provided in the package for simplicity, but over time new services will be added. Developers should take this into account when designing and implementing solutions for TOOP services)
```
ToopDocumentTypeIdentifiers-v2.gc
ToopParticipantIdentifierSchemes-v2.gc
ToopProcessIdentifiers-v2.gc
ToopTransportProfiles-v2.gc
```

### Included Schematron
A Schematron file is included to check the adherence to Business Rules. Mandatory rules show 'ERRORs', while less strict rules only show 'warnings'.
Some Schematron rules refer to the codelists above.
Included documentation (++TOOP Data Exchange Model Specification v1.4.0.xlsx++) lists both the Business Rules and the Schematron Rules.

##### TOOP Schematron rules-Specification v1.4.1 (changes from v1.4.0) 

- Added rule "wrong_dp_response_value_cardinality"


Please refer to the "Schematron rules" tab in the TOOP Data Exchange Model Specification for more details

#### BUGFIX
- fixed: changed the type of response element "ResponseURI" from IndicatorType to IdentifierType 


______________
______________
______________


#### Changes history

### Messaging Model Package v1.4.1
- Support for the two-step Document Request process
- Support for new Pilot Areas
- Level of Assurance for the eIDAS id's
- Alternative identifiers support for record matching
- Optional priority for preferred mime type
- Routing information

##### TOOP Schematron rules-Specification v1.4.0 (changes from v1.2.0) 

- Added rule "gc_check_loa"
- Changed rule "gc_check_country_countrycode"
- Added rule "gc_warn_country_countrycode"
- Added rule "mandatory_person_scheme_id"
- Added rule "check_documentremarks_unique_lang"
- Added rule "mandatory_doc_code_or_uri"
- Added rule "mandatory_request_or_response"
- Corrected rule "gc_check_id_countrycode"
- Changed rule "mandatory_req_doc_id" to use external genericode list
- Changed rule "mandatory_res_doc_id" to use external genericode list
- Changed rule "gc_check_process_id" to point to v2 of the genericode list
- Changed rule "mandatory_schemeagency_actors" to point to v2 of the genericode list



### TOOP ErrorMessage Specification v1.2.0.xlsx 

- added the optional Error element
- other changes are shown in red

### TOOP Data Exchange Model Specification v1.1.0.xlsx (changes from v9)   

Besides small editorial revisions and corrections of typos the following changes have been made:
- changed namespace to 'urn:eu:toop:ns:dataexchange-1p10'
- changed the name of the root from TOOP_DataRequest (or TOOP_DataResponse) to Request (or Response)
- added an "Identifiers" tab
- changed rules req_003 and rsp_003 to use the new identifiers
- changed rules req_004 and rsp_004 to use the new identifiers

##### Changes in the TOOP_DataExchange.xsd since version (1.0.8)

- Corrected the cardinality of ConceptDefinition, from 0..1 to 0..n (unbounded)
- Added PreferredDocumentMimeTypeCode to DocumentRequest
- Renamed AuthorisedRepresentativeIdentifier to AuthorizedRepresentativeIdentifier
- Added DocumentMimeTypeCode to Document in the response (introduced by the new version of the specs)
- changed 'Authorised' to 'Authorized'
- version updated

##### TOOP Schematron rules-Specification v1.2.0 (changes from v1.1.0) - now part of TOOP Data Exchange Model Specification

- Commented the "invalid_email" warning check: the current check causes issues with some parsers. 
- Added rule "gc_check_error_origin"
- Added rule "gc_check_error_category"
- Added rule "gc_check_error_severity"
- Added rule "gc_check_error_code"
- Added rule "check_matching_dataprovider_id"
- Added rule "check_errortext_unique_lang"
- Added rule "mandatory_data_provider"
- Added rule "one_data_provider"

##### TOOP Schematron rules-Specification v1.1.0 (changes from v9) - now part of TOOP Data Exchange Model Specification

- Added rule "gc_check_process_id"
- Changed rule "mandatory_req_doc_id" to use the new ID
- Changed rule "mandatory_req_specs_id" to use the new ID
- Changed rule "mandatory_res_specs_id" to use the new ID
- Added rule "toop-procid-agreement"
- Added rule "mandatory_schemeagency_actors"
- Added rule "mandatory_scheme_address"

##### TOOP Schematron rules-Specification v9.xlsx (changes from v8)

- Cell C9: changed to tbr-rsp-003
- Cell C15: removed tbr-req-090
- Cell C28: changed first tbr-rsp-031 to tbr-req-03

##### TOOP Data Exchange Model Specification v9.xlsx (changes from v8)

Besides small editorial revisions and corrections of typos the following changes have been made:
- Column 'Rules & Comments' revised in order to clearly classify rules and comments; added IDs of rules for which Schematron rules already exist (in blue text colour)
- Cell F10 (and others): removed 'positive'
- Cells D14REQ/D15RES: changed to 'Data Request Subject'
- Row 32REQ: Example (column G) changed to 'LE'; Rule/Comment (column J) corrected (also in J35RES)
- Cells D45REQ/D48RES: changed from '...Authorised...' to '...Authorized...', also in diagrams, xsd and example xmls
- Cell G54RES: removed comment
- Cells G94/99/100RES: changed decimal separator from , to .
- Cell F112RES: revised description
- Row 122RES completed
- Cell F125RES: 'consumer' changed to 'provider'

