FROM golang AS builder

# Set up the internal proxy.
# TODO Edit this line.
ENV HTTP_PROXY http://internal.proxy.com:80
# TODO Edit this line.
ENV HTTPS_PROXY http://internal.proxy.com:80

# Clone the pkgsite repository.
RUN git clone "https://go.googlesource.com/pkgsite" && \
cd pkgsite && \

# Bind the service to 0.0.0.0 so Docker can use it.
sed -i 's|addr := cfg.HostAddr("localhost:8080")|addr := cfg.HostAddr("0.0.0.0:8080")|' cmd/frontend/main.go && \

# Add the ability to view projects with non permissive licenses.
sed -i 's|od.Redistributable = false|od.Redistributable = true|' internal/frontend/overview.go && \
sed -i 's|Redistributable:  vdir.Directory.IsRedistributable,|Redistributable: true,|' internal/frontend/overview.go && \
sed -i 's|Redistributable: isRedistributable,|Redistributable: true,|' internal/frontend/overview.go && \
sed -i 's/if canShowDetails {/if canShowDetails = true || canShowDetails; true {/g' internal/frontend/module.go && \
sed -i 's/if canShowDetails {/if canShowDetails = true || canShowDetails; true {/g' internal/frontend/package.go && \

# Build the pkgsite executable.
CGO_ENABLED=0 GOOS=linux go build -ldflags "-s -w" -a -installsuffix cgo -o /pkgsite cmd/frontend/main.go

# This is the image you'll actually run.
FROM alpine

# Set up the internal proxy.
# TODO Edit this line.
ENV HTTP_PROXY http://internal.proxy.com:80
# TODO Edit this line.
ENV HTTPS_PROXY http://internal.proxy.com:80

# Update public certs.
RUN apk --no-cache add ca-certificates

# Turn off the internal proxy.
ENV HTTP_PROXY ""
ENV HTTPS_PROXY ""

# Copy required stuff from builder.
COPY --from=builder /pkgsite /
COPY --from=builder /go/pkgsite/content /content
COPY --from=builder /go/pkgsite/third_party /third_party

# Set the startup command.
CMD ["/pkgsite"]
