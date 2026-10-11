# Website artifact intent

Status: proposed adoption plan. Assessment date: 2026-10-11.

This plan covers `000-222-ghostty-config-files`. It does not change the current application, data, dependencies, or publishing rules.

## Current implementation

Ubuntu terminal configuration.

Strength: Explicit platform limits.

Weakness or limit: Manual reference, Ubuntu-specific installer.

Evidence below establishes the documented implementation. No runtime performance comparison was completed. Where evidence is incomplete, the first task resolves that gap.

## Intended result

A configuration reference for supported platforms.

Adoption route: **Catalog**. Generate a reference only if useful, never execute the installer to build it.

Proposed artifact input: Reviewed configuration documentation. The artifact consumes a read-only snapshot. Canonical authority remains with the originals, ledgers and application stores defined in AGENTS.md. Derived views do not become authoritative records.

## Shared tools

Use uv, Python, Jinja2, local CSS, and small JavaScript modules for a new static report adapter. Keep an existing builder or native application when this route calls for one. Common metadata and checks connect that builder to the catalog.

Generate navigation, page records and search metadata from one artifact declaration. Pin the renderer and dependencies. A new artifact starts with an explicit audience, field selection, output mode and useful reader task.

Use JSON declarations and build records first. Add a rebuildable SQLite catalog when relational queries or dependency tracking justify it. Retain existing DuckDB analytics and PostgreSQL service stores. Do not migrate source data for presentation consistency.

## Project tasks

1. Record the exact entrypoint, reader task, source authority, output mode and existing validation commands.
2. Generate a reference only if useful, never execute the installer to build it.
3. Add contract metadata and output checks after the two-project pilot proves reuse.
4. Check source hashes, record parity, escaping, links and audience filtering against a stable input snapshot.
5. Measure build time, output bytes and browser readiness before adopting shared components.

For a catalog-only or deferred route, stop after the first task unless a reader task justifies an artifact. No runtime or database installation is required for this plan.

## Acceptance and limits

Keep this export local until its audience and permitted fields are approved.

Preserve original records and existing project tests. Test offline behavior where the project requires it. Missing tools mean incomplete checks. Keep publishing separate from building.

The [shared plan](https://github.com/kairin/000-0-workspace/blob/main/docs/website-artifacts/plan.md) defines task dependencies and review gates. This link targets the proposed documentation destination. It becomes available after a separate Git delivery workflow.

## Evidence

- [AGENTS.md](../AGENTS.md)
- [README.md](../README.md)

## Repair prerequisite

[Readiness and repair tasks](website-artifact-remediation.md) are part of this intent. Resolve known relevant findings and run missing checks before artifact adoption. Documentation of an open problem is not its resolution.
