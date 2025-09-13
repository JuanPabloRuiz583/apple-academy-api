# Etapa de build
FROM eclipse-temurin:17-jdk AS builder

WORKDIR /app

# Copia todos os arquivos do projeto
COPY . .

# Compila o projeto com Maven
RUN ./mvnw clean package -DskipTests

# Etapa de execução
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copia o .jar do build
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]