# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3+ )
inherit distutils-r1

DESCRIPTION="M.A.R.K. metatools -- autogeneration framework."
HOMEPAGE="https://github.com/macaroni-os/funtoo-metatools"

RESTRICT="network-sandbox"
DEPEND=">=dev-python/subpop-2.0.0[${PYTHON_USEDEP}]"
RDEPEND="
	app-arch/unzip
	>=dev-util/meson-1.2.0
	dev-python/beautifulsoup[${PYTHON_USEDEP}]
	dev-python/dict-toolbox[${PYTHON_USEDEP}]
	>=dev-python/httpx-0.24.0[${PYTHON_USEDEP}]
	>=dev-python/jinja-3[${PYTHON_USEDEP}]
	dev-python/packaging[${PYTHON_USEDEP}]
	dev-python/packaging-legacy[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	dev-python/pymongo[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/pyzmq[${PYTHON_USEDEP}]
	dev-python/rich[${PYTHON_USEDEP}]
	dev-python/toml[${PYTHON_USEDEP}]
	dev-python/xmltodict[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]"
IUSE=""
SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="*"
SRC_URI="https://github.com/macaroni-os/funtoo-metatools/archive/3ca77d7dac6b9256e161d0bce47c7f7eb85e6e96.zip -> metatools-1.3.8_pre20241118-3ca77d7.zip"
S="${WORKDIR}/funtoo-metatools-3ca77d7dac6b9256e161d0bce47c7f7eb85e6e96"


src_configure() {
	# Create setup.py
	sed -e "s/##VERSION##/${PV/_*/}/g" \
		setup.py.in > setup.py

	unset PYTHONPATH
	default
}

# vim: syn=ebuild noet ts=4