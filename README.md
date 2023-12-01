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
- Docker optimization configuration
  > To manage and optimize the disk space/memory/CPU/etc. used by Linux distributions installed using WSL 2.
  - Create a new `.wslconfig` file at `C:\Users\{YourUser}`, and paste the configuration below.
    
    ```
    # Settings apply across all Linux distros running on WSL 2
    [wsl2]
    
    # Limits VM memory to use no more than 4 GB, this can be set as whole numbers using GB or MB
    memory=4GB 
    
    # Sets the VM to use two virtual processors
    processors=2
    ```
    
  - Open PowerShell/CMD as Administrator, and run the command below.
    > NOTE: Other than Windows Home edition
    ```
    # Close all WSL terminals and run this to fully shut down WSL.
    wsl.exe --shutdown
    
    # Replace your Windows user name. This is where Docker stores its VM file.
    cd C:\Users\{YourUser}\AppData\Local\Docker\wsl\data
    
    # Compact the Docker Desktop WSL VM file and you're done.
    optimize-vhd -Path .\ext4.vhdx -Mode full
    ```
    
    > NOTE: For Windows Home Edition
    ```
    # Replace your Windows user name.
    diskpart
    select vdisk file="C:\Users\{YourUser}\AppData\local\Docker\wsl\data\ext4.vhdx"
    attach vdisk readonly
    compact vdisk
    detach vdisk
    ```

### Run Docker
> NOTE: Main use is docker-compose up
```Dockerfile
# Starts the defined services, creating and starting containers as specified in the docker-compose.yml file.
docker-compose up

# Builds or rebuilds services defined in the docker-compose.yml file. Useful when there are changes in the configuration or Dockerfiles.
docker-compose build

# Build specific docker images
docker build -t [docker-image-name]:[docker-image-tag] -f files/[docker-file-name] ..
```
 - Example multi-container Docker application using a `docker-compose up`
   > Docker Images
   ![image](https://github.com/AfiqNSE/docker/assets/146927713/b7b211f1-6103-428a-8912-97c7e721b5ff)
   
   > Docker Multi-Container
   ![image](https://github.com/AfiqNSE/docker/assets/146927713/be6ef8af-6ebf-4e76-8180-6348c5702b71)




