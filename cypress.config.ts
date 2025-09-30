import { defineConfig } from "cypress";
import createBundler from "@bahmutov/cypress-esbuild-preprocessor";

export default defineConfig({
  e2e: {
    specPattern: "cypress/e2e/features/**/*.feature",
    supportFile: false,
    baseUrl: "https://demoqa.com",
    viewportWidth: 1366,
    viewportHeight: 768,
    video: false,
    downloadsFolder: "cypress/downloads",

    defaultCommandTimeout: 10000,
    pageLoadTimeout: 90000,
    chromeWebSecurity: false,

    setupNodeEvents: async (on, config) => {
      const cucumber = await import("@badeball/cypress-cucumber-preprocessor");
      const esbuild = await import("@badeball/cypress-cucumber-preprocessor/esbuild");

      config.env = config.env || {};
      config.env.TAGS = process.env.TAGS ?? config.env.TAGS ?? "";

      await cucumber.addCucumberPreprocessorPlugin(on, config);

      on(
        "file:preprocessor",
        createBundler({
          plugins: [esbuild.default(config)],
        })
      );

      require("cypress-mochawesome-reporter/plugin")(on);

      return config;
    },
  },

  reporter: "cypress-mochawesome-reporter",
  reporterOptions: {
    charts: true,
    reportPageTitle: "Cypress Test Report",
    embeddedScreenshots: true,
    inlineAssets: true,
  },
});
