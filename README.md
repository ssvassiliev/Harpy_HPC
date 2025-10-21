module load python/3.11.5 arrow/21.0.0 r/4.5.0
virtualenv --no-download --clear env-harpy
source env-harpy/bin/activate
wget https://github.com/pdimens/harpy/archive/refs/tags/3.1.tar.gz
tar xf 3.1.tar.gz
cd harpy-3.1/harpy

patch -p0 < ~/harpy_envmodules_alliance_patches/qc.envmodules.patch
patch -p0 < ~/harpy_envmodules_alliance_patches/workflow.envmodules.patch

cd ..
pip install --no-index click==8.1.7 multiqc
pip install .

# R
mkdir -p /project/def-rebekaho/R/$EBVERSIONR/
export R_LIBS=/project/def-rebekaho/R/$EBVERSIONR/
Rscript -e 'install.packages(c("knitr", "rmarkdown", "dplyr", "tidyr", "data.table"), repos="https://cloud.r-project.org/")'

# Install quarto
cd /project/def-rebekaho/harpy-3.1
wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.8.25/quarto-1.8.25-linux-amd64.tar.gz
tar xf quarto-1.8.25-linux-amd64.tar.gz
rm quarto-1.8.25-linux-amd64.tar.gz

# Submission
module load python/3.11.5 arrow/21.0.0 r/4.5.0
source /project/def-rebekaho/env-harpy/bin/activate
export PATH=$PATH:/project/def-rebekaho/harpy-3.1/quarto-1.8.25/bin
export R_LIBS=/project/def-rebekaho/R/$EBVERSIONR/
  