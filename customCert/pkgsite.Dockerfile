FROM golang AS builder

# Clone the pkgsite repository.
RUN git clone "https://go.googlesource.com/pkgsite" && \
cd pkgsite && \

# TODO Try to use the latest commit. This is the most recent commit that is know to work with this project: 2020/08/01
git checkout 94d940ab81bcb78978c6f28b8a265b418a7054e0 && \

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

# Update public certs.
RUN apk --no-cache add ca-certificates

# Copy required stuff from builder.
COPY --from=builder /pkgsite /
COPY --from=builder /go/pkgsite/content /content
COPY --from=builder /go/pkgsite/third_party /third_party

# Set the startup command.
CMD ["/pkgsite"]
