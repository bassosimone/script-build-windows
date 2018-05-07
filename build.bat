@echo off
for %%I in (%*) do (
  bash.exe -c "PKG_ARCH=%VSCMD_ARG_HOST_ARCH% PKG_OS=windows ./%%I"
)
