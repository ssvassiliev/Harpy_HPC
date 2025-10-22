# Installation directory
PREFIX=/project/def-rebekaho

module load python/3.11.5 arrow/21.0.0 r/4.5.0

cd $PREFIX
git clone https://github.com/ssvassiliev/Harpy_HPC

virtualenv --no-download --clear env-harpy
source env-harpy/bin/activate
wget https://github.com/pdimens/harpy/archive/refs/tags/3.1.tar.gz
tar xf 3.1.tar.gz
cd harpy-3.1/harpy

patch -p0 < $PREFIX/Harpy_HPC/patches/qc.envmodules.patch
patch -p0 < $PREFIX/Harpy_HPC/patches/workflow.envmodules.patch
patch -p0 < $PREFIX/Harpy_HPC/patches/align_bwa_envmodules.patch

cd ..
pip install --no-index click==8.1.7 multiqc
pip install .

# R
mkdir -p $PREFIX/R/$EBVERSIONR/
export R_LIBS=$PREFIX/R/$EBVERSIONR/
Rscript -e 'install.packages(c("knitr", "rmarkdown", "dplyr", "tidyr", "data.table"), repos="https://cloud.r-project.org/")'

# Install quarto
cd $PREFIX/harpy-3.1
wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.8.25/quarto-1.8.25-linux-amd64.tar.gz
tar xf quarto-1.8.25-linux-amd64.tar.gz
rm quarto-1.8.25-linux-amd64.tar.gz

# Submission
PREFIX=/project/def-rebekaho
module load python/3.11.5 arrow/21.0.0 r/4.5.0
source $PREFIX/env-harpy/bin/activate
export PATH=$PATH:$PREFIX/harpy-3.1/quarto-1.8.25/bin
export R_LIBS=$PREFIX/R/$EBVERSIONR/
  