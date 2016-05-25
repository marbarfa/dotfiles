_warn() { echo "$@" >&2; }
_die() { _warn "Error: $@"; kill -INT $$; }

d_main () {
  if [ $# -eq 0 ]; then
    _die 'Path argument missing'
  fi

  module=${2:-"web"}
  gulp dialog -m ${module} -p "views/main/${1}"
}

d_app () {
  if [ $# -eq 0 ]; then
    _die 'Path argument missing'
  fi

  module=${2:-"src"}
  gulp dialog -m ${module} -p "views/app/${1}"
}

d_pub () {
  if [ $# -eq 0 ]; then
    _die 'Path argument missing'
  fi

  module=${2:-"web"}
  gulp dialog -m ${module} -p "views/public/${1}"
}

c_main () {
  if [ $# -eq 0 ]; then
    _die 'Path argument missing'
  fi

  module=${2:-"web"}
  gulp comp -m ${module} -p "views/main/${1}"
}

c_pub () {
  if [ $# -eq 0 ]; then
    _die 'Path argument missing'
  fi

  module=${2:-"web"}
  gulp comp -m ${module} -p "views/public/${1}"
}

deb () {
    DEBUG=${1:-"*"} npm run ${2}
}

jin () {
	package=$1
	jspm install npm:$package
}

jig () {
	package=$1
	jspm install github:$package
}

jib () {
	package=$1
	jspm install bower:$package
}

ti () {
	package=$1
  t_flag=${2:-"A"}
	typings install -$t_flag $package -S
}

unj () {
  jspm uninstall $1
}

reset_web () {
	rm -rf ~/Library/Application\ Support/WebStorm*
	rm -rf ~/Library/Logs/WebStorm*
	rm -rf ~/Library/Caches/WebStorm*
	rm -rf ~/Library/Preferences/WebStorm*
}

to_stylus () {
	for file in "$@" ; do
		echo $file
		sass2stylus $file .
	done
}

do_it () {
	for file in "$@" ; do
		{
			sass2stylus $file "$2" 2>/dev/null
			echo $file
		} always {
			echo "FAILED: $file"
		}

	done
}
