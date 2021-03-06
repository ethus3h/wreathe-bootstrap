# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

DESCRIPTION="Wreathe"
HOMEPAGE="https://futuramerlin.com/"
SRC_URI="https://github.com/ethus3h/wreathe/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

S="${WORKDIR}/wreathe-${PV}"

src_prepare() {
	eapply_user
	rm -rfv boot.disabled
}

src_install() {
	GLOBIGNORE="README.md:.git:.gitattributes:.gitconfig:usr:man:Makefile:build:.egup.tags:Wreathe"
	insinto /
	doins -r *
	
	fperms +x /etc/skel/.bash*

	GLOBIGNORE="usr/bin"
	insinto /usr/
	doins -r usr/*

	unset GLOBIGNORE
	dobin usr/bin/*

	GLOBIGNORE="Wreathe/.Resources"
	insinto /Wreathe/
	doins -r Wreathe/*

	GLOBIGNORE="Wreathe/.Resources/7r2-Compatibility:Wreathe/.Resources/Scripts"
	insinto /Wreathe/.Resources/
	doins -r Wreathe/.Resources/*

	unset GLOBIGNORE
	exeinto /Wreathe/.Resources/Scripts/
	find Wreathe/.Resources/Scripts/ -type f -maxdepth 1 -exec doexe {} \;
	insinto /Wreathe/.Resources/Scripts/
	find Wreathe/.Resources/Scripts/ -maxdepth 1 \! -type f -exec doins -r {} \;

	GLOBIGNORE="Wreathe/.Resources/7r2-Compatibility/Scripts"
	insinto /Wreathe/.Resources/7r2-Compatibility/
	find Wreathe/.Resources/7r2-Compatibility/ -maxdepth 1 \! -name "Scripts" -exec doins -r {} \;

	unset GLOBIGNORE
	exeinto /Wreathe/.Resources/7r2-Compatibility/Scripts/
	doexe Wreathe/.Resources/7r2-Compatibility/Scripts/*

	unset GLOBIGNORE
}
