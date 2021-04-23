# Mapping to W3C Verifiable Credentials

Relevant link: https://www.w3.org/TR/vc-data-model/

## Introduction
The W3C Recommendation on Verifiable Credentials (VC) explores the same context as CCCEV but addresses it from a different perspective. As specified within the Recommendation:
>VC provides a standard way to express credentials on the Web in a way that is cryptographically secure, privacy respecting, and machine-verifiable.

The focus of VC is thus more on sharing the expressed credentials in a cryptographically secured way.
It provides a coherent way on how to connect signatures and proofs to the data into a single atomic unit.

## Mapping
### Claim and credential
From a business perspective, positioning credentials in CCCEV, they are part of the CCCEV response side, namely information related to cccev:Evidence.
The request aspect which is prominent in CCCEV (i.e. cccev:Requirement) is out of scope for VC.

The VC notions "claim" and "credential" are covered by cccev:Evidence and cccev:SupportedValue.
However, not in a one-to-one mapping.
A vc:claim is a single statement; a vc:credential is a collection of vc:claims.
A cccev:Evidence is data proving that a cccev:Requirement is met or has been fulfilled.
So it can be a single statement or a collection, meaning that cccev:Evidence can be both a vc:credential as well as a vc:claim.

A cccev:SupportedValue is a value for a cccev:InformationConcept that is supported by a cccev:Evidence.
So a cccev:Evidence can be anything that provides support for a statement. In that case cccev:SupportedValue and vc:claim can coincide.

### Evidence
A last interpretation is expressed in https://www.w3.org/TR/vc-data-model/#evidence, as VC also introduces the notion of evidences;
mostly to capture information that is non machine-processable which is supporting a vc:credential.

Quote:
>Evidences can be included by an issuer to provide the verifier with additional supporting information in a verifiable credential.

In CCCEV, Evidence is thus broader than the notion of vc:evidence. In CCCEV, all responses to a request are called cccev:Evidence.
In VC the nature of the reponse data is decisive for it to be called a vc:claim or vc:evidence.
Namely, if it is machine-processable then it is most likely a vc:claim, otherwise a vc:evidence.

## Conclusion
VC offers an approach to address the challenges that are related to establishing trust in data about a subject in a distributed context which is not part of CCCEV.
In order to combine both, a dedicated application profile of CCCEV for VC has to be created to limit the interpretation options.
