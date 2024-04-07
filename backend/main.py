from fastapi import FastAPI

from backend.routers.auth import router as auth_router

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Server is up"}


app.include_router(auth_router, tags=["auth"])
