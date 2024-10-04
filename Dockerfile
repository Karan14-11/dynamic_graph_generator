# Use a lightweight Python image
FROM python:3.9-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y libmuparser-dev libomp-dev

# Set the working directory inside the container
WORKDIR .

# Copy the entire project into the container

# Ensure the main executable is in the right place

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Expose port 8000 for Django
EXPOSE 8000

# Set environment variables for Django
ENV DJANGO_SETTINGS_MODULE=dynamic_graphs.settings
ENV PYTHONUNBUFFERED=1

# Start the Django app using gunicorn
CMD ["gunicorn", "dynamic_graphs.wsgi:application", "--bind", "0.0.0.0:8000"]

