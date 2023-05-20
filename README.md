# prometheus installer

download installer 

  - `git clone https://github.com/MoeinTavakoli/prometheus-installer.git`

copy and .env.example as .env and fill blanks

  - `cp .env.example .env`
  - `nano .env` 

env variables
  - `PROMETHEUS_VERSION` : version of prometheus that you want to install it 

     you can check out all version from [here](https://github.com/prometheus/prometheus/releases)

grant execute access to files 

  - `sudo chmod a+x *.sh`

install dependencies and install prometheus:

  - `source requirement.sh && source install.sh`