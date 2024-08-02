# Firebase PLAYground

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