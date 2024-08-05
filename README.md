# Firebase PLAYground

## Cloud environment

To begin with terraform scripts in this project start with authenticating in GCP

```
gcloud init
```

Follow the prompts to login. Then

```
gcloud auth application-default login
```

and follow the prompts. Finally,

```
tf -chdir=infra init
tf -chdir=infra apply
```

If running on a fresh project, there is no bucket for remote backend yet. In this case:
1. Comment out backend configuration
2. Change the project id
3. Then run `tf -chdir=infra init && tf -chdir=infra apply`
4. Uncomment backend configuration and update the bucket name
5. Run `tf -chdir=infra init -migrate-state`

## Web app

We will use `flutter` to create an app to explore Firebase.

> To create an app from scratch run:
> ```
> flutter create --platforms=web flutter_app
> ```

To tun the app execute the following command _from the app directory_

```
export FLUTTER_APP_PORT=12345
flutter run \
  -d chrome \
  --web-port $FLUTTER_APP_PORT \
  --web-launch-url $(gp url $FLUTTER_APP_PORT) \
  --release
```

To configure Firebase for the app follow [Add Firebase to your Flutter app](https://firebase.google.com/docs/flutter/setup?platform=ios).