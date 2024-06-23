FROM python:3.8-slim

RUN pip install scrapydweb

EXPOSE 5000

CMD ["scrapydweb"]
