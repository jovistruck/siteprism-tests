## README
####Pre-requisites

* Xcode 7 (Command Line tools - make sure you have accepted the license)
* qt5 (If installed using homebrew ensure that the symlink to /usr/local/bin has been applied)
 * `brew update`
 * `brew install qt`
 * `gem install capybara-webkit`

#### Ruby version
* 2.2.3
 * If you need to install ruby, the first part of the following page is very useful: https://gorails.com/setup/osx/10.10-yosemite

#### System dependencies
* capybara
* capybara-screenshot
* cucumber
* phantomjs
* poltergeist
* pry
* rspec
* rspec-expectations
* selenium-webdriver
* site_prism

#### Bundled with bundler
* 1.11.2

#### Configuration
* Open a terminal and *Clone* the repo into an appropriate folder into your local environment
* Assuming you still have the terminal open, make sure you are in the local repo folder 'oscar-smoke-tests'
* If you don't have bundler installed, install it now: 
  * `gem install bundler`
  
* Then run:  
   * `bundle update`

Any errors encountered here will be related to individual gem packages, that are missing some dependencies, or require sudo permissions to be installed

  e.g. to install capybara-webkit sudo privileges are required, if this still does not work 
  you may need to install xcode command line tools and/or qt5 see pre-requisite section for 
  help, or better yet use google!

#### How to run the test suite
* To run the default profile (output will be on both console and as an html file stored in a reports folder):
   * `bundle exec cucumber`
* If you want to run against a specific target (`staging/live`) you can supply that as profile:
   * `bundle exec cucumber -p <environment>`

#### How to analyse results
* The first few lines will tell you which environment the tests are running against and also where a friendly html report will be stored on your local machine.
* When run locally the console output is the first port of call as it provides enough information to see what tests are failing and usually gives enough information as to what has gone wrong.
* Once a run is completed the html report is stored in the reports directory as described in the console output, the file will be prefixed with a date-time stamp.
* If you find issues in the tests themselves, the console output provides some fairly good debugging information.

#### What next?
* see the [Wiki](https://github.com/springernature/oscar-smoke-tests/wiki) for tips on writing feature files, step definition files and page objects.
# siteprism-tests
