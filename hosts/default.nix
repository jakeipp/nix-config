{ hostName, ... }:
{
  imports = [
    ./${hostName}
  ];
}

