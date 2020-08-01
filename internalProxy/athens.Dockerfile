FROM gomods/athens

# Set up the internal proxy.
# TODO Edit this line.
ENV HTTP_PROXY http://internal.proxy.com:80
# TODO Edit this line.
ENV HTTPS_PROXY http://internal.proxy.com:80

# Update the public certs.
RUN apk --no-cache add ca-certificates
