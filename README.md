# TeKClinic Setup Bundle

Docker compose configuration which setups a development network of TekClinic.

## How to run

### 1. Install docker

### 2. Create GitHub Personal Access Token

To authenticate Docker with GitHub Container Registry, you need a GitHub Personal Access Token (PAT).

#### Steps:

1. **Go to GitHub PAT Settings:**

   [GitHub Personal Access Tokens](https://github.com/settings/tokens)

2. **Generate a New Token:**

   - Click on **"Generate new token (classic)"**.
   - Provide a descriptive **Note** (e.g., "Docker GHCR Access").
   - Set the token **Expiration** (e.g., 90 days).

3. **Select Scopes:**

   - `read:packages`: Allows downloading and reading packages.
   - `repo` (optional): For private repositories.

4. **Generate Token:**

   - Click **"Generate token"**.
   - Copy the token **immediately**. It won’t be shown again.

### 3. Login to GitHub Container Registry with Docker

Use your newly created PAT to log in to the GitHub Container Registry via Docker.

#### Steps:

1. **Open a Terminal:**

   Open your command-line interface (CLI) or terminal.

2. **Authenticate Docker:**

   ```bash
   echo "your_pat" | docker login ghcr.io -u your_username --password-stdin
   ```

   Replace:
   - `your_pat` with the token you copied.
   - `your_username` with your GitHub username.

   **Example:**

   ```bash
   echo "ghp_1234567890abcdef1234567890abcdef1234" | docker login ghcr.io -u octocat --password-stdin
   ```

   If successful, you’ll see a message like `Login Succeeded`.

### 4. Edit Hosts

You have to add the following entries to the end of your `hosts` file:
```
# Tekclinic
127.0.0.1 tekclinic.org
127.0.0.1 auth.tekclinic.org
127.0.0.1 api.tekclinic.org
# End of section
```

It's needed to redirect your requests to the containers.
Path to `hosts` file on Windows is `c:\Windows\System32\Drivers\etc\hosts`.

### 5. Run following commands

```
docker compose down && docker compose pull && docker compose up
```

Rerun this command each time you want to fetch the last updates.

## Available services

### Web App
Web App can be accessed on `http://tekclinic.org`.

### Keycloak
KeyCloak can be accessed on `http://auth.tekclinic.org/admin`. Admin user credentials are `admin` and `admin`.
User with a username `test_user` and a password `test` is predefined for test purposes.
Public client for Web App that runs on `http://tekclinic.org` is also predefined.

### API Gateway
API Gateway can be accessed on `http://api.tekclinic.org`.

### Database
Database can ba accessed on `localhost:5432`
When the container is created, it's set up with `db/init.sql`. If you want to save you db use the following commands:
```
docker compose exec db sh -c "pg_dumpall --exclude-database=root | sed 's/CREATE ROLE root;//' > init.sql"
docker compose cp db:init.sql db/init.sql
```
