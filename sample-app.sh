#!/bin/bash
set -euo pipefail

# 1. Zorg voor een schone werkdirectory
rm -rf tempdir
mkdir -p tempdir/templates tempdir/static

# 2. Kopieer benodigde bestanden
cp sample_app.py tempdir/
cp -r templates/* tempdir/templates/
cp -r static/* tempdir/static/

# 3. Genereer de Dockerfile
cat > tempdir/Dockerfile << '_EOF_'
FROM python
RUN pip install --no-cache-dir flask
COPY ./static /home/myapp/static/
COPY ./templates /home/myapp/templates/
COPY sample_app.py /home/myapp/
EXPOSE 5050
CMD ["python", "/home/myapp/sample_app.py"]
_EOF_

# 4. Bouw de image
cd tempdir
docker build -t sampleapp .


docker rm -f samplerunning 2>/dev/null || true


docker run -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a --filter "name=samplerunning"