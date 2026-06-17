{ config, pkgs, ... }:
  {
    _class = "homeManager";

    programs.tmux.enable = true;

    programs.tmux = {

    tmuxinator.enable = true;
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
