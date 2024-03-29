# gulp modules
gulp          = require 'gulp'
runSequence   = require 'run-sequence'
gutil         = require 'gulp-util'
minifyHTML    = require 'gulp-minify-html'
del           = require 'del'
sass          = require 'gulp-sass'
shell         = require 'gulp-shell'
pjson         = require './package.json'

# gulp filter is optional, in case you need it
gulpFilter    = require 'gulp-filter'

# webpack modules
webpack                 = require 'webpack'
WebpackDevServer        = require 'webpack-dev-server'
webpackConfig           = require './webpack.config.js'
webpackProductionConfig = require './webpack.production.config.js'

# util
map     = require 'map-stream'
touch   = require 'touch'
_       = require 'lodash'
nib     = require 'nib'
jeet    = require 'jeet'
rupture = require 'rupture'


paths = {
    dest: 'public'
}

devServer = {}

# your webpack-dev-server port, default 8888
DEV_PORT = '8888'

# Load plugins
$ = require('gulp-load-plugins')()

gulp.task('sass', ->
    gulp.src('./src/styles/*.scss')
        .pipe(sass())
        .pipe(gulp.dest('./public/'))
)

# this is for PROD
gulp.task('minify-html', ->
    opts = {comments:true,spare:true}

    gulp.src('assets/**/*.html')
      .pipe(minifyHTML(opts))
      .pipe(gulp.dest(paths.dest))
      .pipe($.size())
)

# this is for PROD
gulp.task('copy-assets-ignore-html', ->

    gulp.src(['assets/**', '!assets/**/*.html'])
      .pipe(gulp.dest(paths.dest))
      .pipe($.size())
)

# this is for DEV
gulp.task('copy-assets', ->
    gulp.src(['assets/**'])
      .pipe(gulp.dest(paths.dest))
      .pipe($.size())
)
gulp.task('copy-doc-images', ->
    gulp.src(['src/scripts/components/articles/Doc_images/**'])
      .pipe(gulp.dest(paths.dest + '/Doc_images'))
      .pipe($.size())
)
gulp.task('copy-docs', ->
    gulp.src(['src/scripts/components/articles/jsxDocs/**'])
      .pipe(gulp.dest(paths.dest+ '/docs'))
      .pipe($.size())
)
gulp.task('copy-icons', ->
    gulp.src(['node_modules/icons/dist/css/svg/**'])
      .pipe(gulp.dest(paths.dest + '/svg'))
      .pipe($.size())
)
gulp.task "webpack:build", (callback) ->
  # Run webpack.
  webpack webpackProductionConfig, (err, stats) ->
    throw new gutil.PluginError("webpack:build", err)  if err
    gutil.log "[webpack:build]", stats.toString(colors: true)
    callback()
    return


# Create a single instance of the compiler to allow caching.
devCompiler = webpack(webpackConfig)
gulp.task "webpack:build-dev", (callback) ->

  # Run webpack.
  devCompiler.run (err, stats) ->
    throw new gutil.PluginError("webpack:build-dev", err)  if err
    gutil.log "[webpack:build-dev]", stats.toString(colors: true)
    callback()
    return

  return


gulp.task "webpack-dev-server", (callback) ->
  # Ensure there's a `./public/main.css` file that can be required.
  touch.sync('./' + paths.dest + '/main.css', time: new Date(0))

  # Start a webpack-dev-server.
  devServer = new WebpackDevServer(webpack(webpackConfig),
    contentBase: './' + paths.dest + '/'
    hot: true
    watchOptions:
      aggregateTimeout: 100
    noInfo: true
  )
  devServer.listen DEV_PORT, "0.0.0.0", (err) ->
    throw new gutil.PluginError("webpack-dev-server", err) if err
    gutil.log "[webpack-dev-server]", "http://localhost:"+DEV_PORT
    callback()

  return

gulp.task('clean-dest', (done) ->
    del([paths.dest + '/*'], done)
)

########################################################
# Below are the recommended gulp commands for new users
########################################################

# gulp  ( with no argument )
# description -- the same as build
gulp.task 'default', ->
  gulp.start 'build'


# pjson = './package.json'

gulp.task 'tarDistDate', shell.task([
  './packageRelease.sh help-prod public'
])

gulp.task 'tarDistVersion', shell.task([
  './packageRelease.sh help-prod public ' + pjson.version + ''
])


# gulp build
# description -- create a production ready snapshot into paths.dest folder ( default ./public )
gulp.task 'build', ['webpack:build', 'sass', 'copy-assets-ignore-html', 'minify-html',  'copy-icons', 'copy-docs', 'copy-doc-images']

# gulp dev
# description -- start a development server
gulp.task 'dev', ['copy-assets', 'copy-icons', 'copy-docs', 'copy-doc-images'], ->

  runSequence('sass', 'webpack-dev-server', () ->
    gulp.watch(['src/styles/**'], ['sass'])
    gulp.watch(['assets/**'], ['copy-assets', 'copy-docs', 'copy-doc-images'])
  )

 # gulp dev-tdd
# description -- start a development server plus test run automatically when cjsx file changes
gulp.task 'dev-tdd', ['dev']

# gulp clean
# description -- clean the paths.dest
gulp.task 'clean', ['clean-dest']
