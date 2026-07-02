@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0take-from-test.ps1" -Path %*
