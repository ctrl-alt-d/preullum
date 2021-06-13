CALL flutter build web
CALL rmdir .\docs /S /Q
CALL mkdir .\docs 
CALL xcopy .\build\web .\docs /E/H
CALL echo "Recorda canviar el base: <base href="/preullum/">"