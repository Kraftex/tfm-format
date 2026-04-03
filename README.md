# TFM ETSIInf
This is a template for TFM ETSIInf.
It uses Pixi for using Typst.

## How to start?
```bash
# Start downloading dependencies
pixi install
```

After the installation you can run one of the following commands.
```bash
# Most simple one, create PDF file (by default the name should be tfm.pdf)
pixi run compile

# Compile when a file has changed, this is going to block command line (Ctrl + C to stop)
pixi run watch

# You can also visualize while making modifications (by default uses your PDF viewer provide by open)
pixi run watch-pdf

# Also, if you want to start modifying files (by default uses gvim for editing files)
pixi run watch-edit

# Also you can see more information using
pixi task list
# Or reading pixi.toml to change some 
```
