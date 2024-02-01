# Core Criterion and Core Evidences Vocabulary Changelog

## Introduction


This document describes the (major) changes to [the current version 2.0.0](https://github.com/SEMICeu/CCCEV/tree/master/releases/2.00) of the Core Criterion and Core Evidences Vocabulary for which a new version is being proposed ([version 2.1.0](https://semiceu.github.io/CCCEV/releases/2.1.0/)). The list of changes results in the new version to be considered as a minor release.

## Detailed changes from v2.0.0 to v2.1.0

The table below gives an overview of the classes (and their definitions) within both data models. Classes that are related are juxta-positioned.

**C** stands for changes in classes

**R** stands for changes in relationships

**P** stands for changes in properties

**D** stands for changes in data types

| Nr | CCCEV v2.0.0 | CCCEV v2.1.0 | Rationale | GitHub / Change |
| -- | ------------ | ------------ | --------- | --------------- |
| - | - | ReSpec Styling has been applied to the specification.| - | - |
| D1  | PeriodOfTime:endtime - xsd:dateTime | PeriodOfTime:endtime - time:Instant | The URIs from W3C are used but they have the wrong range for endTime. | [#52](https://github.com/SEMICeu/CCCEV/issues/52) |
| D2  | PeriodOfTime:starttime - xsd:dateTime | PeriodOfTime:starttime - time:Instant | The URIs from W3C are used but they have the wrong range for startTime. | [#52](https://github.com/SEMICeu/CCCEV/issues/52) |
| P1  | Evidence:isProvidedBy | Evidence:isProvidedBy | The phrasing used in the usage note of isPorividedBy is revised. It should now align better with the meaning of the property. | [#47](https://github.com/SEMICeu/CCCEV/issues/47) |
| C1  | CCCEV:Evidence - dcat:Dataset | CCCEV:Evidence | CCCEV:Evidence should not be a DCAT:Dataset. | [#46](https://github.com/SEMICeu/CCCEV/issues/46) |
