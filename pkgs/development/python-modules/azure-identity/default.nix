{ buildPythonPackage
, fetchPypi
, lib

# pythonPackages
, azure-common
, azure-core
, azure-nspkg
, cryptography
, mock
, msal
, msal-extensions
, msrest
, msrestazure
}:

buildPythonPackage rec {
  pname = "azure-identity";
  version = "1.9.0";

  src = fetchPypi {
    inherit pname version;
    extension = "zip";
    sha256 = "sha256-CFTRnaTFZEZBgU3E+VHELgFAC1eS8J37a/+nJti5Fg0=";
  };

  postPatch = ''
    substituteInPlace setup.py \
      --replace "msal-extensions~=0.3.0" "msal-extensions"
  '';

  propagatedBuildInputs = [
    azure-common
    azure-core
    azure-nspkg
    cryptography
    mock
    msal
    msal-extensions
    msrest
    msrestazure
  ];

  pythonImportsCheck = [ "azure.identity" ];

  # Requires checkout from mono-repo and a mock account:
  #   https://github.com/Azure/azure-sdk-for-python/blob/master/sdk/identity/tests.yml
  doCheck = false;

  meta = with lib; {
    description = "Microsoft Azure Identity Library for Python";
    homepage = "https://github.com/Azure/azure-sdk-for-python";
    license = licenses.mit;
    maintainers = with maintainers; [
      kamadorueda
    ];
  };
}
