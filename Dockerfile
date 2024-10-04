# Use a lightweight Python image
FROM python:3.9-slim

# Install system dependencies (e.g., muparser, OpenMP)
RUN apt-get update && \
    apt-get install -y libmuparser-dev libomp-dev

# Set the working directory inside the container
WORKDIR /app

# Copy your entire project into the container
COPY . /app

# Copy the already compiled C++ executable (assumed to be in the root)
COPY ./main /usr/local/bin/  # Adjust if your executable is named differently
RUN chmod +x /usr/local/bin/main

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Collect static files for Django (optional)
#RUN python manage.py collectstatic --noinput

# Expose port 8000 for Django
EXPOSE 8000

# Set the environment variables
ENV DJANGO_SETTINGS_MODULE=dynamic_graphs.settings
ENV PYTHONUNBUFFERED=1

# Start the Django app using gunicorn
CMD ["gunicorn", "dynamic_graphs.wsgi:application", "--bind", "0.0.0.0:8000"]

