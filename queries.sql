-- ========================================
-- BASIC QUERIES FOR CLOUD WORKLOAD ANALYSIS
-- Table: workload
-- Columns (after cleaning in Python) include:
--   date
--   cpu_usage_mhz
--   cpu_capacity_provisioned_mhz
--   memory_usage_kb
--   memory_capacity_provisioned_kb
--   disk_read_throughput_kbs
--   disk_write_throughput_kbs
--   network_received_throughput_kbs
--   network_transmitted_throughput_kbs
--   label
--   count
-- ========================================


-- 1. Average daily CPU usage
SELECT date(date) AS day,
       ROUND(AVG(cpu_usage_mhz), 2) AS avg_cpu_mhz
FROM workload
GROUP BY day
ORDER BY day;


-- 2. Average CPU vs Memory usage (overall)
SELECT ROUND(AVG(cpu_usage_mhz), 2)    AS avg_cpu_mhz,
       ROUND(AVG(memory_usage_kb), 2)  AS avg_memory_kb
FROM workload;


-- 3. Top 10 days with highest average CPU usage
SELECT date(date) AS day,
       ROUND(AVG(cpu_usage_mhz), 2) AS avg_cpu_mhz
FROM workload
GROUP BY day
ORDER BY avg_cpu_mhz DESC
LIMIT 10;


-- 4. Daily CPU usage summary: min / avg / max
SELECT date(date) AS day,
       MIN(cpu_usage_mhz)                  AS min_cpu_mhz,
       ROUND(AVG(cpu_usage_mhz), 2)        AS avg_cpu_mhz,
       MAX(cpu_usage_mhz)                  AS max_cpu_mhz
FROM workload
GROUP BY day
ORDER BY day;


-- 5. Average CPU usage by hour of day (0–23)
-- Helps see time-of-day patterns
SELECT strftime('%H', date) AS hour_of_day,
       ROUND(AVG(cpu_usage_mhz), 2) AS avg_cpu_mhz
FROM workload
GROUP BY hour_of_day
ORDER BY hour_of_day;


-- 6. Average daily memory usage
SELECT date(date) AS day,
       ROUND(AVG(memory_usage_kb), 2) AS avg_memory_kb
FROM workload
GROUP BY day
ORDER BY day;


-- 7. Daily disk throughput summary
SELECT date(date) AS day,
       ROUND(AVG(disk_read_throughput_kbs), 2)  AS avg_disk_read_kbs,
       ROUND(AVG(disk_write_throughput_kbs), 2) AS avg_disk_write_kbs
FROM workload
GROUP BY day
ORDER BY day;


-- 8. Daily network throughput summary
SELECT date(date) AS day,
       ROUND(AVG(network_received_throughput_kbs), 2)   AS avg_net_rx_kbs,
       ROUND(AVG(network_transmitted_throughput_kbs), 2) AS avg_net_tx_kbs
FROM workload
GROUP BY day
ORDER BY day;
