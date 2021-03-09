# Introduction

This document describes the (major) changes to [the current version 1.0.0](https://joinup.ec.europa.eu/solution/core-criterion-and-core-evidence-vocabulary/releases) of the Core Criterion and Core Evidence Vocabulary (released in December 2016) for which a new version is being proposed (version 2.0.0). The list of changes results in the new version to be considered as a major release.

The motivation for these adaptations is not described in this document. The changes only reflect the modifications and differences between the two versions: what is retained, added, removed or incorporated in a different way. The changes are described first from the perspective of the classes and then from the perspective of the relationships between them. Since the models are very different, an overview of the individual attributes is not provided.

# Changes

The table below gives an overview of the classes (and their definitions) within both data models. Classes that are related are juxta-positioned and given a SKOS-mapping value.

| Nr | CCCEV 1.0.0 class | CCCEV 2.0.0 class | SKOS-mapping |
| --- | --- | --- | --- |
| C1 | **Formal Framework**: Legislation, policy, or policies lying behind the rules that govern a criterion. | **Reference Framework:** A source from where Requirements are identified and derived. | Broad match |
| C2 | **Criterion Requirement**: An atomic requirement. | **Requirement:** A condition or prerequisite that someone requests and someone else has to meet. | Broad match |
| C3 | **Criterion**: The rule or principle used to judge, evaluate or assess something. | **Criterion:** A condition for evaluation or assessment. | Close match |
| C4 | **Information Requirement:** A request for data that is proof of Evidence or that leads to the source of such a proof. | | No match |
| C5 | **Constraint:** Limitation applied to requirement(s) or to the concept(s) the requirement is about. | | No match |
| C6 | **Information Concept:** A reference to an entity, i.e. a class or a property, which is used to describe information in the Evidence to be provided for the Requirement specified. | | No match |
| C7 | **Supported Value:** A value for an Information Concept that is supported by an Evidence. | | No match |
| C8 | **Period of time**: An interval of time that is named or defined by its start and end times. | | No match |
| C9 | **Requirement Group**: The set of requirements that must be fulfilled together to validate a criterion. | | No match |
| C10 | **Requirement Response** : An assertion that responds to a criterion requirement. | | No match |
| C11 | **Evidence**: Evidence is any resource that can document or support a Requirement response. | **Evidence:** The data proving that a requirement is met or has been fulfilled. | Narrow match |
| C12 | **Evidence Type List:** A combination of Evidence Types for each of which a conforming Evidence must be provided. | | No match |
| C13 | **Evidence Type:** Information about the characteristics of an expected Evidence. | | No match |
| C14 | **Document Reference**: A reference to the document, attestation or data, usually provided by a party different from the one providing the response, that proves the response. | | No match |

From this mapping, several changes can be distinguished between CCCEV 1.0.0 and CCCEV 2.0.0. The discovered changes and how they are addressed in version 2.0.0 are described below. The issues are categorized as <em>**no issue**</em> (new version covers entirely the semantic need), <em>**minor issue**</em> (the new version makes it possible to model this semantic need but this is not directly included in the model), <em>**important difference**</em> (the new version proposes a major change in intentional semantics). If a major change has been recorded, but that this change still covers the notion from CCCEV v1.0.0 in a very different way, we described it as <em>**important difference, but covered**</em>.

| Nr | Assessment |
| --- | --- |
| C1 | No issue, as CCCEV 2.0.0 broadens the definition. |
| C2 | **Minor issue,** as CCCEV 2.0.0 broadens the definition. A requirement does not have to be atomic anymore. It is now up to the user of CCCEV to define where the atomicity level for requirements is. If there is a need for an atomic requirement then the user can reintroduce it or specify further one of the subclasses of Requirement. |
| C3 | **Minor issue,** as CCCEV 2.0.0 considers Criterion to be a Requirement for the purpose of evaluation or assessment. |
| C4 | No issue, because new class. |
| C5 | No issue, because new class. |
| C6 | No issue, because new class. |
| C7 | No issue, because new class. |
| C8 | Validity intervals are not explicitly included in CCCEV 2.0.0. |
| C9 | **Important difference but covered**. Version 2.0.0 offers two mechanisms to express a Requirements to be fulfilled. The set of Requirements that must be fulfilled is now captured by the class Requirement itself via the self-relationship _has Requirement_. Consequently, a Requirement can be divided in several more detailed Requirements. In addition, the Requirement can express the expected values of the response via the Evidence Type Lists. |
| C10 | **Important difference but covered.** The notion of a response (envelope) has not been explicitly included. However since an Evidence is a **subclass of dcat:Dataset,** the envelope (namely describing the data that has been provided as response to a Requirement) is equivalent with the notion of Evidence. |
| C11 | **Minor issue**, as both notions still refer to the data that supports the response to a Requirement. Note that the Evidence in version 2.0.0 covers any data that proves a requirement. It does not have to be an official certificate signed by a public government. |
| C12 | No issue, because new class. |
| C13 | No issue, because new class. |
| C14 | **Important difference but covered.** Instead of introducing a new class to describe the form, the serialization, etc. in which the Evidence is being supplied, CCCEV 2.0.0 relies on Evidence being the subclass of dcat:Dataset. As such a dcat:Dataset has a dcat:Distribution, which exactly covers this notion of a Document Reference. It even broadens the notion so that machine-readable distributions are also covered in CCCEV 2.0.0. |

The following assessment applies to the relationships in CCCEV mentioned in version 1.0.0 and their counterparts in version 2.0.0.

| Nr | CCCEV 1.0.0 relationship | CCCEV 2.0.0 relationship | SKOS-mapping |
| --- | --- | --- | --- |
| R1 | Criterion <em>**is defined in**</em> Formal Framework | Requirement <em>**is Derived From**</em> Reference Framework | Exact match |
| R2 | Criterion <em>**fulfilled by**</em> Requirement Group | Requirement <em>**is Requirement Of**</em> Requirement | Close match |
| R3 | Requirement Group <em>**has**</em> Criterion Requirement | Requirement <em>**has Requirement**</em> Requirement | Close match |
| R4 | Criterion Requirement <em>**applicable in**</em> Period of Time | | No match |
| R5 | Criterion Requirement <em>**met by**</em> Evidence | Requirement <em>**has Supporting Evidence**</em> Evidence | Close match |
| R6 | Agent <em>**satisfies**</em> Criterion | | No match |
| R7 | Agent <em>**provides**</em> Requirement Response | | No match |
| R8 | Requirement Response <em>**applies to**</em> Period of Time | | No match |
| R9 | Requirement Response <em>**proven by**</em> Evidence | Requirement <em>**has Supporting Evidence**</em> Evidence | Close match |
| R10 | Evidence <em>**belongs to**</em> Agent | Evidence <em>**is About**</em> Agent | Exact match |
| R11 | Evidence <em>**issued by**</em> Organisation | | No match |
| R12 | Evidence <em>**is supported by**</em> Document Reference | | No match |

One can observe that, for the key notions of Requirement and Evidence, version 2.0.0 covers the equivalent notions expressed in version 1.0.0 but often with a broader semantic match. Open discussions remain regarding the harmonisation of the role(s) an Agent can play and the temporal information. This proposition of considering Evidence as a subclass of dcat:Dataset opens this space for discussion. The expressed roles in version 1.0.0 can be covered by the roles expressed in DCAT in various ways. Similar arguments hold for temporal information. To tackle these aspects, a community consultation is appropriate.
From this mapping, several changes can be distinguished between CCCEV 1.0.0 and CCCEV 2.0.0. The discovered changes and how they are addressed in version 2.0.0 are described below:

| Nr | Assessment |
| --- | --- |
| R1 | No issue. |
| R2 | No issue, as Requirements can be grouped together into larger units. |
| R3 | No issue, as Requirements can be grouped together into larger units. |
| R4 | **Important difference.** Applicability period has not been retained in version 2.0.0. |
| R5 | No issue, <em>**has Supporting Evidence**</em> covers all kinds of Requirements, including Criteria. |
| R6 | **Important difference.** There is no statement about an Agent that satisfies the Criteria. Not that this is not necessarily equivalent with the Agent for whom the evidence is about. |
| R7 | **Important difference but covered.** Evidence is a subclass of dcat:dataset. The Agent which provides the response can be considered the publisher of the Evidence. To be decided if this is equivalent and if dct:publisher can be used for that role. |
| R8 | **Important difference.** The application period of the response is not covered. Note that dcat:Dataset has several temporal notions that could be used to express equivalent notions like temporal coverage (the period that the Dataset, i.e. Evidence is covering) or issue date (the time one which the Dataset, i.e. Evidence has been issued). |
| R9 | No issue, as Evidence (subclass of dcat:Dataset) corresponds to the Requirement Response notion. |
| R10 | No issue. |
| R11 | **Minor issue,** as Evidence (via subclass of dcat:Dataset) supports several interaction roles with Agents. It can be a dct:publisher, a dct:creator or another qualified role. |
| R12 | **Minor issue,** it corresponds to dcat:distribution as Evidence is a subclass of dcat:Dataset. |
