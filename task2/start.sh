#!/bin/bash
docker build . -t immushroom/mintme:latest
docker compose up -d