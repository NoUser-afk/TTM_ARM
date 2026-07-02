@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0start-release.ps1" -Name %*
