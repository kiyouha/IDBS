# 베이스 이미지
FROM python:3.9-slim

# 작업 디렉토리 설정
WORKDIR /app

# 필요한 패키지 설치
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# 애플리케이션 코드 복사
COPY . .

# 환경 변수 설정 (생략할 수 있음)
ENV DJANGO_SETTINGS_MODULE=idbs_server.settings

# 정적 파일 수집
RUN python manage.py collectstatic --noinput

# Gunicorn 실행
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "idbs_server.wsgi:application"]
