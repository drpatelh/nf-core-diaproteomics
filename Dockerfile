FROM nfcore/base:1.14
LABEL authors="Leon Bichmann" \
      description="Docker image containing all software requirements for the nf-core/diaproteomics pipeline"

# Install the conda environment
COPY environment.yml /
RUN conda env create --quiet -f /environment.yml && conda clean -a

# Add conda installation dir to PATH (instead of doing 'conda activate')
ENV PATH /opt/conda/envs/nf-core-diaproteomics-1.2.5dev/bin:$PATH

# Dump the details of the installed packages to a file for posterity
RUN conda env export --name nf-core-diaproteomics-1.2.5dev > nf-core-diaproteomics-1.2.5dev.yml

# Install DIAlignR from GitHub
RUN Rscript -e 'remotes::install_github("shubham1637/DIAlignR@d323ad7", dependencies=FALSE)'

# Instruct R processes to use these empty files instead of clashing with a local version
RUN touch .Rprofile
RUN touch .Renviron