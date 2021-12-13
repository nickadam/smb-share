# nickadam/smb-share

Simple container to host an smb share with one user account

## Examples

This will start an smb share, `\data`, on the host to a random docker volume. The username is admin and the randomly generated password is on the first line of the logs.
```shell
docker pull nickadam/smb-share
docker run -d --name myshare -p 445:445 -p 139:139 nickadam/smb-share
docker logs myshare
```

In this example we specify the username, password, and mount a local volume using the current users UID and GID.
```shell
docker run -d --name myshare \
  -p 445:445 -p 139:139 \
  -v "$PWD":/data \
  -e SMB_USER="$USERNAME" \
  -e PASSWORD="badpassword" \
  -e SMB_UID=$UID \
  -e SMB_GID=$GID \
  nickadam/smb-share
```

## Data directory

Persistent data shared from `/data`

If the data directory is empty, it will be chowned with the UID and GID of the SMB user.

## Ports

Expose ports 445 and 139

## Environment variables

Name | Value if not specified | Description
---|---|---
SHARE_NAME | data | The name of the share
SMB_USER | admin | The username with permission to the share
PASSWORD |  | A password will be randomly generated and displayed in the logs if not specified
PASSWORD_FILE |  | Path to a file containing the plain text password, can be used instead of PASSWORD
SMB_UID | 1000 | The user id of the user
SMB_GID | 1000 | The group id of the user
FILEMODE | 644 | New files created via smb will have these permissions
DIRMODE | 755 | New directories created via smb will have these permissions

## Accessing the share from windows

To prevent windows from attempting to access the share with the local user or guest it's a good idea to use the `net` command to specify the user and password.

Prompt for password:
```powershell
net use /user:admin "\\server.example.com\data"
```

Specify password:
```powershell
net use /user:admin "\\server.example.com\data" badpassword
```

## More info

See [docker-compose.yml](https://github.com/nickadam/smb-share/blob/main/docker-compose.yml) for more info and docker swarm example
