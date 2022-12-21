# Monitoring

download installer 

  - `git clone -u dev https://github.com/MoeinTavakoli/prometheus-installer/branches`

copy and .env.example as .env and fill blanks

  - `cp .env.example .env`
  - `nano .env` 

grant execute access to files 

  - `sudo chmod a+x *.sh`

install dependencies and install prometheus:

  - `source requirement.sh && source install.sh`
