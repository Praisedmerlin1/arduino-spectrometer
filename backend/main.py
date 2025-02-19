from fastapi import FastAPI
from fastapi.responses import JSONResponse
import random

app = FastAPI()

# Sample data
def get_random_data():
    data = {
        "device_id" : random.randint(1, 100),
        "toxins" : ["Aflatoxin",] if random.random() > 0.5 else [],  # 50% chance of having toxins
        "graph_uri" : "https://en.wikipedia.org/wiki/Spectroscopy", # Link to more information
    }

    return data

@app.get("/data")
async def get_data():
    return JSONResponse(content=get_random_data())

@app.post("/scan")
async def start_scan():
    # Here you would add the code to start the scan on the device
    # For now, we'll just return a success message
    return JSONResponse(content={"message":"Scan started successfully"})