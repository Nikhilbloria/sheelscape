const express = require("express");
const client = require("prom-client");
const path = require("path");

const app = express();
const PORT = 80;

client.collectDefaultMetrics();

const requestCounter = new client.Counter({
  name: "shellscape_requests_total",
  help: "Total number of requests received by ShellScape"
});

app.use((req, res, next) => {
  if (req.path !== "/metrics") {
    requestCounter.inc();
  }
  next();
});

app.use(express.static(path.join(__dirname)));

app.get("/metrics", async (req, res) => {
  res.set("Content-Type", client.register.contentType);
  res.end(await client.register.metrics());
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`ShellScape running on port ${PORT}`);
});