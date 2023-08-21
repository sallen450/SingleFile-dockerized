FROM ghcr.io/puppeteer/puppeteer 

USER root

RUN apt-get update \
  && apt-get install --no-install-recommends -y \
  python3 python3-pip python3-setuptools

RUN npm install -g "single-file-cli" \
  && npm cache clean --force

WORKDIR /opt/app

COPY requirements.txt .
COPY webserver.py .

RUN pip3 install \
  --break-system-packages \
  --no-cache-dir \
  --no-warn-script-location \
  --user \
  -r requirements.txt

RUN rm requirements.txt

ENTRYPOINT ["single-file", "--browser-executable-path=/opt/google/chrome/google-chrome", "--browser-args='[\"--no-sandbox\"]'", "--dump-content"]
