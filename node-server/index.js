import express from "express";
const app = express();
const port = 8000;

app.get('/', (_req, res)=>{
    res.send('Hello world')
})

app.listen(port, ()=>{
    console.log(`App listening on port ${port}`)
})