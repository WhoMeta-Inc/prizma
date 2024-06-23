# Verwenden Sie ein offizielles Python-Image als Basis
FROM python:3.8-slim

# Installieren Sie die notwendigen Pakete
RUN apt-get update && apt-get install -y gcc libxml2-dev libxslt-dev libffi-dev

# Setzen Sie das Arbeitsverzeichnis im Container
WORKDIR /app

# Kopieren Sie den Inhalt des Repositories in den Container
COPY . .
RUN cp -r /app/scrapydweb/data /app/
RUN chmod +x /app/scrapydweb/*.py
RUN python /app/setup.py install


# Installieren Sie die notwendigen Python-Bibliotheken
RUN pip install --no-cache-dir -r requirements.txt
#RUN python -m spacy download de_core_news_sm
# Exponieren Sie die Ports für scrapyd und scrapydweb
EXPOSE 6800 5000

# Verwenden Sie supervisord, um scrapyd und scrapydweb gleichzeitig auszuführen
RUN apt-get install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# RUN mkdir /app/data



# Starten Sie supervisord, um beide Prozesse zu verwalten
CMD ["/usr/bin/supervisord"]
