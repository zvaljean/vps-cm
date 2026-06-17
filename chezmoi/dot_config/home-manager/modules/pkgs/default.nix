# https://nix-community.github.io/home-manager/index.xhtml#sec-module-auto-importing
# modules/pkgs/default.nix
{ lib, ... }:

let
  # 读取当前目录下的所有文件和文件夹
  dir = builtins.readDir ./.;

  # 按照官方源码的规则定义过滤条件
  autoImportFilter = name: type:
    let
      # 规则1：常规文件必须以 .nix 结尾，且不能是当前的 default.nix
      isValidFile = type == "regular" && name != "default.nix" && lib.strings.hasSuffix ".nix" name;
      # 规则2：允许子目录 (通常子目录里会有自己的 default.nix 或被上层按路径引入)
      isValidDir = type == "directory";
      # 规则3：排除任何以 "_" 开头的文件或文件夹 (类似 _experimental.nix)
      isNotIgnored = !(lib.strings.hasPrefix "_" name);
    in
      isNotIgnored && (isValidFile || isValidDir);

  # 获取所有符合条件的文件/文件夹名称
  validModules = builtins.filter (name: autoImportFilter name dir.${name}) (builtins.attrNames dir);
in
{
  # 映射为实际的相对路径并交给 Home Manager 的 imports 处理
  imports = map (name: ./${name}) validModules;
}
