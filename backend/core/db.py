import logging

from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker

from backend.core.settings import settings

logger = logging.getLogger(__name__)

engine = create_engine(settings.SQLALCHEMY_DATABASE_URI, pool_pre_ping=True)

SessionLocal = sessionmaker(bind=engine, autoflush=False, autocommit=False)


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


def check_db_connection():
    try:
        db = SessionLocal()
        db.execute(text("SELECT 1"))
        logger.info("Database connection is OK")
        db.close()
    except Exception as e:
        logger.error(e)
        raise e
    return True
