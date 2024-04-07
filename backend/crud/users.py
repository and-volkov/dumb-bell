from backend.models import users as models_users


def get_user(db, username: str) -> models_users.User:
    return (
        db.query(models_users.User)
        .filter(models_users.User.username == username)
        .first()
    )
