@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0compare-arm.ps1" %*
