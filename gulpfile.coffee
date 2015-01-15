gulp        = require 'gulp'
less        = require 'gulp-less'
concat      = require 'gulp-concat'
browserify  = require 'gulp-browserify'
zip         = require 'gulp-zip'
jeditor     = require 'gulp-json-editor'
livereload  = require 'gulp-livereload'
connect     = require 'connect'
connectjs   = require 'connect-livereload'
serve       = require 'serve-static'

Package     = require './package.json'

project =
  dist:     './dist'
  build:    './build'
  src:      './app/**/*.coffee'
  static:   './static/**'
  style:    './style/index.less'
  manifest: './manifest.json'

gulp.task 'default', ['pack']
gulp.task 'build', ['src', 'static', 'style', 'manifest']
gulp.task 'watch:serve', ['watch', 'serve']

gulp.task 'src', ->
  gulp.src('./app/index.coffee',  read: false)
    .pipe(browserify({
      transform:  ['coffeeify']
      extensions: ['.coffee']
    }))
    .pipe(concat('app.js'))
    .pipe(gulp.dest(project.build))

gulp.task 'static', ->
  gulp.src(project.static)
    .pipe(gulp.dest(project.build))

gulp.task 'style', ->
  gulp.src(project.style)
    .pipe(less())
    .pipe(concat('app.css'))
    .pipe(gulp.dest(project.build))

gulp.task 'manifest', ->
  gulp.src(project.manifest)
    .pipe(jeditor((json) ->
      json.version = Package.version
      json
    )).pipe(gulp.dest(project.build))

gulp.task 'pack', ['build'], ->
  gulp.src("#{project.build}/**")
    .pipe(zip("#{Package.name}-#{Package.version}.zip"))
    .pipe(gulp.dest(project.dist))

gulp.task 'serve', ['build'], ->
  app = connect()
  app.use(connectjs()).use(serve(project.build))
  app.listen(process.env['PORT'] or 4001)
  livereload.listen()
  gulp.watch("#{project.build}/**").on 'change', livereload.changed

gulp.task 'watch', ->
  gulp.watch(project.src, ['src'])
  gulp.watch(project.style, ['style'])
  gulp.watch(project.static, ['static'])
