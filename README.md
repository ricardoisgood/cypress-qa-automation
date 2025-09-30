# Cypress QA Automation Project

[![Cypress](https://img.shields.io/badge/tested%20with-Cypress-04C38E.svg)](https://www.cypress.io/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.0-blue.svg)](https://www.typescriptlang.org/)
[![Cucumber](https://img.shields.io/badge/Cucumber-Gherkin-brightgreen.svg)](https://cucumber.io/)
[![Mochawesome](https://img.shields.io/badge/Reports-Mochawesome-orange.svg)](https://github.com/adamgruber/mochawesome)
[![Node.js](https://img.shields.io/badge/Node.js-LTS-green.svg)](https://nodejs.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

This repository contains automated UI and API tests developed with Cypress, TypeScript, and Cucumber (Gherkin).  
The project was built as part of a QA Engineer technical exercise, with a focus on creating a robust, maintainable, and scalable automation framework.

---

## Table of Contents
- [**1. Tech Stack**](#1-tech-stack)
- [**2. Project Structure**](#2-project-structure)
- [**3. Installation**](#3-installation)
- [**4. Running the Tests**](#4-running-the-tests)
- [**5. Implemented Scenarios**](#5-implemented-scenarios)
- [**6. Key Features of the Implementation**](#6-key-features-of-the-implementation)
- [**7. How to Extend**](#7-how-to-extend)
- [**8. Deliverables**](#8-deliverables)
- [**9. CI/CD Integration (GitHub Actions)**](#9-cicd-integration-github-actions)
- [**10. Known Issues / Limitations**](#10-known-issues--limitations)
- [**11. License**](#11-license)
- [**12. Author**](#12-author)

---

## **1. Tech Stack**

- Cypress 13+  
- TypeScript  
- Cucumber (`@badeball/cypress-cucumber-preprocessor`)  
- esbuild bundler  
- Mochawesome reporter  
- Node.js (LTS version recommended)

---

## **2. Project Structure**
```
├── cypress/
│ ├── e2e/
│ │ └── features/ # Gherkin feature files
│ │ ├── api_objects.feature
│ │ ├── alerts_frames_windows.feature
│ │ ├── dynamic_properties.feature
│ │ ├── forms.feature
│ │ ├── upload_download.feature
│ │ ├── webtables.feature
│ │ └── widgets.feature
│ └── step_definitions/
│ └── steps.ts # Step definitions (UI + API)
├── cypress.config.ts # Cypress + Cucumber configuration
├── package.json
├── tsconfig.json
├── LICENSE #
└── README.md
```
---

## **3. Installation**

Clone the repository and install dependencies.

**Clone the repository**
```
git clone [https://github.com/seu-usuario/seu-repo.git](https://github.com/ricardoisgood/cypress-qa-automation)
```

**Install dependencies**
```
npm install
```

It is recommended to use Node.js LTS.
Tests can be executed in Linux/macOS shells or PowerShell (Windows).

---

## **4. Running the Tests**

**Open Cypress runner (interactive mode):**
```
npm run cypress:open
```

**Execute headless run with reports:**
```
npm run cypress:run
```

**Mochawesome reports are generated under:**
```
cypress/reports/html/index.html
Open this file in a browser to view the full interactive report.
```

PowerShell users can run the same commands directly.

---

## **5. Implemented Scenarios**

**UI Automation**
```
- Web Tables (webtables.feature): validations for CRUD operations, field boundaries, input constraints, search, and pagination behaviors.

- Forms (forms.feature): validations for required fields, special characters, emails, mobile constraints, datepicker, subjects, hobbies, address, city/state linkage, image uploads (png/jpg/jpeg), and success/error modal behaviors.

- Alerts, Frames & Windows (alerts_frames_windows.feature): validations for handling alerts (immediate, timed, confirm, prompt), reading text from single and nested frames, and opening a new tab with content verification.

- Dynamic Properties (dynamic_properties.feature): validations for delayed enablement, color change, visibility, random ID behavior, control existence, reload effects, and navigation consistency.

- Upload & Download (upload_download.feature): validations for file download and upload, including completion time, single-file restriction, fakepath display, and button accessibility.

- Widgets (widgets.feature): Accordion expand/collapse, Auto Complete with multiple chips, Tabs navigation with dynamic panels, and Tool Tips validation on hover
```

**API Automation (api_objects.feature)**
```
- Coverage of the [restful-api.dev](https://restful-api.dev) objects API, including: validations for GET endpoints, full CRUD operations, hardening (double delete, deleted id not listed), error handling with 404s, JSON headers, consistency checks, and performance under 1500 ms.
```

---

## **6. Key Features of the Implementation**

- Reusable step definitions for UI and API  
- Utility functions (`waitModalOpen`, `waitModalClose`, stable grid checks)  
- Robust selectors resilient to animations, async rendering, and modal transitions  
- Extensive Web Tables coverage: CRUD, pagination, search, boundary values, and invalid inputs  
- Forms validations: required fields, special characters, emails, mobile rules, image uploads, state/city linkage, and long-text handling  
- Upload & Download validations: re-upload of downloaded file, time constraints, input restrictions, fakepath display, and button accessibility  
- Dynamic Properties validations: delayed enablement, color change, visibility, random IDs, reload effects, and navigation consistency  
- Alerts, Frames & Windows validations: immediate/timed alerts, confirm/prompt dialogs, single/nested frames, and new tab navigation  
- Widgets validations: accordion, auto-complete chips, tabs, and tooltips  
- API coverage: GET, CRUD, consistency checks, error handling (404s), hardening (double delete, deleted IDs not listed), headers, and performance  
- Defensive checks for boundaries, negative cases, and special characters  
- Performance and timing validations (API response <1500ms, file download <10s)  
- Accessibility checks (disabled/enabled buttons, readonly fields, input restrictions)  
- Mochawesome HTML reporting ready for CI/CD pipelines 

---

## **7. How to Extend**

- Add new scenarios in cypress/e2e/features/.
- Implement steps in cypress/e2e/step_definitions/steps.ts (or split by domain as the suite grows).
- Reuse helpers (waitModalOpen, countRowsOnPage, etc.) to avoid flakiness.
- Validate with npm run cypress:run.

---

## **8. Deliverables**

- Gherkin UI & API test suite
- TypeScript step definitions with reusable helpers
- Cypress + Cucumber + Mochawesome configured
- Runnable locally and in CI/CD

---

## **9. CI/CD Integration (GitHub Actions)**

Example workflow to run tests on every push/PR to main:
```
yaml

name: Cypress Tests

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  cypress-run:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v3

      - name: Set up Node.js
        uses: actions/setup-node@v3
        with:
          node-version: 18

      - name: Install dependencies
        run: npm install

      - name: Run Cypress tests (headless)
        run: npm run cypress:run

      - name: Upload Mochawesome report
        uses: actions/upload-artifact@v3
        with:
          name: mochawesome-report
          path: cypress/reports/html/

This can be extended to matrix builds, Docker images, or other CI systems (Jenkins, GitLab CI, Azure DevOps).
```
---

## **10. Known Issues / Limitations**

- DemoQA site instability: Occasional 502: Bad Gateway or timeouts (environment issue, not framework).
Workaround: retry execution; optionally use failOnStatusCode: false in cy.visit() for non-critical flows.
- Modal animations: Bootstrap transitions may render modals with opacity: 0 briefly. Use waitModalOpen and waitModalClose to avoid false negatives.
- Dynamic timing: “Dynamic Properties” elements may appear faster/slower depending on load; defensive assertions handle both cases.
- Data persistence: Web Tables data resets on reload; bulk ops are intended for short-lived sessions.

---

## **11. License**

This project is licensed under the [MIT License](LICENSE).
See the LICENSE file for details.

---

## **12. Author**

**Ricardo Cardoso** — [LinkedIn](https://www.linkedin.com/in/ricardoisgood)  
QA Engineer — Powering technology companies to deliver impactful products through high-standard QA practices.