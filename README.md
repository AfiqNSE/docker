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
  
  - **golang_jwe_authentication**
   ```golang
    func main() {
    	engine := gin.Default()
      
    	// engine.Use(checkIP)
    	engine.NoRoute(noRouteHandler)
    
    	controller.InitToken(engine)
    
    	engine.Run("0.0.0.0:" + common.Global.GetPort())
    }
    ```
  - **notification**
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

### Run Docker
```Dockerfile
# Build all docker images and create a container to run all docker images
docker-compose up

# Build specific docker images
docker build -t [docker-image-name]:[docker-image-tag] -f files/[docker-file-name] ../[docker-build-context-directory]
```

###



