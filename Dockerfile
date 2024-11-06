# Use the official .NET SDK image to build the application
# The '8.0' tag is for .NET 8.0 SDK
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory inside the container
WORKDIR /src

# Copy the .csproj file into the container's /src directory
# This allows Docker to restore dependencies before copying the entire source code
COPY ["TaskManagementAPI.csproj", "./"]

# Restore the project dependencies using the dotnet CLI
RUN dotnet restore "TaskManagementAPI.csproj"

# Now copy the rest of the project files (source code) into the container
COPY . .

# Publish the application in Release mode and place the output in /app/publish
# This prepares the application for production by compiling and copying necessary files
RUN dotnet publish -c Release -o /app/publish

# Use the official .NET runtime image to run the application
# This image is smaller as it only includes the runtime needed to run the application
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final

# Set the working directory for the final image to /app
WORKDIR /app

# Copy the published files from the build stage to the final image
COPY --from=build /app/publish .

# Set the entry point for the container
# This command runs your application when the container starts
ENTRYPOINT ["dotnet", "TaskManagementAPI.dll"]
