# Core Criterion and Core Evidences Vocabulary

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
| P1  | PeriodOfTime:endtime - xsd:dateTime | PeriodOfTime:endtime - time:Instant | The URIs from W3C are used but they have the wrong range for endTime. | [#52](https://github.com/SEMICeu/CCCEV/issues/52) |
| P2  | PeriodOfTime:starttime - xsd:dateTime | PeriodOfTime:starttime - time:Instant | The URIs from W3C are used but they have the wrong range for startTime. | [#52](https://github.com/SEMICeu/CCCEV/issues/52) |
| P3  | Evidence:isProvidedBy | Evidence:isProvidedBy | Phrasing of the usage note of isPorividedBy should be the other way around. | [#47](https://github.com/SEMICeu/CCCEV/issues/47) |
| C1  | CCCEV:Evidence - dcat:Dataset | CCCEV:Evidence | CCCEV:Evidence should not be a DCAT:Dataset. | [#47](https://github.com/SEMICeu/CCCEV/issues/47) |
