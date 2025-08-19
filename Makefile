# ===== uv + Python 3.12 で統一実行 =====
PIP    := uv pip --python 3.12
PY     := uv run --python 3.12
MANAGE := $(PY) manage.py

.PHONY: setup install run migrate makemigrations createsuperuser shell test collectstatic

# 1) プロジェクトに 3.12 を用意（最初だけ）
setup:
	uv python install 3.12
	# 任意: プロジェクトに 3.12 をピン止め（.python-version 的な指定）
	uv python pin 3.12 || true

# 2) 依存インストール（requirements.txt を uv で）
install:
	$(PIP) install -r requirements.txt

# 3) サーバ起動（カレントでOK）
run:
	$(MANAGE) runserver 0.0.0.0:8000

# よく使う補助ターゲット
makemigrations:
	$(MANAGE) makemigrations

migrate:
	$(MANAGE) migrate

createsuperuser:
	$(MANAGE) createsuperuser

shell:
	$(MANAGE) shell

test:
	$(MANAGE) test

collectstatic:
	$(MANAGE) collectstatic --noinput

freeze:
	uv pip freeze | sponge requirements.txt