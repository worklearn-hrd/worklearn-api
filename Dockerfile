# 1단계(build): JDK로 실행 가능한 jar를 만든다.
FROM eclipse-temurin:21-jdk AS build
WORKDIR /workspace

# 빌드 설정만 먼저 복사해 의존성을 내려받는다.
# 소스만 바뀐 빌드에서는 이 층이 캐시에서 재사용된다.
COPY gradlew settings.gradle.kts build.gradle.kts ./
COPY gradle gradle
RUN ./gradlew dependencies --no-daemon

COPY src src
RUN ./gradlew bootJar --no-daemon

# 2단계(run): JRE와 jar만 담는다. JDK·Gradle·소스는 최종 이미지에 남지 않는다.
FROM eclipse-temurin:21-jre
WORKDIR /app
RUN useradd --system --no-create-home worklearn
USER worklearn
COPY --from=build /workspace/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]