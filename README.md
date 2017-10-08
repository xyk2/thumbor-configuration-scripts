# Thumbor setup and configuration files


* See [this gist](https://gist.github.com/chrishaff/83b0a3b621c3301ecc32) for installation instructions on Ubuntu 14.04 along with OpenCV for feature detection
* Google Cloud Compute server set up behind a load balancer behind CDN
* Make sure there is an assigned elastic IP for the VM instance
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
