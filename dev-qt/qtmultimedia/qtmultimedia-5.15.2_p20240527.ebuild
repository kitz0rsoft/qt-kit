# Distributed under the terms of the GNU General Public License v2

EAPI=7
KDE_ORG_COMMIT="53069c9c6eb52b744333812f42aed36c3db6e752"

inherit qt5-build

DESCRIPTION="Multimedia (audio, video, radio, camera) library for the Qt5 framework"
SRC_URI="https://invent.kde.org/qt/qt/qtmultimedia/-/archive/53069c9c6eb52b744333812f42aed36c3db6e752/qtmultimedia-53069c9c6eb52b744333812f42aed36c3db6e752.tar.bz2 -> qtmultimedia-53069c9c6eb52b744333812f42aed36c3db6e752.tar.bz2"

KEYWORDS="*"

IUSE="alsa gles2-only gstreamer openal pulseaudio qml widgets"

RDEPEND="
	=dev-qt/qtcore-5.15.2*
	=dev-qt/qtgui-5.15.2*[gles2-only=]
	=dev-qt/qtnetwork-5.15.2*
	alsa? ( media-libs/alsa-lib )
	gstreamer? (
		dev-libs/glib:2
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-bad:1.0
		media-libs/gst-plugins-base:1.0
	)
	pulseaudio? ( media-sound/pulseaudio[glib] )
	qml? (
		=dev-qt/qtdeclarative-5.15.2*
		gles2-only? ( =dev-qt/qtgui-5.15.2*[egl] )
		openal? ( media-libs/openal )
	)
	widgets? (
		=dev-qt/qtwidgets-5.15.2*[gles2-only=]
		media-libs/libglvnd
	)
"
DEPEND="${RDEPEND}
	gstreamer? ( x11-base/xorg-proto )
"


src_prepare() {
	sed -i -e '/CONFIG\s*+=/ s/optimize_full//' \
		src/multimedia/multimedia.pro || die

	qt_use_disable_config openal openal \
		src/imports/imports.pro

	qt_use_disable_mod qml quick \
		src/src.pro \
		src/plugins/plugins.pro

	qt_use_disable_mod widgets widgets \
		src/src.pro \
		src/gsttools/gsttools.pro \
		src/plugins/gstreamer/common.pri

	qt5-build_src_prepare
}

src_configure() {
	local myqmakeargs=(
		--
		$(qt_use alsa)
		$(qt_use gstreamer)
		$(qt_use pulseaudio)
	)
	qt5-build_src_configure
}