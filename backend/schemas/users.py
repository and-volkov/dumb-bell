from pydantic import BaseModel, EmailStr


class User(BaseModel):
    username: str
    password: str
    is_superuser: bool
    is_active: bool


class UserProfile(BaseModel):
    email: EmailStr
