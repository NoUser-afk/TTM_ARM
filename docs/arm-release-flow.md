# ARM Release Flow

This repository keeps production and test 1C ARM dumps in Git so approved changes can be moved selectively.

## Branches

- `prod` is the production baseline. Update it only from an actual production dump.
- `test` is the test baseline. Update it from the test database dump after new work is done.
- `release/<name>` starts from `prod` and receives only approved files or hunks from `test`.

`main` currently mirrors the initial test dump and can stay as a compatibility branch. Use `test` for day-to-day test updates.

## Normal Workflow

1. Make and test a change in the 1C test database.
2. Export the test database configuration to files.
3. Commit that export to `test`.
4. Compare `prod` and `test`.
5. Start a release branch from `prod`.
6. Move only approved files from `test` into the release branch.
7. Review the release diff against `prod`.
8. Load the release files into a staging copy of 1C and verify.
9. Load into production.
10. Export production again and update `prod`.

## Commands

Compare production and test:

```powershell
.\scripts\compare-arm.ps1
```

Create a release branch from production:

```powershell
.\scripts\start-release.ps1 -Name 2026-07-02-arm
```

Take approved files from `test` into the current release branch:

```powershell
.\scripts\take-from-test.ps1 -Path "CommonModules/ТТМ_Производство/Ext/Module.bsl"
.\scripts\take-from-test.ps1 -Path "Documents/ОтгрузкаТоваровСХранения/Forms/ФормаСписка.xml","Documents/ОтгрузкаТоваровСХранения/Forms/ФормаСписка/Ext/Form.xml"
```

Review selected changes:

```powershell
git diff --stat prod..HEAD
git diff --name-status prod..HEAD
```

Commit and push the release:

```powershell
git add -A
git commit -m "Prepare selected ARM changes"
git push -u origin HEAD
```

## Rules

- Do not merge all of `test` into `prod`.
- Keep each release branch short-lived.
- Prefer moving whole 1C object files only when the object is fully approved.
- For mixed files, inspect the diff and apply only the approved hunks manually.
- After production is updated, refresh `prod` from a new production export.
