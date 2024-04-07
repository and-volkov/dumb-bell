from pydantic import BaseModel


class User(BaseModel):
    username: str
    password: str
    is_superuser: bool | None = False
    is_active: bool | None = True


class UserGet(BaseModel):
    username: str
    is_superuser: bool
    is_active: bool


class UserCreate(BaseModel):
    username: str
    password: str
    is_superuser: bool = False
    is_active: bool = True


class UserUpdate(BaseModel):
    username: str
    password: str
    is_superuser: bool
    is_active: bool


class UserDelete(BaseModel):
    id: int


class Token(BaseModel):
    access_token: str
    token_type: str


class TokenData(BaseModel):
    username: str
