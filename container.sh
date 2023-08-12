aws configure set aws_access_key_id AKIARQSGNPPR53OTBL5C
aws configure set aws_secret_access_key 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
aws configure set aws_default_region ap-northeast-1
aws configure set aws_default_output json

aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 104300641251.dkr.ecr.ap-northeast-1.amazonaws.com
docker build -t mkdocuments .
docker tag mkdocuments:latest 104300641251.dkr.ecr.ap-northeast-1.amazonaws.com/mkdocuments:latest
docker push 104300641251.dkr.ecr.ap-northeast-1.amazonaws.com/mkdocuments:latest
