htdocs
========================

> This repository contains XAMPP Virtual Hosts Configuration.

Install
-------

In general, Install [XAMPP](https://www.apachefriends.org/index.html).

```bash
git clone git@github.com:shivapoudel/htdocs.git /d/htdocs
cd /d/htdocs

# Hosts
npm i -g hostile
hostile load hosts-config

# Sign SSL
./makecert.sh

# Install WP CLI
./bin/wp-cli-install

# Install Configs
./install-configs.sh
```

License
-------

Copyright (c) 2018 Shiva Poudel  
Licensed under the MIT license:  
<http://shivapoudel.mit-license.org/>
