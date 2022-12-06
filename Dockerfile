FROM r-base
RUN apt-get update && apt-get install -y  git-core libcurl4-openssl-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev libgit2-dev libicu-dev libssl-dev libxml2-dev libharfbuzz-dev libfribidi-dev libfontconfig1-dev make pandoc zlib1g-dev && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /usr/local/lib/R/etc/ /usr/lib/R/etc/
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl', Ncpus = 4)" | tee /usr/local/lib/R/etc/Rprofile.site | tee /usr/lib/R/etc/Rprofile.site
RUN Rscript -e "install.packages('renv')"

RUN R -e 'install.packages("remotes")'
RUN Rscript -e 'remotes::install_version("shiny",upgrade="never", version = "1.7.3")'
RUN Rscript -e 'remotes::install_version("config",upgrade="never", version = "0.3.1")'
RUN Rscript -e 'remotes::install_version("testthat",upgrade="never", version = "3.1.5")'
RUN Rscript -e 'remotes::install_version("shinyWidgets",upgrade="never", version = "0.7.5")'
RUN Rscript -e 'remotes::install_version("readr",upgrade="never", version = "2.1.3")'
RUN Rscript -e 'remotes::install_version("golem",upgrade="never", version = "0.3.5")'
RUN Rscript -e 'remotes::install_version("dplyr",upgrade="never", version = "1.0.10")'

COPY ./renv.lock /

WORKDIR /
RUN Rscript -e "renv::restore(prompt = FALSE)"

# devtools::build() first
COPY jpdugoModulesforShiny_1.0.0.tar.gz /
RUN Rscript -e "install.packages('jpdugoModulesforShiny_1.0.0.tar.gz', repos = NULL, type='source')"

EXPOSE 8080
CMD R -e "options('shiny.port'=8080,shiny.host='0.0.0.0');jpdugoModulesforShiny::run_app()"
