# Contributing to DevOps Dashboard

## Development Setup

1. **Prerequisites:**
   - Java 17+
   - Maven 3.6+
   - Docker
   - Jenkins (optional for CI/CD)

2. **Local Development:**
   ```bash
   mvn clean package
   docker build -t sachin-devops-tomcat-app .
   docker run -d -p 9090:8080 --name sachin-devops-app sachin-devops-tomcat-app
   ```

3. **Access URLs:**
   - DevOps Dashboard: http://localhost:9090/devops-dashboard
   - Application Root: http://localhost:9090/

## Code Standards

- Follow Java naming conventions
- Add comments for complex logic
- Update documentation for new features
- Test changes locally before committing

## Commit Message Format

```
type(scope): brief description

Detailed explanation of changes made
- What was changed
- Why it was changed
- Any breaking changes

Closes #issue-number (if applicable)
```

**Types:** feat, fix, docs, style, refactor, test, chore

## Pull Request Process

1. Create feature branch from main
2. Make changes and test locally
3. Update documentation if needed
4. Submit PR with clear description
5. Ensure CI/CD pipeline passes
