FROM gomods/athens

# Copy in the private cert to trust for Gitlab.
COPY root.crt /usr/local/share/ca-certificates/

# Update the public certs and add the private cert.
RUN apk --no-cache add ca-certificates && \
update-ca-certificates
