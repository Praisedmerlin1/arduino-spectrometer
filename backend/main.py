from fastapi import FastAPI
from fastapi.responses import JSONResponse
import random

app = FastAPI()

# Sample data
data = {
    "data": [
        {"wavelength": 400, "intensity": random.uniform(0, 1)},
        {"wavelength": 410, "intensity": random.uniform(0, 1)},
        {"wavelength": 420, "intensity": random.uniform(0, 1)},
        {"wavelength": 430, "intensity": random.uniform(0, 1)},
        {"wavelength": 440, "intensity": random.uniform(0, 1)},
        {"wavelength": 450, "intensity": random.uniform(0, 1)},
        {"wavelength": 460, "intensity": random.uniform(0, 1)},
        {"wavelength": 470, "intensity": random.uniform(0, 1)},
        {"wavelength": 480, "intensity": random.uniform(0, 1)},
        {"wavelength": 490, "intensity": random.uniform(0, 1)},
        {"wavelength": 500, "intensity": random.uniform(0, 1)},
        {"wavelength": 510, "intensity": random.uniform(0, 1)},
        {"wavelength": 520, "intensity": random.uniform(0, 1)},
        {"wavelength": 530, "intensity": random.uniform(0, 1)},
        {"wavelength": 540, "intensity": random.uniform(0, 1)},
        {"wavelength": 550, "intensity": random.uniform(0, 1)},
        {"wavelength": 560, "intensity": random.uniform(0, 1)},
        {"wavelength": 570, "intensity": random.uniform(0, 1)},
        {"wavelength": 580, "intensity": random.uniform(0, 1)},
        {"wavelength": 590, "intensity": random.uniform(0, 1)},
        {"wavelength": 600, "intensity": random.uniform(0, 1)},
        {"wavelength": 610, "intensity": random.uniform(0, 1)},
        {"wavelength": 620, "intensity": random.uniform(0, 1)},
        {"wavelength": 630, "intensity": random.uniform(0, 1)},
        {"wavelength": 640, "intensity": random.uniform(0, 1)},
        {"wavelength": 650, "intensity": random.uniform(0, 1)},
        {"wavelength": 660, "intensity": random.uniform(0, 1)},
        {"wavelength": 670, "intensity": random.uniform(0, 1)},
        {"wavelength": 680, "intensity": random.uniform(0, 1)},
        {"wavelength": 690, "intensity": random.uniform(0, 1)},
        {"wavelength": 700, "intensity": random.uniform(0, 1)}
    ]
}

@app.get("/data")
async def get_data():
    return JSONResponse(content=data)