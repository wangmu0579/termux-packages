TERMUX_PKG_HOMEPAGE=https://www.gnu.org/software/gdb/
TERMUX_PKG_DESCRIPTION="The standard GNU Debugger that runs on many Unix-like systems and works for many programming languages"
TERMUX_PKG_DEPENDS="liblzma, libexpat, readline, ncurses"
TERMUX_PKG_VERSION=8.0.1
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://mirrors.kernel.org/gnu/gdb/gdb-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=3dbd5f93e36ba2815ad0efab030dcd0c7b211d7b353a40a53f4c02d7d56295e3
# gdb can not build with our normal --disable-static: https://sourceware.org/bugzilla/show_bug.cgi?id=15916
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--enable-python3interp
--with-python3-config-dir=$TERMUX_PREFIX/lib/python3.6/config-3.6m/
--with-python
--with-system-readline
--with-curses
--enable-static
ac_cv_func_getpwent=no
ac_cv_func_getpwnam=no
vi_cv_path_python3_pfx=$TERMUX_PREFIX
vi_cv_var_python3_version=3.6
"
TERMUX_PKG_RM_AFTER_INSTALL="share/gdb/python share/gdb/syscalls share/gdb/system-gdbinit"
TERMUX_PKG_MAKE_INSTALL_TARGET="-C gdb install"
TERMUX_PKG_BUILD_IN_SRC="yes"

TERMUX_PKG_DESCRIPTION+=" - with python support"

termux_step_pre_configure() {
	# Fix "undefined reference to 'rpl_gettimeofday'" when building:
        CPPFLAGS+=" -I${TERMUX_PREFIX}/include/python3.6m"
	LDFLAGS+=" -lpython3.6m"
	export gl_cv_func_gettimeofday_clobber=no
	export gl_cv_func_gettimeofday_posix_signature=yes
	export gl_cv_func_realpath_works=yes
	export gl_cv_func_lstat_dereferences_slashed_symlink=yes
	export gl_cv_func_memchr_works=yes
	export gl_cv_func_stat_file_slash=yes
	export gl_cv_func_frexp_no_libm=no
}
