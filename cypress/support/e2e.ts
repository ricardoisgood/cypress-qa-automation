// cypress/support/e2e.ts
import "@badeball/cypress-cucumber-preprocessor/commands";
import "cypress-mochawesome-reporter/register";
import 'cypress-downloadfile/lib/downloadFileCommand';
import "cypress-real-events/support";

Cypress.on('uncaught:exception', () => false);

import './commands';