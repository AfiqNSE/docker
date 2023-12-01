# Docker

Docker to handle all of the NSE backend services.
- nse-driver-golang-backend
- golang_jwe_authentication
- notification
- order_management_system

## Quick Start

### Setup
- Change listening on `localhost:[PORT]` to `0.0.0.0:[PORT]` for all of the services.
- For some services, disable the `engine.Use(checkIP)`.
  
  - **Golang_jwe_authentication Service**
    
   ```golang
    func main() {
    	engine := gin.Default()
      
    	// engine.Use(checkIP)
    	engine.NoRoute(noRouteHandler)
    
    	controller.InitToken(engine)
    
    	engine.Run("0.0.0.0:" + common.Global.GetPort())
    }
    ```
   
  - **Notification Service**
    
   ```golang
    func main() {
    	engine := gin.Default()
    
    	// engine.Use(checkIP)
    	engine.NoRoute(noRouteHandler)
    
    	controller.InitOms(engine)
    	controller.InitIod(engine)
    
    	engine.Run("0.0.0.0:4000")
    }
    ```
- WSL Configuration file
  > To manage and optimize the disk space/memory/CPU/etc. used by Linux distributions installed using WSL 2. 

### Run Docker
```Dockerfile
# Starts the defined services, creating and starting containers as specified in the docker-compose.yml file.
docker-compose up

# Builds or rebuilds services defined in the docker-compose.yml file. Useful when there are changes in the configuration or Dockerfiles.
docker-compose build

# Build specific docker images
docker build -t [docker-image-name]:[docker-image-tag] -f files/[docker-file-name] ..
```

###



