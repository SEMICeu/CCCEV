# Transition from CCCEV v1.0.0 to v2.0.0

## Introduction

This document describes the (major) changes to [the current version 1.0.0](https://joinup.ec.europa.eu/solution/core-criterion-and-core-evidence-vocabulary/releases) of the Core Criterion and Core Evidence Vocabulary (released in December 2016) for which a new version is being proposed ([version 2.0.0](https://semiceu.github.io/CCCEV/releases/2.00/)). The list of changes results in the new version to be considered as a major release.

We first describe the new high-level design choices which have led to a number of structural changes to the data model of CCCEV. Next, we describe the changes between the two versions in more detail: what is retained, added, removed or incorporated in a different way. The detailed changes are described from the perspective of the classes and the relationships between them. Since the two models are very different, an overview of the individual attributes is not provided.

## High-level overview of fundamental modelling changes

### Creating more semantically enriched Requirements
Whereas v1.0.0 used the Criterion Requirement class to describe atomic requirements, v2.0.0 sees the Requirement class as a broad, abstract class, that can be linked to related Requirements and sub-Requirements via a self-association. V2.0.0 recommends to use one of the proposed subclasses of Requirement (Criterion, Information Requirement or Constraint), or, if those classes do not support the implementor's needs, to create your own subclass of Requirement. This enables implementors to define their own domain-specific Requirements and corresponding properties, leading ultimately to more semantically enriched Requirements, enhancing the understandability for the end user.

### Making Requirements machine-readable
By introducing the classes Information Concept and Supported Value, Requirements can be made machine-readable, as opposed to only a textual description and some minor numeric values, as was the case in CCCEV v1.0.0. In addition, the Evidence class is also linked to the Information Concept and Supported Value class in CCCEV 2.0.0, in order to facilitate automated reasoning on Requirements and on the Evidences that do or do not support that Requirement. 

### Supporting multiple request-response patterns
While in v1.0.0, it was the respondent who was making a claim or assertion (Requirement Response) that was proven by Evidence; in the more generic v2.0.0 of CCCEV, multiple request-response patterns are supported. An Evidence can [1] verify a claim (i.e. is it true that John is 25, yes/no), [2] prove a condition (i.e. is John 18+, yes/no), or [3] simply provide data (i.e. the age of a person, namely 25). Implementors will have to design their own request-response pattern, as CCCEV v2.0.0 does not impose any constraints on this level.

### Shifting the description of the different possible ways to fulfill a (Criterion) Requirement from the Requirement side to the Evidence side
In version 1.0.0, the different ways in which a Criterion could be fulfilled were expressed via the class RequirementGroup, the different instances of which could have been seen as having a logic OR relationship among them, i.e. you can fulfil a certain Criterion via RequirementGroup 1 OR via RequirementGroup 2. Additionally, a RequirementGroup consisted of (atomic) CriterionRequirements, the different instances of which could have been seen as having a logic AND relationship among them, i.e. in order to fulfil this RequirementGroup you need to fulfil all related CriterionRequirements. 

In version 2.0.0, a different approach is proposed based on Evidence. The core class Requirement can be fulfilled by one or more EvidenceTypeLists ("a collection of types of evidences"), the different instances of which have a logic OR relationship among them. An EvidenceTypeList consists of multiple EvidenceTypes, the different instances of which have a logic AND relationship among them, i.e. in order to fulfil this Requirement, you need to provide Evidence A AND B from EvidenceTypeList 1, OR you need to provide Evidence C AND D from EvidenceTypeList 2. 

As can be seen from the above explanation, this second approach puts the emphasis on expressing the different Types of Evidences than can be provided in order to fulfil the same Requirement in the end, as opposed to version 1.0.0 where this logical structure was found in the Criterion/Requirement part. Because of this change in “fulfillment mechanism”, the class RequirementGroup and the overarching Criterion class in its original meaning are no longer needed in version 2.0.0.

### Making Evidence a subclass of dcat:Dataset
In v2.0.0, CCCEV relies on DCAT, a vocabulary for cataloging datasets and services, to share metadata about an Evidence. This dependence is made explicit by subclassing Evidence from dcat:Dataset. This is justified by the fact that a lot of the information needed for describing Evidences is described in DCAT, such as the issue date, creator, title, etc. Furthermore, other useful parts from DCAT can be reused, such as the Distribution class.

Note that CCCEV v2.0.0 does not enforce the information carried in an Evidence to be directly accessible, i.e. contained within the payload of the response. However, it does offer several ways to implement these aspects: (1) via subclassing of the Evidence class, (2) via sharing it as a dcat:Distribution or (3) via the class Supported Value. These are three distinguishable approaches, which can be used independently from each other, or in combination.

### Conforming the definitions to the proposed principles.
During the public review, requests were made to align and harmonise the definitions and usage notes. In the [Open Guidelines](https://github.com/SEMICeu/OpenGuidelines) guidelines with principles for good definitions have been published. This release applies to the best extend the principles.

## Detailed changes

The structure of this section is the following:
* Mapping of the classes from CCCEV 1.0.0 to CCCEV 2.0.0 with their descriptions.
*	Assessment of the previous mapping, reflecting on the intended usage of the classes in v2.0.0 compared to v1.0.0.
*	Mapping of the relationships from CCCEV 1.0.0 to CCCEV 2.0.0 with their descriptions.
*	Assessment of the previous mapping, reflecting on the intended usage of the relationships in v2.0.0 compared to v1.0.0.

The table below gives an overview of the classes (and their definitions) within both data models. Classes that are related are juxta-positioned.

| Nr | CCCEV 1.0.0 class | CCCEV 2.0.0 class |
| --- | --- | --- | 
| C1 | **Formal Framework**: Legislation, policy, or policies lying behind the rules that govern a criterion. | **Reference Framework:** A source from where Requirements are identified and derived. | 
| C2 | **Criterion Requirement**: An atomic requirement. | **Requirement:** A condition or prerequisite that someone requests and someone else has to meet. | 
| C3 | **Criterion**: The rule or principle used to judge, evaluate or assess something. | **Criterion:** A condition for evaluation or assessment. |
| C4 | **Criterion Requirement**: An atomic requirement. | **Information Requirement:** A request for data that is proof of Evidence or that leads to the source of such a proof.|
| C5 | **Criterion Requirement**: An atomic requirement.| **Constraint:** Limitation applied to requirement(s) or to the concept(s) the requirement is about. | Close match |
| C6 | | **Information Concept:** A reference to an entity, i.e. a class or a property, which is used to describe information in the Evidence to be provided for the Requirement specified. |
| C7 | | **Supported Value:** A value for an Information Concept that is supported by an Evidence. |
| C8 | **Period of time**: An interval of time that is named or defined by its start and end times. | |
| C9 | **Requirement Group**: The set of requirements that must be fulfilled together to validate a criterion. | |
| C10 | **Requirement Response** : An assertion that responds to a criterion requirement. | |
| C11 | **Evidence**: Evidence is any resource that can document or support a Requirement response. | **Evidence:** The data proving that a requirement is met or has been fulfilled. |
| C12 | |**Evidence Type List:** A combination of Evidence Types for each of which a conforming Evidence must be provided.|
| C13 | |**Evidence Type:** Information about the characteristics of an expected Evidence. |
| C14 | **Document Reference**: A reference to the document, attestation or data, usually provided by a party different from the one providing the response, that proves the response. |
| C15 | **Agent**: An Organisation or Natural person providing a Requirement response that satisfies a Criterion. The Agent class is a generalisation of the Person and Organisation classes defined in the Core Person Vocabulary and the Organisation Ontology respectively. | **Agent**: Any entity that is able to carry out actions. |
| C16 | |**Dataset**: A collection of data. |

From this mapping, several changes can be distinguished between CCCEV 1.0.0 and CCCEV 2.0.0. The discovered changes and how they are addressed in version 2.0.0 are described below. The issues are categorized as: 
* <em>**No issue**</em>: new version covers entirely the semantic need, 
* <em>**Minor issue**</em>: the new version makes it possible to model this semantic need but this is not directly included in the model, 
* <em>**Important difference**</em>: the new version proposes a major change in intentional semantics, 
* <em>**Important difference but covered**</em>: if a major change has been recorded, but that this change still covers the notion from CCCEV v1.0.0 in a very different way.

| Nr | Assessment |
| --- | --- |
| C1 | No issue, as CCCEV 2.0.0 broadens the definition. |
| C2 | **Minor issue,** as CCCEV 2.0.0 broadens the definition. A requirement does not have to be atomic anymore. Instead of the combination of Criterion and Criterion Requirement from v1.0.0, v2.0.0 gathers both terms under the Requirement class and its subclasses (Criterion, Information Requirement, Constraint). It is now up to the user of CCCEV to define where the atomicity level for requirements is. If there is a need for an atomic requirement then the user can reintroduce it or specify further one of the subclasses of Requirement. |
| C3 | **Minor issue,** as CCCEV 2.0.0 considers Criterion to be a Requirement for the purpose of evaluation or assessment. In practice, the usage of the class Criterion can be very similar between v1.0.0 and v2.0.0. |
| C4 | **Minor issue,** in addition to the assessment in C2, Information Requirement doesn't need to be an atomic requirement but is a specific type of requirement.|
| C5 | **Minor issue,** in addition to the assessment in C2, Constraint doesn't need to be an atomic requirement but is a specific type of requirement.|
| C6 | No issue, since CCCEV 2.0.0 proposes a new class. For a detailed motivation, please see the [Fundamental changes](https://github.com/SEMICeu/CCCEV/blob/80114908669b9258113c6858453b545cefb93646/releases/2.00/Changelog.md#making-requirements-machine-readable). |
| C7 | No issue, since CCCEV 2.0.0 proposes a new class. For a detailed motivation, please see the [Fundamental changes](https://github.com/SEMICeu/CCCEV/blob/80114908669b9258113c6858453b545cefb93646/releases/2.00/Changelog.md#making-requirements-machine-readable). |
| C8 | **Important difference**. Validity intervals are not explicitly included in CCCEV 2.0.0. |
| C9 | **Important difference but covered**. Version 2.0.0 offers two mechanisms to express a Requirements to be fulfilled. The set of Requirements that must be fulfilled is now captured by the class Requirement itself via the self-relationship _has Requirement_. Consequently, a Requirement can be divided in several more detailed Requirements. In addition, the Requirement can express the expected values of the response via the Evidence Type Lists. |
| C10 | **Important difference but covered.** The notion of a response (envelope) has not been explicitly included. However since an Evidence is a **subclass of dcat:Dataset,** the envelope (namely describing the data that has been provided as response to a Requirement) is equivalent with the notion of Evidence. |
| C11 | **Minor issue**, as both notions still refer to the data that supports the response to a Requirement. Note that the Evidence in version 2.0.0 covers any data that proves a requirement. It does not have to be an official certificate signed by a public government. |
| C12 | No issue, since CCCEV 2.0.0 proposes a new class. |
| C13 | No issue, since CCCEV 2.0.0 proposes a new class. |
| C14 | **Important difference but covered.** Instead of introducing a new class to describe the form, the serialization, etc. in which the Evidence is being supplied, CCCEV 2.0.0 relies on Evidence being the subclass of dcat:Dataset. As such a dcat:Dataset has a dcat:Distribution, which exactly covers this notion of a Document Reference. It even broadens the notion so that machine-readable distributions are also covered in CCCEV 2.0.0. |
| C15 | No issue, as CCCEV 2.0.0 broadens the definition. |
| C16 | No issue, since CCCEV 2.0.0 proposes a new class. |

The following assessment applies to the relationships in CCCEV mentioned in version 1.0.0 and their counterparts in version 2.0.0.

| Nr | CCCEV 1.0.0 relationship | CCCEV 2.0.0 relationship |
| --- | --- | --- |
| R1 | Criterion <em>**is defined in**</em> Formal Framework | Requirement <em>**is Derived From**</em> Reference Framework |
| R2 | Criterion <em>**fulfilled by**</em> Requirement Group | Requirement <em>**is Requirement Of**</em> Requirement |
| R3 | Requirement Group <em>**has**</em> Criterion Requirement | Requirement <em>**has Requirement**</em> Requirement |
| R4 | Criterion Requirement <em>**applicable in**</em> Period of Time | |
| R5 | Criterion Requirement <em>**met by**</em> Evidence | Requirement <em>**has Supporting Evidence**</em> Evidence |
| R6 | Agent <em>**satisfies**</em> Criterion | |
| R7 | Agent <em>**provides**</em> Requirement Response | |
| R8 | Requirement Response <em>**applies to**</em> Period of Time | |
| R9 | Requirement Response <em>**proven by**</em> Evidence | Requirement <em>**has Supporting Evidence**</em> Evidence |
| R10 | Evidence <em>**belongs to**</em> Agent | Evidence <em>**is About**</em> Agent |
| R11 | Evidence <em>**issued by**</em> Organisation | |
| R12 | Evidence <em>**is supported by**</em> Document Reference | |

One can observe that, for the key notions of Requirement and Evidence, version 2.0.0 covers the equivalent notions expressed in version 1.0.0 but often with a broader semantic match. Open discussions remain regarding the harmonisation of the role(s) an Agent can play and the temporal information. This proposition of considering Evidence as a subclass of dcat:Dataset opens this space for discussion. The expressed roles in version 1.0.0 can be covered by the roles expressed in DCAT in various ways. Similar arguments hold for temporal information. To tackle these aspects, a community consultation is appropriate.
From this mapping, several changes can be distinguished between CCCEV 1.0.0 and CCCEV 2.0.0. The discovered changes and how they are addressed in version 2.0.0 are described below:

| Nr | Assessment |
| --- | --- |
| R1 | No issue.|
| R2 | No issue, as Requirements can be grouped together into larger groups, similarly to CCCEV v1.0.0. |
| R3 | No issue, as Requirements can be grouped together into larger groups, similarly to CCCEV v1.0.0. |
| R4 | **Important difference.** Applicability period has not been retained in version 2.0.0. |
| R5 | No issue, <em>**has Supporting Evidence**</em> covers all kinds of Requirements, including Criteria. |
| R6 | **Important difference.** There is no statement in v2.0.0 about an Agent that satisfies the Criteria since v2.0.0 only emphasis the roles of the Agent related to evidences (Evidence is About Agent) and requirements (a Requirement issued By Agent). |
| R7 | **Important difference but covered.** Evidence is a subclass of dcat:dataset. The Agent which provides the response can be considered the publisher of the Evidence. To be decided if this is equivalent and if dct:publisher can be used for that role. |
| R8 | **Important difference.** The application period of the response is not covered. Note that dcat:Dataset has several temporal notions that could be used to express equivalent notions like temporal coverage (the period that the Dataset, i.e. Evidence is covering) or issue date (the time one which the Dataset, i.e. Evidence has been issued). |
| R9 | No issue, as Evidence (subclass of dcat:Dataset) corresponds to the Requirement Response notion. |
| R10 | No issue. |
| R11 | **Minor issue,** as Evidence (via subclass of dcat:Dataset) supports several interaction roles with Agents. It can be a dct:publisher, a dct:creator or another qualified role. |
| R12 | **Minor issue,** it corresponds to dcat:distribution as Evidence is a subclass of dcat:Dataset. |
