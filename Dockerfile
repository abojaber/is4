FROM microsoft/aspnetcore-build:2.0 AS build-env

WORKDIR /app

COPY ./IdentityServer4/src/IdentityServer4/ ./IdentityServer4/
COPY ./IdentityServer4/src/Host/ ./Host

WORKDIR /app/Host
RUN dotnet restore

RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/aspnetcore:2.0
WORKDIR /app

COPY --from=build-env /app/Host/out .
ENTRYPOINT ["dotnet", "Host.dll"]

EXPOSE 80
