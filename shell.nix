{ pkgs ? import <nixpkgs> {} }:
let 
    myAppEnv = pkgs.poetry2nix.mkPoetryEnv {
        projectDir = ./.;
        editablePackageSources = {
            indi-jptr-whisker-plot-24h = ./indi_jptr_whisker_plot_24h;
        };
    };
in myAppEnv.env.overrideAttrs (oldAttrs: {
    buildInputs = with pkgs ; [
        direnv
        poetry
	vscode
    ];
    nativeBuildInputs = with pkgs ; [
        python39.pkgs.flit-core
    ];
    LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib";
    DISPLAY=":0";
})
