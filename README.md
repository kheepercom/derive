# Derive

This is a template for extending the open-source operating system images maintained by kheeper in our [bootc repo](https://github.com/kheepercom/bootc).

## Step 1

Fork this repo for each image you wish to derive.
These examples assume you are extending `us.kheeper.com/bootc/server:45`.
You'll need to modify the examples if you're extending a different image, such as `eu.kheeper.com/bootc/headscale:0`.

## Step 2

Add your modifications to Containerfile.
This is the place to add authorized keys, additional packages, and config files to your image.
The example Containerfile demonstrates adding a privileged user named "admin".

## Step 3

Decide whether to make your image public or to keep it private.
To make the image public, push and wait for the first build to complete, then go to Packages → `<owner>/<repo>` → Package settings → Change visibility.

If you are going to keep the image private, you'll need to grab a [personal access token](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#authenticating-to-the-container-registry) with `read:packages` scope before going to Step 4.
This token will remain on the server at /etc/ostree/auth.json and be used to pull image updates.

## Step 4

Use [Kheeper's bootc quickstart script](https://kheeper.com/bootc-quickstart) if you're running on GCP, AWS or bare metal.
For other options, see [Fedora's bootc provisioning docs.](https://docs.fedoraproject.org/en-US/bootc/bare-metal/)

The quickstart script for GCP will generate a script like this.
(If you're using a private image your access token will also be embedded in the metadata).
You can modify `machine-type` and `boot-disk-size` but you'll have to keep `image-project`, `image-family`, and `metadata` to successfully boot your derived image:
```sh
gcloud compute instances create my-server \
  --image-project kheeper --image-family bootc-quickstart \
  --machine-type c4-standard-2 \
  --boot-disk-size 20GB \
  --metadata 'bootc-image=ghcr.io/<owner>/<repo>:main'
```

## Step 5

On first boot your server pulls and switches to your image and then reboots.
If you're on GCP you can follow along with `gcloud compute instances tail-serial-port-output <INSTANCE>`.

After 5 to 10 minutes, you should be able to SSH into your server (assuming you added a user named "admin" with an authorized key in your image):

```sh
ssh admin@<IP>
```
