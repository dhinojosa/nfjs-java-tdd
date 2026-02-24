[//]: # (“What architectural rules may never be violated?”)

# Architecture Constitution (Non‑Negotiables)

This document defines the **structural rules and dependency constraints** for the repository.  
It is intentionally **not** a description of business behavior, workflows, or feature logic.

## 1) Architectural style(s)

### Primary style: Hexagonal Architecture (Ports & Adapters)
- The system is organized around a **domain core** with **ports** (interfaces) that describe what the domain/application needs.
- Technology concerns live in **adapters** (infrastructure), plugged in from the outside.

### Supporting style: Layered boundaries
We use a simple inward-facing dependency flow:
1. **Domain** (pure model and domain services)
2. **Application** (use cases / orchestration)
3. **Infrastructure** (IO, frameworks, persistence, web, messaging, etc.)
4. **Acceptance harness** (Cucumber tests and glue; drives the system from the outside)

## 2) DDD boundaries (lightweight, but enforced)

### Bounded contexts
- When the repo introduces multiple domains or subdomains, they must be separated into **explicit bounded contexts**.
- A bounded context boundary implies:
    - separate packages/modules where practical
    - explicit translation at boundaries (no “shared domain model” across contexts)

### Aggregates (rule-of-thumb)
- Aggregates are allowed and encouraged when needed, but must remain:
    - small
    - consistency-focused
    - enforceable without infrastructure
- Cross-aggregate consistency must be handled at the **application layer** (or via explicit domain events), not by reaching into repositories from the domain.

## 3) Layering & dependency rules (hard rules)

### The dependency direction must always point inward
- **Domain has no dependencies** on:
    - infrastructure/frameworks (web, DB, DI containers, Cucumber, logging frameworks, JSON libs, etc.)
    - application layer
    - test frameworks
- **Application depends on Domain** (and only Domain).
- **Infrastructure depends inward** on Application and/or Domain.

### Forbidden dependencies (never allowed)
- **Infrastructure → Domain** is allowed, but **Domain → Infrastructure** is forbidden.
- **Acceptance tests (Cucumber) are not a runtime dependency** of production code:
    - production modules must not depend on acceptance modules
    - acceptance code may depend on application/infrastructure to bootstrap the system

### Ports & adapters rules
- **Ports live inward** (Domain or Application).
- **Adapters live outward** (Infrastructure).
- A port must be technology-agnostic:
    - no HTTP types, no JDBC types, no framework annotations, no container concepts.
- Infrastructure adapters implement ports and handle mapping/translation at the edge.

## 4) Module boundaries (repo-level rules)

This repository is multi-module. Boundaries matter.

### `full-application/` (production application)
- Contains application + domain + infrastructure necessary to run the system.
- Must follow the inward dependency rules above.
- Must not include acceptance glue or Cucumber-specific wiring.

### `full-application-acceptance/` (acceptance harness)
- Contains Cucumber features, step definitions, and test-only wiring to drive the system.
- May depend on the production application modules to run tests.
- Must not become a second implementation of business logic; it is a driver, not a domain.

### Other modules (e.g., exercises like `caesar-shift/`)
- May be used for teaching/testing practice.
- Still should respect: domain purity, clear dependencies, and no framework creep into the domain core.

## 5) Package / naming conventions that affect structure

These conventions exist to make boundaries visible:

- Use explicit package names to reflect layer intent, such as:
    - `..domain..` for domain model/services
    - `..application..` for use cases / orchestration
    - `..infrastructure..` for adapters (persistence, web, clients, configuration)
- Ports should be named as capabilities, not technologies:
    - `*Port`, `*Gateway`, `*Repository` (only if repository is truly a port)
- Adapters should be named by technology or direction:
    - `*Adapter`, `*JpaAdapter`, `*HttpClientAdapter`, `*InMemoryAdapter`
- Test code should be explicit about level:
    - `*Test` (unit)
    - `*IT` or `*IntegrationTest` (integration)
    - Cucumber features remain in acceptance module resources

(Exact package names can evolve, but the **layer intent must remain obvious**.)

## 6) Dependency rules for libraries/frameworks

- Framework annotations/configuration belong in **infrastructure** (or test/acceptance), not in domain.
- Serialization/mapping concerns belong at the edges (in adapters), not inside domain entities.
- Logging and observability:
    - domain should not depend on logging frameworks
    - application/infrastructure may log, but avoid leaking framework types inward

## 7) Testing strategy (high level)

### Unit tests
- Target: domain and application logic.
- Must run fast and not require external systems.
- Prefer deterministic tests with minimal mocking.

### Integration tests
- Validate infrastructure adapters against real implementations (DB, filesystem, HTTP stubs, etc.) when introduced.
- Keep them isolated and clearly labeled; they should not replace unit tests.

### Acceptance tests
- Live in `full-application-acceptance/`.
- Express behavior in Gherkin and drive the system from the outside.
- Acceptance tests validate end-to-end wiring and primary flows, not internal design.

## 8) Enforcement & change policy

- These rules are the **constitution**: changes require explicit intent and review.
- If a change would violate a rule, stop and:
    1) explain the conflict,
    2) propose compliant alternatives,
    3) ask for a decision before proceeding.
