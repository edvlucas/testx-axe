reporters = require 'testx-jasmine-reporters'

exports.config =
  directConnect: true
  specs: ['specs/*']

  capabilities:
    browserName: 'chrome'
    shardTestFiles: false
    count: 1
    maxInstances: 10
    chromeOptions:
      args: ['no-sandbox']


  framework: 'jasmine'
  jasmineNodeOpts:
    silent: true
    defaultTimeoutInterval: 300000
    includeStackTrace: false

  baseUrl: 'http://localhost:4201/'

  # plugins: [
  #   # {
  #   #   chromeA11YDevTools: {
    #     treatWarningsAsFailures: true,
    #     auditConfiguration: {
    #       auditRulesToRun: [
    #         'audioWithoutControls',
    #         'badAriaAttributeValue',
    #         'badAriaRole',
    #         'controlsWithoutLabel',
    #         'elementsWithMeaningfulBackgroundImage',
    #         'focusableElementNotVisibleAndNotAriaHidden',
    #         'imagesWithoutAltText',
    #         'linkWithUnclearPurpose',
    #         'lowContrastElements',
    #         'mainRoleOnInappropriateElement',
    #         'nonExistentAriaLabelledbyElement',
    #         'pageWithoutTitle',
    #         'requiredAriaAttributeMissing',
    #         'unfocusableElementsWithOnClick',
    #         'videoWithoutCaptions'
    #       ],
    #       auditRulesToSkip: []
    #     }
    #   },
    #   package: 'protractor-accessibility-plugin'
    # },
    # {
    #   axe: true,
    #   package: 'protractor-accessibility-plugin'
    # },
    # # {
    #   tenonIO: {
    #     options: {
    #       key: 'http://tenon.io/documentation/understanding-request-parameters.php',
    #       url: 'http://localhost:4201'
    #     },
    #     printAll: true,
    # },
    # chromeA11YDevTools: true,
    # package: 'protractor-accessibility-plugin'
    # }
  # ]

  plugins: [{
    axe: true,
    package: 'protractor-accessibility-plugin'
  }]


  # plugins: [{
  #   tenonIO: {
  #     options: {
  #     },
  #     printAll: false,
  #   },
  #   chromeA11YDevTools: true,
  #   package: 'protractor-accessibility-plugin'
  # }]


  onPrepare: ->
    require 'testx'
    testx.objects.add require './objects'
    testx.keywords.add(require('testx-http-keywords'))
    testx.objects.add require 'testx-standard-objects'
    testx.keywords.add(require './keywords')

    # comment next line for angular.js apps
    beforeEach -> browser.ignoreSynchronization = true
    
    reporters
      junit: # set to false to omit this reporter
        dir: 'testresults/junit' # defaults to 'testresults/junit'
        file: 'junit' # defaults to 'junit'
      html:  # set to false to omit this reporter
        dir: 'testresults/html' # defaults to 'testresults/html'
      spec:  # set to false to omit this reporter
        displayStacktrace: true    # display stacktrace for each failed assertion, values: (all|specs|summary|none)
        displayFailuresSummary: true # display summary of all failures after execution
        displayPendingSummary: true  # display summary of all pending specs after execution
        displaySuccessfulSpec: true  # display each successful spec
        displayFailedSpec: true      # display each failed spec
        displayPendingSpec: false    # display each pending spec
        displaySpecDuration: false   # display each spec duration
        displaySuiteNumber: false    # display each suite number (hierarchical)
        colors:                      # set to false to disable colors
          success: 'green'
          failure: 'red'
          pending: 'yellow'
        prefixes:
          success: '✓ '
          failure: '✗ '
          pending: '* '