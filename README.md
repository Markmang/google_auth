Google Authentication + JWT Auth Service (Dockerized)
A fully containerized Django authentication service that provides:
JWT Authentication (Access + Refresh tokens)
Google OAuth Login using Django Allauth
PostgreSQL Database
Docker Compose support for local development
Docker deployment on Render
Production ready

TECH STACK
Backend: Django, Django REST Framework
Auth: Django Allauth, dj-rest-auth, SimpleJWT
Database: PostgreSQL
Containerization: Docker + Docker Compose
Deployment: Render
Python: 3.10+

FEATURES
Google OAuth Login
JWT Authentication
Runs in Docker containers
Supports Local + Production environments
Environment-based secure configuration
Supports automatic superuser creation

ENVIRONMENT VARIABLES (.env)
Common: DEBUG=True SECRET_KEY=your-secret-key ALLOWED_HOSTS=*
Site IDs: SITE_ID=6   (Local - Docker Compose) Render will use: SITE_ID=7
In settings.py: SITE_ID = int(os.getenv("SITE_ID", 1))
Superuser (optional): DJANGO_SUPERUSER_USERNAME=yourname DJANGO_SUPERUSER_EMAIL=you@email.com DJANGO_SUPERUSER_PASSWORD=yourpassword
Database: DATABASE_URL=postgresql://USER:PASSWORD@HOST:PORT/DB

RUN LOCALLY USING DOCKER COMPOSE
Start services docker compose up --build
This will:
Build Django container
Start PostgreSQL
Apply migrations (if configured)
Start the server
Access application http://localhost:8000
Admin: http://localhost:8000/admin
Stop containers docker compose down
Run migrations manually (if needed) docker compose exec web python manage.py migrate
Create superuser (if not auto): docker compose exec web python manage.py createsuperuser

GOOGLE OAUTH CONFIGURATION
Go to Google Cloud Console → OAuth Credentials
Authorized Redirect URIs: http://localhost:8000/accounts/google/login/callback/ https://your-app.onrender.com/accounts/google/login/callback/
Authorized JavaScript Origins: http://localhost:8000 https://your-app.onrender.com

DJANGO ADMIN CONFIGURATION
Go to /admin
Sites: Local: localhost or localhost:8000 ID = 6
Render: your-app.onrender.com ID = 7
Social Application (Google): Provider → Google Add Client ID Add Secret Add BOTH sites to "Chosen Sites":
localhost
Render domain

DEPLOYMENT TO RENDER (Docker)
Render automatically:
Builds Dockerfile
Installs dependencies
Runs Django
Push code git add . git commit -m "deploy" git push
Create Render Web Service Choose Docker Connect GitHub repo
Add Environment Variables in Render
DEBUG=False SECRET_KEY=secure-production-key SITE_ID=7 DATABASE_URL=postgres connection string
Make sure Render domain setup matches: ALLOWED_HOSTS includes .onrender.com CSRF_TRUSTED_ORIGINS includes https://*.onrender.com

AUTHENTICATION ENDPOINTS
Google Login: GET /accounts/google/login/
Callback: /accounts/google/login/callback/
JWT AUTH: Get Token: POST /api/token/
Refresh Token: POST /api/token/refresh/
Authenticated Requests Header: Authorization: Bearer ACCESS_TOKEN

IMPORTANT NOTES
Local SITE_ID = 6 Render SITE_ID = 7 Both sites must be added to Google Social Application Both redirect URLs must exist in Google Console Render does NOT run Docker Compose, only Dockerfile

AUTHOR
Udeagha Mark Mang
Software Engineer — Building impactful technology solutions.
