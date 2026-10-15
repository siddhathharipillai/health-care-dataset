-- Healthcare Data Analysis
-- Tool: Microsoft SQL Server

USE healthcare;
GO

-- 1. Count total patients
SELECT COUNT(*) AS TotalPatients
FROM Patients;

-- 2. Count patients by diagnosis
SELECT
    d.DiagnosisName,
    COUNT(*) AS TotalPatients
FROM Patients p
JOIN Diagnosis d
    ON p.DiagnosisID = d.DiagnosisID
GROUP BY d.DiagnosisName
ORDER BY TotalPatients DESC;

-- 3. Average treatment cost by diagnosis
SELECT
    d.DiagnosisName,
    AVG(p.TreatmentCost) AS AverageTreatmentCost
FROM Patients p
JOIN Diagnosis d
    ON p.DiagnosisID = d.DiagnosisID
GROUP BY d.DiagnosisName
ORDER BY AverageTreatmentCost DESC;

-- 4. Patient count by outcome
SELECT
    o.OutcomeName,
    COUNT(*) AS PatientCount
FROM Patients p
JOIN Outcome o
    ON p.OutcomeID = o.OutcomeID
GROUP BY o.OutcomeName
ORDER BY PatientCount DESC;

-- 5. Average laboratory result by test
SELECT
    TestName,
    AVG(Result) AS AverageResult,
    COUNT(*) AS TotalTests
FROM Labs
GROUP BY TestName
ORDER BY AverageResult DESC;

-- 6. Patients with the highest treatment costs
SELECT TOP 10
    PatientID,
    Age,
    DiagnosisID,
    TreatmentCost
FROM Patients
ORDER BY TreatmentCost DESC;

-- 7. Average patient age by diagnosis
SELECT
    d.DiagnosisName,
    AVG(CAST(p.Age AS DECIMAL(10,2))) AS AverageAge
FROM Patients p
JOIN Diagnosis d
    ON p.DiagnosisID = d.DiagnosisID
GROUP BY d.DiagnosisName
ORDER BY AverageAge DESC;

-- 8. Length of hospital stay
SELECT
    PatientID,
    AdmissionDate,
    DischargeDate,
    DATEDIFF(DAY, AdmissionDate, DischargeDate) AS HospitalStayDays
FROM Patients
WHERE AdmissionDate IS NOT NULL
  AND DischargeDate IS NOT NULL
ORDER BY HospitalStayDays DESC;
