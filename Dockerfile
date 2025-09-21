FROM python:3.9

# Set working directory
WORKDIR /app/backend

# Copy only requirements first
COPY requirements.txt /app/backend

# Install system dependencies
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy only necessary app code (avoid MySQL data)
COPY backend/ /app/backend

# Expose port
EXPOSE 8000

# Run Django app on 0.0.0.0
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

