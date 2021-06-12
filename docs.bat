CALL flutter build web
CALL del .\docs /F /Q
CALL mkdir .\docs
CALL xcopy .\build\web .\docs /E/H