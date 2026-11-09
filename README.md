
# worklearn-api

워크런(WorkLearn)의 백엔드. REST API와 Kafka 컨슈머를 한 코드베이스에 두고 프로파일로 나눠 실행한다. Java 21, Spring Boot 4.1.

## 실행

로컬에 필요한 PostgreSQL·Redis는 [worklearn-infra](https://github.com/worklearn-hrd/worklearn-infra)의 `make up`으로 띄운다.

```sh
./gradlew bootRun    # api 프로파일(기본), http://localhost:8080
./gradlew build      # 빌드와 테스트
```

다른 프로파일은 `--args='--spring.profiles.active=<이름>'`을 붙여 실행한다.

| 프로파일 | 역할 |
| --- | --- |
| `api` (기본) | REST API |
| `worker` | Kafka 컨슈머·Outbox 폴러 (2단계에서 추가) |
| `seed` | 테스트 데이터를 넣고 종료 (러너는 이후 작업에서 추가) |