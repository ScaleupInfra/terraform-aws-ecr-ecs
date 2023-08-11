FROM squidfunk/mkdocs-material 

WORKDIR /docs

COPY . .

ENV PORT=8000