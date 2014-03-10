MEANStackSetup
==============

Quick bash setup script to put together a MEAN (Mongo, Express, Angular, Node) stack app using [MEAN.io's repo](https://github.com/linnovate/mean) in 1 minute! For quick setup for hackathons and such. ;)

Keywords: MongoDB, ExpressJS, AngularJS, NodeJS, MEAN, stack, setup, script, init, repo, bash, unix, shell.


### Usage
 1. Create a folder to scaffold app in, ideally an empty folder but can be a fresh clone of an empty git repo too.
 3. Open up Terminal or whatever command line tool you use, and cd into the folder which will be the root of the app.
 4. Run the mean.sh script (it doesn't have to reside in the same folder), and it should do the rest!
    - This will install Brew, Git, Node, Bower, Grunt, Heroku Toolbelt, MongoDB, and any other packages defined by mean.io.
    - Lazy? Run this from bash: `bash <(curl -s https://raw.github.com/carlinyuen/MEANStackSetup/master/mean.sh)`

### License
MIT
