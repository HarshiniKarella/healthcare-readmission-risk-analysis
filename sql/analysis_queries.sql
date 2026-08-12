-- Healthcare Readmission Risk Analysis
-- Exploratory SQL queries using the preprocessed diabetes dataset.
--
-- Expected table name: diabetic_readmissions
-- Target:
--   readmitted_30_days = 1 -> readmitted within 30 days
--   readmitted_30_days = 0 -> not readmitted within 30 days


-- 1. Overall 30-Day Readmission Rate

SELECT
    COUNT(*) AS total_encounters,
    SUM(readmitted_30_days) AS readmitted_within_30_days,
    ROUND(
        100.0 * SUM(readmitted_30_days) / COUNT(*),
        2
    ) AS readmission_rate_pct
FROM diabetic_readmissions;


-- 2. Readmission Rate by Age Group

SELECT
    age,
    COUNT(*) AS patient_encounters,
    SUM(readmitted_30_days) AS readmissions,
    ROUND(
        100.0 * AVG(readmitted_30_days),
        2
    ) AS readmission_rate_pct
FROM diabetic_readmissions
GROUP BY age
ORDER BY age;


-- 3. Readmission Rate by Medical Specialty

SELECT
    medical_specialty_grouped,
    COUNT(*) AS patient_encounters,
    SUM(readmitted_30_days) AS readmissions,
    ROUND(
        100.0 * AVG(readmitted_30_days),
        2
    ) AS readmission_rate_pct
FROM diabetic_readmissions
GROUP BY medical_specialty_grouped
ORDER BY readmission_rate_pct DESC;


-- 4. Hospital Utilization by Readmission Status

SELECT
    readmitted_30_days,
    ROUND(AVG(number_inpatient), 2) AS avg_prior_inpatient_visits,
    ROUND(AVG(number_emergency), 2) AS avg_emergency_visits,
    ROUND(AVG(number_outpatient), 2) AS avg_outpatient_visits,
    ROUND(AVG(time_in_hospital), 2) AS avg_days_in_hospital
FROM diabetic_readmissions
GROUP BY readmitted_30_days
ORDER BY readmitted_30_days;


-- 5. Medication and Diagnosis Complexity

SELECT
    readmitted_30_days,
    ROUND(AVG(num_medications), 2) AS avg_medications,
    ROUND(AVG(number_diagnoses), 2) AS avg_diagnoses,
    ROUND(AVG(num_lab_procedures), 2) AS avg_lab_procedures,
    ROUND(AVG(num_procedures), 2) AS avg_procedures
FROM diabetic_readmissions
GROUP BY readmitted_30_days
ORDER BY readmitted_30_days;