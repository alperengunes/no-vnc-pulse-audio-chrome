# no-vnc-pulse-audio-chrome-image

This Docker image provides a Chromium browser instance accessible via noVNC, with PulseAudio support to enable sound over WebSockets. It is based on Alpine and includes an XFCE4 desktop environment. This project is designed to be a lightweight and efficient solution to run a remote Chromium session with audio output.

## Project Name

**no-vnc-pulse-audio-chrome-image**

**Author:** Alperen Güneş

## Features

- Lightweight Alpine-based image
- Chromium browser with audio support via PulseAudio over WebSockets
- noVNC integration for web-based remote desktop access
- Configurable environment variables for flexibility
- Support for shared VNC sessions

## Build and Run Instructions

### Build the Docker image:

```bash
docker build -t no-vnc-pulse-audio-chrome-image .
```

## Run the Docker container:

```bash
docker run -it -p 8080:8080 -p 56780:56780 --name no-vnc-pulse-audio-chrome no-vnc-pulse-audio-chrome-image
```

Access the noVNC session by navigating to [http://localhost:8080](http://localhost:8080) in your web browser.

## Known Issues

- Ensure that ports `8080` and `56780` are open and not in use by other applications.
- In case of sound issues, verify that PulseAudio is configured properly within the container.


## Environment Variables

The image is highly configurable via environment variables. Below is a list of the available parameters, their default values, and explanations.

| Variable       | Default Value    | Description                                                         |
|----------------|------------------|---------------------------------------------------------------------|
| `VNC_PASS`     | `CHANGE_IT`      | The password to secure the VNC session.                             |
| `VNC_TITLE`    | `Chromium`       | The title of the VNC window.                                        |
| `VNC_RESOLUTION`| `1280x720`      | The resolution of the VNC session.                                  |
| `VNC_SHARED`   | `true`           | Allow shared VNC sessions, so multiple users can connect simultaneously. |
| `DISPLAY`      | `:0`             | The display used for the VNC server.                                |
| `NOVNC_PORT`   | `$PORT`          | The port for the noVNC WebSocket server.                            |
| `PORT`         | `8080`           | The port on which noVNC will be accessible.                         |
| `NO_SLEEP`     | `false`          | Disable sleep to prevent the container from stopping due to inactivity. |
| `LANG`         | `en_US.UTF-8`    | Language setting for the environment.                               |
| `LANGUAGE`     | `en_US.UTF-8`    | Additional language setting for localization.                       |
| `LC_ALL`       | `C.UTF-8`        | Locale configuration.                                               |
| `TZ`           | `Asia/Kolkata`   | Timezone configuration for the container.                           |

## Referenced Libraries and Projects

This project was inspired by and references the following open-source repositories:

- [vital987/chrome-novnc](https://github.com/vital987/chrome-novnc)
- [novaspirit/Alpine_xfce4_noVNC](https://github.com/novaspirit/Alpine_xfce4_noVNC)
- [wu191287278/noVNC-audio](https://github.com/wu191287278/noVNC-audio)

![Image](https://i.imgur.com/TXm9nFA.png)