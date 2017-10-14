# Thumbor setup and configuration files


* Google Cloud Compute set up behind a load balancer behind CDN
* Make sure to `restart thumbor` on configuration changes



## Special configurations in `/etc/thumbor.config`
* Set up detectors
```javascript
DETECTORS = [
    'thumbor.detectors.face_detector',
    'thumbor.detectors.feature_detector',
]
```
* Whitelist Choxue domains and buckets
* Set up security keys
* Enable max-age headers for CDN
* Enable respect orientation EXIF `RESPECT_ORIENTATION = True`


## Configuration changes
* Upload to gs://startup-scripts-and-packages bucket
* Restart application servers, startup script will automatically grab new configuration from bucket
