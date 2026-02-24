[//]: # (“What problem is this system solving, and at what level of ambition?”)

# Project: Spec-Driven Development (SDD) with AI — Teaching Repository

## Project purpose (what problem, and level of ambition)

This repository exists to teach **Spec-Driven Development (SDD)** using an AI assistant as a *constrained implementation partner*. The core problem it addresses is: teams often struggle to reliably translate business intent into working software while keeping a clear, auditable trail from **spec → plan → implementation → verification**. This repo demonstrates a workflow where the **business specification** is written in Cucumber/Gherkin first, and technical work is derived from that spec.

The ambition level is **production-grade in practices, but intentionally small in scope**. We aim to model professional standards (clear boundaries, repeatable process, tests/acceptance criteria, maintainable code), while keeping the codebase readable and classroom-friendly. The goal is not to “ship a product,” but to provide a dependable reference for how to work from specifications with AI assistance.

## Target audience / users

- Students in the class learning SDD and AI-assisted development
- Instructors/demo facilitators
- Developers who want a concrete example of turning Gherkin into planned engineering tasks
- Readers who want a “how the sausage is made” reference for spec → tasks → implementation

## Non-goals (very important)

- Not a complete product roadmap or a feature-rich application
- Not a showcase of advanced frameworks, patterns, or “best possible” architecture
- Not a performance benchmark, scalability demonstration, or cloud deployment template
- Not a place for broad refactors, style wars, or exploring alternative designs
- Not an exhaustive tutorial with step-by-step setup or execution instructions

## High-level constraints

- **Business language lives in Cucumber**: Gherkin scenarios are the source of truth for behavior.
- **AI produces technical tasks, not business specs**: tasks are derived from Gherkin and tracked as engineering work.
- **Tasks are planned and stored in `.ai-tasks/`**:
    - Must be written in Markdown
    - Must use checkboxes (`- [ ]`) so progress is visible and reviewable
- **Readable over clever**: prioritize clarity and teaching value.
- Keep changes scoped to the current learning objective and spec.

## “Teaching repo” principles

- Prefer explicitness over abstraction.
- Prefer small, inspectable steps over “one big rewrite.”
- Prefer examples that demonstrate workflow and reasoning, not novelty.

## “Reference architecture” (at a glance)

This repo provides a **reference workflow** more than a fixed architecture:
- Business behavior is specified in Gherkin.
- Technical work is decomposed into planned tasks in `.ai-tasks/`.
- Implementation proceeds incrementally with verification (tests/acceptance) aligned to the spec.

(Architectural details belong in `architecture.md`, not here.)

## “Production-grade but readable”

We aim to demonstrate:
- disciplined scope control
- predictable, reviewable changes
- tests/acceptance checks tied to behavior
- simple, maintainable code structure

…but we avoid over-engineering. If a “real production” choice would add complexity without teaching value, we choose the simpler option.

## Module overview (brief)

- `.memory-bank/` — shared context for AI and humans (this file, architecture notes, agent rules)
- `.ai-tasks/` — planned technical tasks derived from business specs (Markdown with checkboxes)
- `full-application-acceptance/` — acceptance-level behavior checks (driven by Cucumber features)
- `full-application/` — application code used to satisfy the spec (kept straightforward)
- `caesar-shift/` — smaller exercises / supporting examples for TDD and design-for-testability
- Root `pom.xml` and module `pom.xml` files — build configuration for the multi-module project

## Quality bar

- **Correctness > cleverness**
- **Traceability > speed** (link work back to the spec and the plan)
- **Small PRs / small changes > sweeping edits**
- **Tests and acceptance checks should match the spec language**
- **Clarity > abstraction** (especially for classroom discussion)
- If information is missing or ambiguous, **stop and ask** rather than guessing
