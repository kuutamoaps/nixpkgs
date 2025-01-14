{ lib
, buildPythonPackage
, fetchPypi
, packaging
, setuptools-scm
, shapely
, sqlalchemy
, psycopg2
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "GeoAlchemy2";
  version = "0.11.1";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-+SoPrdtbdDhNu/PHAAQzNYzo4HoYD+HWwoQ+qgQ3/wg=";
  };

  nativeBuildInputs = [
    setuptools-scm
  ];

  propagatedBuildInputs = [
    packaging
    shapely
    sqlalchemy
  ];

  checkInputs = [
    psycopg2
    pytestCheckHook
  ];

  disabledTestPaths = [
    # tests require live postgis database
    "tests/gallery/test_decipher_raster.py"
    "tests/gallery/test_length_at_insert.py"
    "tests/gallery/test_summarystatsagg.py"
    "tests/gallery/test_type_decorator.py"
    "tests/test_functional.py"
  ];

  meta = with lib; {
    description = "Toolkit for working with spatial databases";
    homepage =  "http://geoalchemy.org/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };

}
