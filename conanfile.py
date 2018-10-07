from conans import ConanFile, CMake, tools
import os.path


class MkxpConan(ConanFile):
    name = "mkxp"
    version = "0.0.0"
    license = "GPLv2"
    url = "https://github.com/elizagamedev/mkxp-oneshot"
    description = "OneShot game runtime"
    settings = "os", "compiler", "build_type", "arch"
    generators = "cmake"
    exports_sources = "*"
    requires = (
        "boost/1.68.0@conan/stable",
        "openal/1.18.2@bincrafters/stable",
        "physfs/3.0.1@eliza/stable",
        "pixman/0.34.0@bincrafters/stable",
        "ruby/2.5.1@eliza/stable",
        "sdl2/2.0.8@bincrafters/stable",
        "sdl2_image/2.0.3@bincrafters/stable",
        "sdl2_ttf/2.0.14@eliza/stable",
        "sdl_sound-mkxp/1.0.1@eliza/stable",
        "sigc++/2.10.0@eliza/stable",
    )
    default_options = (
        "boost:without_test=True",
        "cygwin_installer:packages=xxd",
    )

    def build_requirements(self):
        if tools.os_info.is_windows:
            self.build_requires("cygwin_installer/2.9.0@bincrafters/stable")

    def build_configure(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def build(self):
        if tools.os_info.is_windows:
            cygwin_bin = self.deps_env_info["cygwin_installer"].CYGWIN_BIN
            with tools.environment_append({"PATH": [cygwin_bin],
                                           "CONAN_BASH_PATH": os.path.join(cygwin_bin, "bash.exe")}):
                self.build_configure()
        else:
            self.build_configure()

    def package(self):
        self.copy("*", dst="bin", src="bin")

    def imports(self):
        self.do_copy_deps(self.copy)

    def deploy(self):
        self.copy("*")
        self.do_copy_deps(self.copy_deps)

    def do_copy_deps(self, copy):
        deps = set(self.deps_cpp_info.deps)
        deps.discard("cygwin_installer")
        for dep in deps:
            copy("*.dll", dst="bin", src="bin", root_package=dep, keep_path=False)
