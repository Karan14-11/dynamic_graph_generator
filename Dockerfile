# Use a base image with Python and necessary system tools installed
FROM python:3.9-slim

# Install system-level dependencies (muparser, OpenMP, cmake, etc.)
RUN apt-get update && \
    apt-get install -y libmuparser-dev libomp-dev cmake pkg-config build-essential

# Set the working directory in the container
WORKDIR /app

# Copy the project files into the container
COPY . /app

# Create a build directory for the C++ project and build the C++ executable
RUN mkdir -p build && cd build && cmake .. && make

# Install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Expose the port that Django will run on
EXPOSE 8000

# Run Django server using gunicorn
CMD ["gunicorn", "dynamic_graphs.wsgi:application", "--bind", "0.0.0.0:8000"]

