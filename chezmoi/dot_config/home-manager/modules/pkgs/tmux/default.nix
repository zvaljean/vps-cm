{ config, pkgs, ... }:
  {
    _class = "homeManager";

  xdg.configFile."test/test.sh" = {
  executable = true; 
  text = ''
      #!/usr/bin/env bash
      echo "Hello, data!"
      echo "system, x86_64-linux!"
  '';
  };

    programs.tmux = {
    enable = true;

    tmuxinator.enable = true;
    # programs.tmux.extraConfig
    # --- 2. 使用 extraConfig 追加原生配置 ---
    extraConfig = ''
      '';
    # 插件列表
    plugins = with pkgs.tmuxPlugins; [
      # 1. 简单写法：直接写插件包名
      sensible
      # 2. 高级写法：插件自带额外的 tmux 配置
      {
        plugin = resurrect;
        extraConfig = "set -g @resurrect-strategy-vim 'session'";
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '60' # 60分钟保存一次
        '';
      }
    ];
  };
}
