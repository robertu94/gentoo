# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_5,3_6} pypy pypy3 )

inherit distutils-r1

DESCRIPTION="Database of countries, subdivisions, languages, currencies and script"
HOMEPAGE="https://bitbucket.org/flyingcircus/pycountry"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	# https://bitbucket.org/techtonik/pycountry/issue/8/test_locales-pycountry-015-pypy
	pushd "${BUILD_DIR}"/lib > /dev/null
	if [[ "${EPYTHON}" == pypy || "${EPYTHON}" == pypy3 ]]; then
		sed -e 's:test_locales:_&:' -i pycountry/tests/test_general.py || die
	fi
	py.test ${PN}/tests/test_general.py || die
	popd > /dev/null
}
