from django.http import JsonResponse
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from django.http import JsonResponse


def api_root(request):
    return JsonResponse({
        "status": "ok",
        "message": "Backend is running",
        "auth": {
            "login": "/accounts/login/",
            "google": "/accounts/google/login/",
            "token_login": "/accounts/google/login/token/"
        }
    })

class MeView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        return Response({
            "id": request.user.id,
            "email": request.user.email,
            "username": request.user.username,
        })
    
from django.http import JsonResponse

def health(request):
    return JsonResponse({"status": "ok"})