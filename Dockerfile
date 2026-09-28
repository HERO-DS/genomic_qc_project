# 1. Start from an official, lightweight Python base image
FROM python:3.11-slim

# 2. Set the working directory inside the container
WORKDIR /app

# 3. Install pandas directly inside the container
RUN pip install --no-cache-dir pandas

# 4. Copy our Python scripts and sample data from our computer into the container
COPY 01_import_and_inspect.py .
COPY 02_clean_data.py .
COPY 03_summary_metrics.py .
COPY sample_reads.csv .

# 5. Default command to run when the container starts
CMD ["sh", "-c", "python 02_clean_data.py && python 03_summary_metrics.py"]


