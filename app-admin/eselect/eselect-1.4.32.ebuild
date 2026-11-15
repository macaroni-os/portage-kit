# Distributed under the terms of the GNU General Public License v2
# Autogen by MARK Devkit

EAPI=7
inherit autotools bash-completion-r1

DESCRIPTION="A multi-purpose configuration and management tool"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Eselect"
SRC_URI="https://dev.gentoo.org/~ulm/eselect/eselect-1.4.32.tar.xz -> eselect-1.4.32.tar.xz"
LICENSE="GPL-2+ || ( GPL-2+ CC-BY-SA-3.0 )"
SLOT="0"
KEYWORDS="*"
PATCHES=(
	"${FILESDIR}/eselect-macaronictl-env-update-1.4.23.patch"
	"${FILESDIR}/eselect-macaroni-news-dir.patch"
)
IUSE="doc emacs vim-syntax"
RDEPEND="sys-apps/sed
	|| (
	  sys-apps/coreutils
	  sys-freebsd/freebsd-bin
	  app-misc/realpath
	)
	sys-apps/file
	sys-libs/ncurses:0
	
"
DEPEND="${RDEPEND}
	doc? ( dev-python/docutils )
	
"
PDEPEND="emacs? ( app-emacs/eselect-mode )
	vim-syntax? ( app-vim/eselect-syntax )
	
"
src_prepare() {
	default

	eautoreconf
}

src_compile() {
	emake
	use doc && emake html
}

src_install() {
	emake DESTDIR="${D}" install
	newbashcomp misc/${PN}.bashcomp ${PN}
	dodoc AUTHORS ChangeLog NEWS README TODO doc/*.txt
	if use doc; then
		docinto html
		dodoc *.html doc/*.html doc/*.css
	fi

	# needed by news module
	keepdir /var/lib/macaroni/news
	if ! use prefix; then
		fowners root:portage /var/lib/macaroni/news
		fperms g+w /var/lib/macaroni/news
	fi
}

pkg_postinst() {
	# fowners in src_install doesn't work for the portage group:
	# merging changes the group back to root
	if ! use prefix; then
		chgrp portage "${EROOT}/var/lib/macaroni/news" \
			&& chmod g+w "${EROOT}/var/lib/macaroni/news"
	fi
}


# vim: filetype=ebuild
