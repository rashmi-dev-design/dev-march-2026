<div align="center">

<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/java/java-original.svg" width="80" />

# Calculator Web App — Java Maven

A REST calculator built with **Jersey (JAX-RS)** and **Maven** — for DevOps training.

[![Java](https://img.shields.io/badge/Java-17-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://openjdk.org)
[![Maven](https://img.shields.io/badge/Maven-3.9-C71A36?style=for-the-badge&logo=apachemaven&logoColor=white)](https://maven.apache.org)
[![Jersey](https://img.shields.io/badge/Jersey-2.41-F5786A?style=for-the-badge)](https://eclipse-ee4j.github.io/jersey/)
[![Docker](https://img.shields.io/badge/Docker-Ready-00B4D8?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com)
[![K8s](https://img.shields.io/badge/Kubernetes-Ready-9B5DE5?style=for-the-badge&logo=kubernetes&logoColor=white)](https://kubernetes.io)
[![License](https://img.shields.io/badge/License-MIT-06D6A0?style=for-the-badge)](LICENSE)

</div>

---

## API Endpoints

| Method | Route | Description |
|--------|-------|-------------|
| `GET` | `/api/calculator/ping` | Health check — returns welcome message with timestamp |
| `GET` | `/api/calculator/add?x=8&y=26` | Addition |
| `GET` | `/api/calculator/sub?x=12&y=8` | Subtraction |
| `GET` | `/api/calculator/mul?x=11&y=8` | Multiplication |
| `GET` | `/api/calculator/div?x=12&y=12` | Division |

> All math endpoints return JSON: `{ "x": 8, "y": 26, "result": 34, "time": "..." }`

---

## Prerequisites

```bash
sudo apt update
sudo apt install openjdk-17-jdk maven -y
```

```bash
java -version
mvn -v
```

---

## Quick Start

### Build

```bash
mvn clean package -DskipTests
```

> Produces `target/calculator.war`

### Run Locally (Jetty)

```bash
mvn jetty:run
```

> App starts on `http://localhost:9999/calculator`

### Run Unit Tests

```bash
mvn clean test
```

### Run Integration Tests

```bash
mvn clean verify
```

> Jetty starts automatically, runs `*IT.java` tests, then stops.

---

## Test Endpoints

```bash
curl http://localhost:9999/calculator/api/calculator/ping
```

```bash
curl "http://localhost:9999/calculator/api/calculator/add?x=8&y=26"
```

```bash
curl "http://localhost:9999/calculator/api/calculator/sub?x=12&y=8"
```

```bash
curl "http://localhost:9999/calculator/api/calculator/mul?x=11&y=8"
```

```bash
curl "http://localhost:9999/calculator/api/calculator/div?x=12&y=12"
```

---

## Sample Responses

<details>
<summary><b>GET /api/calculator/ping</b></summary>

```
Welcome to Java Maven Calculator Web App!!!
Thu Mar 05 23:00:00 IST 2026
```

</details>

<details>
<summary><b>GET /api/calculator/add?x=8&y=26</b></summary>

```json
{
  "x": 8,
  "y": 26,
  "result": 34,
  "time": "Thu Mar 05 23:00:00 IST 2026"
}
```

</details>

<details>
<summary><b>GET /api/calculator/div?x=12&y=12</b></summary>

```json
{
  "x": 12,
  "y": 12,
  "result": 1,
  "time": "Thu Mar 05 23:00:00 IST 2026"
}
```

</details>

---

## Load Testing

### Install Apache Bench (`ab`)

<details>
<summary><b>macOS</b></summary>

Pre-installed. Nothing to do — just run `ab` in terminal.

</details>

<details>
<summary><b>Ubuntu / Debian</b></summary>

```bash
sudo apt update
sudo apt install apache2-utils -y
```

</details>

<details>
<summary><b>Windows</b></summary>

Option 1 — via XAMPP (easiest):
```
1. Download XAMPP from https://www.apachefriends.org
2. Install it (default path: C:\xampp)
3. ab.exe is at: C:\xampp\apache\bin\ab.exe
4. Add C:\xampp\apache\bin to your System PATH
```

Option 2 — via Apache Lounge:
```
1. Download Apache binaries from https://www.apachelounge.com/download
2. Extract the zip
3. ab.exe is inside the bin/ folder
4. Add that bin/ folder to your System PATH
```

Verify:
```bash
ab -V
```

</details>

### Quick test (single endpoint)

```bash
ab -n 500 -c 10 http://localhost:9999/calculator/api/calculator/ping
```

> Sends **500 requests** with **10 concurrent** users.

### Run full load test (all endpoints)

```bash
./loadtest.sh
```

### Understanding the output

```
Requests per second:    1523.45 [#/sec]    ← Throughput
Time per request:       6.564 [ms]         ← Avg response time
Failed requests:        0                  ← Should always be 0
Percentage of the requests served within a certain time (ms)
  50%      5                               ← Median
  95%     12                               ← 95th percentile
  99%     18                               ← Worst case (ignoring outliers)
 100%     45 (longest request)
```

### Key metrics

| Metric | What it means | Good value |
|--------|---------------|------------|
| **Requests per second** | Throughput — how fast the server responds | Higher is better |
| **Time per request** | Average latency per request | Lower is better |
| **Failed requests** | Errors during the test | Must be 0 |
| **95th / 99th percentile** | Worst-case response times | Should be close to mean |

### Common `ab` flags

| Flag | Meaning | Example |
|------|---------|---------|
| `-n` | Total number of requests | `-n 1000` |
| `-c` | Concurrent users (parallel) | `-c 50` |
| `-t` | Run for N seconds (instead of -n) | `-t 30` |
| `-H` | Add custom header | `-H "Authorization: Bearer token"` |
| `-p` | POST data from file | `-p data.json -T application/json` |

### Example scenarios for class

```bash
# Light load — 100 requests, 5 users
ab -n 100 -c 5 http://localhost:9999/calculator/api/calculator/add?x=5&y=3
```

```bash
# Medium load — 1000 requests, 50 users
ab -n 1000 -c 50 http://localhost:9999/calculator/api/calculator/ping
```

```bash
# Stress test — run for 30 seconds with 100 concurrent users
ab -t 30 -c 100 http://localhost:9999/calculator/api/calculator/ping
```

### Other popular load testing tools

| Tool | Install | Best for |
|------|---------|----------|
| **ab** | Pre-installed (macOS) / `apt install apache2-utils` | Quick CLI tests |
| **hey** | `brew install hey` / `apt install hey` | Modern ab alternative, cleaner output |
| **k6** | `brew install k6` / [k6.io](https://k6.io) | Scriptable in JS, CI/CD pipelines |
| **JMeter** | [Download](https://jmeter.apache.org) | GUI-based, complex scenarios |
| **Gatling** | Maven plugin | Java projects, HTML reports |
| **wrk** | `brew install wrk` / `apt install wrk` | High-performance benchmarking |

---

## Docker

### Simple (requires pre-built WAR)

```bash
mvn clean package -DskipTests
```

```bash
docker build -t calculator .
```

### Multi-stage (builds inside Docker)

```bash
docker build -f Dockerfile_multistage -t calculator .
```

### Run

```bash
docker run -p 8080:8080 calculator
```

> Access at `http://localhost:8080/api/calculator/ping`

---

## Jenkins Pipeline

A `Jenkinsfile` is included with these stages:

```
Checkout → Build → Unit Test → Integration Test → Deploy (manual approval)
```

Configure a Pipeline job in Jenkins and point it to this repo's `Jenkinsfile`.

---

## Project Structure

```
java-maven-calculator-app/
├── src/
│   ├── main/
│   │   ├── java/com/itdefined/calculator/
│   │   │   ├── CalculatorService.java    # REST endpoints (JAX-RS)
│   │   │   └── CalculatorResponse.java   # JSON response model
│   │   └── webapp/
│   │       ├── WEB-INF/web.xml           # Servlet config
│   │       ├── index.html
│   │       └── index.jsp
│   └── test/
│       └── java/com/itdefined/calculator/
│           ├── CalculatorServiceTest.java # Unit tests
│           └── CalculatorServiceIT.java   # Integration tests
├── pom.xml                               # Maven build config
├── Dockerfile                            # Simple Docker build
├── Dockerfile_multistage                 # Multi-stage Docker build
├── Jenkinsfile                           # CI/CD pipeline
├── outputs/                              # Screenshot references
└── README.md
```

---

## What is `target/` ?

When you run `mvn package`, Maven compiles and packages your code into the `target/` directory.

| Concept | Detail |
|---------|--------|
| **What** | Maven's build output directory |
| **Contains** | `.class` files, `.war` / `.jar` artifact, test reports |
| **Equivalent** | Python's `dist/`, Node's `build/`, Go's binary output |
| **Safe to delete?** | Yes — `mvn clean` removes it, Maven recreates it on next build |
| **Should it be in Git?** | No — always add `target/` to `.gitignore` |

---

## Maven Lifecycle

The key commands map to Maven's build lifecycle:

| Command | What it does |
|---------|-------------|
| `mvn clean` | Deletes `target/` |
| `mvn compile` | Compiles source code |
| `mvn test` | Runs unit tests |
| `mvn package` | Builds the `.war` file |
| `mvn verify` | Runs integration tests |
| `mvn jetty:run` | Starts local dev server |

### Skip flags

| Flag | Effect |
|------|--------|
| `-DskipTests` | Compiles tests but doesn't run them |
| `-Dmaven.test.skip=true` | Skips both compilation and execution of tests |

---

## Java Packaging

| Format | When to use |
|--------|-------------|
| **WAR** | Deploy to servlet containers (Tomcat, Jetty) |
| **JAR** | Standalone apps (Spring Boot fat JAR) |
| **Docker** | Production — container with app + runtime bundled |

> This app builds a **WAR** deployed to Tomcat. For production, use the multi-stage Dockerfile.

---

## Extra: Performance Testing in the Industry

### Types of performance tests

| Test Type | What it does | Example |
|-----------|-------------|---------|
| **Load Test** | Can the app handle expected users? | 500 users browsing the site |
| **Stress Test** | At what point does the app break? | Keep adding users until it crashes |
| **Spike Test** | Handle sudden traffic bursts? | Flash sale — 0 to 10,000 users in seconds |
| **Soak Test** | Run for hours — any memory leaks? | 200 users for 8 hours straight |
| **API Benchmark** | Raw requests/sec on a single endpoint | How fast is `/ping`? |
| **User Journey** | Simulate real multi-step flows | Login → Browse → Add to cart → Checkout |

### Tool comparison

| Tool | Language | Best for | Used by | Learning curve |
|------|----------|----------|---------|---------------|
| **ab** | C | Quick one-off benchmarks | Everyone | Trivial |
| **k6** | JavaScript | Modern CI/CD pipelines | Grafana, GitLab, Microsoft | Easy |
| **Locust** | Python | Python teams, distributed testing | Python shops | Easy |
| **Gatling** | Scala/Java | Java projects, HTML reports | Java enterprises | Medium |
| **JMeter** | Java | GUI-based complex scenarios | Legacy/QA teams | Hard |
| **wrk** | C | Raw high-performance benchmarking | Performance engineers | Easy |

### The industry shift

```
2005–2015:  JMeter was king (only real option)
2015–2020:  Gatling gained popularity (code > GUI, better reports)
2020+:      k6 is the new standard (JS scripts, cloud-native, CI/CD first)
```

### What makes JMeter different?

JMeter simulates **real user journeys**, not just single URL hits:

```
Login → Browse products → Search → Add to cart → Checkout → Logout
  ↓           ↓              ↓            ↓             ↓
 Auth     Wait 3s       Think time    Verify JSON    Extract token
```

It handles cookies, sessions, tokens, file uploads, JDBC queries, and more. That's why QA teams still use it. But for DevOps pipelines, it's overkill.

### k6 — the modern replacement

```javascript
// k6 test script — this is ALL you need
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  vus: 50,            // 50 virtual users
  duration: '30s',    // run for 30 seconds
};

export default function () {
  const res = http.get('http://localhost:9999/calculator/api/calculator/ping');
  check(res, { 'status is 200': (r) => r.status === 200 });
  sleep(1);
}
```

```bash
k6 run test.js
```

<details>
<summary><b>Install k6</b></summary>

**macOS:**
```bash
brew install k6
```

**Ubuntu:**
```bash
sudo gpg -k
sudo gpg --no-default-keyring --keyring /usr/share/keyrings/k6-archive-keyring.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C5AD17C747E3415A3642D57D77C6C491D6AC1D68
echo "deb [signed-by=/usr/share/keyrings/k6-archive-keyring.gpg] https://dl.k6.io/deb stable main" | sudo tee /etc/apt/sources.list.d/k6.list
sudo apt update && sudo apt install k6 -y
```

**Windows:**
```bash
choco install k6
```
Or download from [k6.io/docs/get-started/installation](https://k6.io/docs/get-started/installation/)

</details>

### Which tool to use when?

| Scenario | Use this |
|----------|----------|
| *"Is my endpoint fast?"* | `ab` or `hey` |
| *"Can it handle 1000 users?"* | `k6` |
| *"Run load tests in Jenkins/GitHub Actions"* | `k6` |
| *"Simulate login → checkout flow"* | `k6` or JMeter |
| *"QA team needs GUI test plans"* | JMeter |
| *"Need fancy HTML reports for management"* | Gatling |

> **TL;DR** — Use `ab` for quick benchmarks. Use `k6` for real load testing. JMeter is legacy but still used in enterprises.

---

<div align="center">

**Built for DevOps training at ITDefined.org** · Java · Maven · Docker · Jenkins

</div>
