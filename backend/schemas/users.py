from pydantic import BaseModel, EmailStr


class User(BaseModel):
    username: str
    password: str
    is_superuser: bool | None = False
    is_active: bool | None = True


class UserProfile(BaseModel):
    email: EmailStr
