Feature: Upload and Download

  Background:
    Given I open the Upload and Download page

  @ui @upload_download
  Scenario: Download a file and upload the same file
    When I click the Download button
    Then the file "sampleFile.jpeg" should be downloaded
    When I upload the downloaded file
    Then the uploaded file name should contain "sampleFile.jpeg"

    @ui @upload_download
Scenario: Download does not navigate away
  Given I open the Upload and Download page
  When I click the Download button
  Then the current path should still be "/upload-download"

@ui @upload_download
Scenario: Uploaded path shows fakepath and file name
  Given I open the Upload and Download page
  When I click the Download button
  Then the file "sampleFile.jpeg" should be downloaded
  When I upload the downloaded file
  Then I should see the uploaded file name displayed
  Then the uploaded path should include fakepath and the downloaded file name

@ui @upload_download
Scenario: Download finishes within 10s
  Given I open the Upload and Download page
  When I start the timer
  When I click the Download button
  Then the file "sampleFile.jpeg" should be downloaded
  Then the elapsed time should be below 10000 ms

@ui @upload_download
Scenario: Upload input accepts a single file
  Given I open the Upload and Download page
  Then the upload input should accept a single file only

@ui @upload_download
Scenario: Download button is accessible and enabled
  Given I open the Upload and Download page
  Then the download button should be accessible and enabled