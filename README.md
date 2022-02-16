# Movie Battles II Docker Server
[![GitHub license][license-shield]][license-url]


<!-- TABLE OF CONTENTS, generated with gh-md-toc README.md (see #acknowledgements) -->

Table of Contents
=================


<!-- ABOUT THE PROJECT -->

## About The Project

Tired of migrating MBII servers and installing all dependencies, I built it for the MBII Duel of Tempest «DøT» spanish Clan server. This is a docker image with the server and some useful features I've been using so far.

### Features (Current & Planned)

- [x] The container checks for MBII and RTVRTM updates on startup.
- [x] The container auto-restarts the MBII server if it fails for any reason, without restarting the container.
- [x] Server logs goes to stdout and thus can be read with `docker logs`
- [ ] Primary & Secondary RTVRTM configs.
- [ ] Option to schedule messages each X minutes.
- [ ] Option to restart the container each day(if empty) and check for updates.
- [ ] Management tool in order to issue rcon commands (status, kick, change map, etc..)
- [ ] Template configs to create configs easier from scratch.
- [ ] Rotate map & mode automatically when the server is empty
- [ ] Discord status updates?

<!-- GETTING STARTED -->
## Getting Started
### Requirements

- Docker Engine & Docker-Compose
- Jedi Academy base assets (assets0.pj3, assets1.pk3, assets2.pk3, assets3.pk3)

### Installation

- Create a directory with `base` and `MBII` folders. These will be the volumes mounted on the docker image.
- On the `base` folder copy your assets files from Jedi Academy.
- Configure server and (optionally) RTVRTM config files on `MBII` folder.
- Configure the docker-compose.yml as you like to launch the container.

<!-- USAGE EXAMPLES -->
### Usage

- Launch the container by issuing `docker-compose up -d` where the docker-compose.yml is located.

<!-- CONTRIBUTING -->

## Support & Contributing

If you want to add any missing feature or report a bug, you [can request ir or report it here][issues-url]. Also if you are want and know how to do it, go ahead! That's what make the open source community shines, by allowing us to grow and learn from each other creating amazing tools! Any contribution you make is **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


<!-- ACKNOWLEDGEMENTS -->

## Acknowledgements
* [MBIIEZ](https://github.com/Wookiee-/mbiiez)
* [MBIII-EDS](https://github.com/louisvarley/mbii-eds/)


## License


[![GitHub license][license-shield]][license-url]

Distributed under the GNU GPL-v3 License. See [LICENSE][license-url] on for more information.


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[license-shield]: https://img.shields.io/badge/license-GNU%20GPL--v3-brightgreen
[license-url]: https://github.com/GalizaTTD/galician-landscape/blob/main/LICENSE
[project-url]: https://github.com/GalizaTTD/galician-landscape
[issues-url]: https://github.com/GalizaTTD/galician-landscape/issues