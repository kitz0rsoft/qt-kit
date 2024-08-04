# Distributed under the terms of the GNU General Public License v2

EAPI=7
KDE_ORG_COMMIT="9325659ec390eda5b160736a926ba58ccb445cce"

inherit qt5-build

DESCRIPTION="Set of Qt Quick controls to create complete user interfaces (deprecated)"
SRC_URI="https://invent.kde.org/qt/qt/qtquickcontrols/-/archive/9325659ec390eda5b160736a926ba58ccb445cce/qtquickcontrols-9325659ec390eda5b160736a926ba58ccb445cce.tar.bz2 -> qtquickcontrols-9325659ec390eda5b160736a926ba58ccb445cce.tar.bz2"

KEYWORDS="*"

IUSE="+widgets"

DEPEND="
	=dev-qt/qtcore-5.15.2*
	=dev-qt/qtdeclarative-5.15.2*
	=dev-qt/qtgui-5.15.2*
	widgets? ( =dev-qt/qtwidgets-5.15.2* )
"
RDEPEND="${DEPEND}"

src_prepare() {
	qt_use_disable_mod widgets widgets \
		src/src.pro \
		src/controls/Private/private.pri \
		tests/auto/activeFocusOnTab/activeFocusOnTab.pro \
		tests/auto/controls/controls.pro \
		tests/auto/testplugin/testplugin.pro

	qt5-build_src_prepare
}