# Use an official Python image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Copy the application files into the container
COPY requirements.txt .  
RUN pip install --upgrade pip && pip install -r requirements.txt gunicorn

# Copy the rest of the application code into the container
COPY . .

# Expose the port Flask runs on
EXPOSE 8080

# Run the application with Gunicorn
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 "app:create_app()"