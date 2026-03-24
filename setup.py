import sys
from setuptools import setup, Extension, find_packages

extra_compile_args = []
if sys.platform.startswith("win"):
    extra_compile_args = ["/O2", "/std:c++17"]
else:
    extra_compile_args = ["-O3", "-std=c++17"]
    if sys.platform.startswith("linux") or sys.platform == "darwin":
        extra_compile_args.append("-fPIC")

cadscorelt_module = Extension(
    name="cadscorelt._cadscorelt_python",
    sources=["cadscorelt_python_wrap.cxx"],
    include_dirs=["cpp"],
    extra_compile_args=extra_compile_args,
    language="c++",
)

setup(
    name="cadscorelt",
    version="0.9.159",
    description="CAD-score-LT Python bindings via SWIG",
    long_description=open("README.md").read(),
    long_description_content_type="text/markdown",
    author="Kliment Olechnovic",
    author_email="kliment.olechnovic@gmail.com",
    url="https://github.com/kliment-olechnovic/cadscorelt_python",
    ext_modules=[cadscorelt_module],
    packages=find_packages(include=["cadscorelt", "cadscorelt.*"]),
    classifiers=[
        "Programming Language :: Python :: 3",
        "Programming Language :: C++",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires=">=3.6",
    zip_safe=False,
)
