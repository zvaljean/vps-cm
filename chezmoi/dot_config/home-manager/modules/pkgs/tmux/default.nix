{ config, pkgs, ... }:
  {
    _class = "homeManager";

  # xdg.configFile."test/test.sh" = {
  # executable = true; 
  # text = ''
  #     #!/usr/bin/env bash
  #     echo "Hello, data!"
  #     echo "system, x86_64-linux!"
  # '';
  # };

  programs.tmux = {
  enable = true;
  tmuxinator.enable = true;

  terminal = "screen-256color";
  baseIndex = 1;
  historyLimit = 5000;

  # programs.tmux.extraConfig
  # --- 2. 使用 extraConfig 追加原生配置 ---
  extraConfig = ''
      setw -g xterm-keys on
      set -s escape-time 10                     # faster command sequences
      set -sg repeat-time 600                   # increase repeat timeout
      set -s focus-events on
      set -g prefix2 None

    '';
  # 插件列表
  plugins = with pkgs.tmuxPlugins; [
    # 1. 简单写法：直接写插件包名
    sensible
    # 2. Vim 窗格无缝切换插件
    # 配合 Vim/Neovim 中的相应插件，可以用 Ctrl+hjkl 在 vim 窗口和 tmux 窗格间无缝穿梭
    vim-tmux-navigator
    # 3. 剪贴板增强插件
    # 允许在 vi 模式下用 'y' 复制内容，并自动同步到系统剪贴板
    {
      plugin = yank;
      extraConfig = ''
        # 自定义 yank 插件的行为
        set -g @yank_selection_mouse 'clipboard'
      '';
    } 
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
    {
      plugin = nord;
      extraConfig = ''
        # 如果主题有特定自定义项可以写在这里
      '';
    }
   ];
  };
}
