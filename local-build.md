# What the script does
The script allows to build the entire system on your local machine, while selecting only mentioned services to be built  
from your local version, and the rest being the latest from the git rep.

# How to use
## requirments
- python interpeter / virtual env manager (conda, ...)
- the yaml package for python. if not installed then run: ` pip install pyyaml `

## running
- run the script with: ```python local_buikd_script.py```
- for each *local* service, enter his name like it is specified in the `compose.yaml` file, and then the path to his Dockerfile in your local folder, as specified by the scripts prompt
- after entering all the local services, write `None` to the script prompt and the script should run.

# What the script does
the script create a copy of the compose.yaml file called `docker-compose.override.yaml` and for each service entered,  
it replaces the `image` attribute with a `build` attribute and adds to it a sub-attribute called `context` which holds the path to the service's Dockerfile, allowing it to build your local version of the service.

# What next?
after running the script once, your new compose file remains in your system, and you can still use it (only if you don't want to change what is running locally).
To run the new compose file directly, use the following commands:
```bash
docker-compose -f compose.yaml -f docker-compose.override.yaml build
```
```bash
docker-compose -f compose.yaml -f docker-compose.override.yaml up
```