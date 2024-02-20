# Use the official PostgreSQL image as the base image
FROM postgres:16

# Install dependencies required for compiling pgvector extension
RUN apt-get update \
    && apt-get install -y \
        build-essential \
        postgresql-server-dev-16 \
        git \
        python3 \
        python3-dev \
        python3-pip

# Clone pgvector repository and compile the extension
RUN git clone https://github.com/pgvector/pgvector.git \
    && cd pgvector \
    &&  cp sql/vector.sql sql/vector--0.6.0.sql \
    && make install

# Enable the pgvector extension
# RUN echo "shared_preload_libraries = 'pg_stat_statements,pgvector'" >> /usr/share/postgresql/postgresql.conf.sample

# Install PL/Python for Python 3
RUN apt-get install -y postgresql-plpython3-16

# Expose the PostgreSQL port
EXPOSE 5432
