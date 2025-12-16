# Base image: Ruby 3.2 on Alpine (lightweight and secure)
FROM ruby:3.2-alpine

# Create group and user (non-root)
RUN addgroup --system fibscale \
 && adduser --system --ingroup fibscale fibscale

# Install build dependencies
RUN apk add --no-cache g++ make patch

# Set working directory
WORKDIR /fibscale

# Copy application files with correct ownership
COPY --chown=fibscale:fibscale ./ ./

# Ensure working directory ownership
RUN chown -R fibscale:fibscale /fibscale

# Switch to non-root user
USER fibscale

# Install Ruby dependencies
RUN bundle install

# Document exposed port
EXPOSE 3000

# Launch the application
CMD ["ruby", "fibscale.rb"]
