FROM squidfunk/mkdocs-material 

WORKDIR /app

COPY . .

ENV PORT=8000