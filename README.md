# Thumbor setup and configuration files

* Google Cloud Compute managed instances set up behind a load balancer behind CDN
* Make sure to `restart thumbor` on configuration changes when testing locally

## Todo
* Set up terraform and/or packer to provision infrastructure and VMs
* Automatic deployment and rolling update from `master` branch

## Special configurations in `/etc/thumbor.config`
* Set up detectors
```javascript
DETECTORS = [
    'thumbor.detectors.face_detector',
    'thumbor.detectors.feature_detector',
]
```
* Whitelist allowed domains and buckets
* Set up security keys
* Enable max-age headers for CDN
* Enable respect orientation EXIF `RESPECT_ORIENTATION = True` for mobile images

## Deployment
* Upload to gs://startup-scripts-and-packages bucket
* Rolling restart application servers, startup script will automatically grab new configuration from bucket
