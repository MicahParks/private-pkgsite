FROM gomods/athens

# Copy in the private cert to trust for Gitlab.
COPY root.crt /usr/local/share/ca-certificates/

# Set up the internal proxy.
# TODO Edit this line.
ENV HTTP_PROXY http://internal.proxy.com:80
# TODO Edit this line.
ENV HTTPS_PROXY http://internal.proxy.com:80

# Update the public certs and add the private cert.
RUN apk --no-cache add ca-certificates && \
update-ca-certificates
