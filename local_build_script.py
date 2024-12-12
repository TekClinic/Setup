import yaml
import subprocess
import sys
import os


def generate_compose(service_names,dockerfile_paths, input_compose_path="compose.yaml",
                     output_compose_path="docker-compose.override.yaml"):
    
    if len(service_names) == 0:
        try:
            subprocess.run(["docker-compose", "-f", "compose.yaml", "build"], check=True)
            subprocess.run(["docker-compose", "-f", "compose.yaml", "up"], check=True)
        except subprocess.CalledProcessError as e:
            print(f"Error during docker-compose execution: {e}")

    # Validate Dockerfile path
    for dockerfile_path in dockerfile_paths:
        if not os.path.isfile(dockerfile_path):
            print(f"Error: Dockerfile not found at {dockerfile_path}")
            sys.exit(1)

    # Extract service name from the Dockerfile path
    #service_name = os.path.basename(os.path.dirname(dockerfile_path))

    # Load the original docker-compose file
    with open(input_compose_path, "r") as file:
        compose_data = yaml.safe_load(file)

    # Modify the services to build the specified service locally
    services = compose_data.get("services", {})
    for service_name, dockerfile_path in zip(service_names, dockerfile_paths):
        if service_name in services:
            config = services[service_name]
            # Replace 'image' with 'build'
            if "image" in config:
                del config["image"]
            config["build"] = {"context": os.path.dirname(dockerfile_path)}

    # Ensure all other services use images remotely
    for svc, config in services.items():
        if svc not in service_names:
            if "build" in config:
                del config["build"]
            if "image" not in config:
                config["image"] = f"{svc}:latest"  # Placeholder for remote image

    # Save the modified compose file
    with open(output_compose_path, "w") as file:
        yaml.dump(compose_data, file)

    print(f"Docker Compose file generated: {output_compose_path}")

    # Run docker-compose commands
    try:
        subprocess.run(["docker-compose", "-f", input_compose_path, "-f", output_compose_path, "build"], check=True)
        subprocess.run(["docker-compose", "-f", input_compose_path, "-f", output_compose_path, "up"], check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error during docker-compose execution: {e}")


def get_all_service_names(input_compose_path="compose.yaml") -> set[str]:
    with open(input_compose_path, "r") as file:
        compose_data = yaml.safe_load(file)
        services = compose_data.get("services", {})
        return set(services.keys())


def print_service_names():
    print('Available services are:')
    for name in sorted(get_all_service_names()):
        print('- ' + name)


if __name__ == "__main__":
    print_service_names()
    service_names = []
    services_paths = []
    input_prompt = "Enter service name to run from local code (or None to stop): "
    res = input(input_prompt)
    while res.lower() != "none":
        service_names.append(res)
        res_path = input(f"Enter {res}'s DOCKERFILE path: ")
        services_paths.append(res_path)
        res = input(input_prompt)
    # if len(sys.argv) != 3:
    #     print("Usage: python generate_compose.py <path_to_dockerfile>")
    #     sys.exit(1)

    # service_name = sys.argv[1]
    # dockerfile_path = sys.argv[2]
    # print(dockerfile_path)
    generate_compose(service_names, services_paths)
