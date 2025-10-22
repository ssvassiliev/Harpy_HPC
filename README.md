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
patch -p0 < $PREFIX/Harpy_HPC/patches/snp_freebayes_envmodules.patch 
patch -p0 < $PREFIX/Harpy_HPC/patches/snp_mpileup_envmodules.patch
patch -p0 < $PREFIX/Harpy_HPC/patches/phase_envmodules.patch

cd ..
pip install --no-index click==8.1.7 multiqc future
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

# Install HapCUT2
git clone https://github.com/vibansal/HapCUT2
cd HapCUT2
module load htslib/1.22.1
make
chmod +x $PREFIX/harpy-3.1/HapCUT2/utilities/LinkFragments.py

# Install LEVIATHAN
cd $PREFIX/harpy-3.1
git clone --recursive https://github.com/morispi/LEVIATHAN
cd LEVIATHAN
./install.sh

# Install NAIBR
pip install git+https://github.com/pontushojer/NAIBR.git

# Submission
PREFIX=/project/def-rebekaho
module load python/3.11.5 arrow/21.0.0 r/4.5.0
source $PREFIX/env-harpy/bin/activate
export R_LIBS=$PREFIX/R/$EBVERSIONR/
export PATH=$PATH:$PREFIX/harpy-3.1/quarto-1.8.25/bin
# phase
export PATH=$PATH:$PREFIX/harpy-3.1/HapCUT2/build:$PREFIX/harpy-3.1/HapCUT2/utilities
# sv leviathan
export PATH=$PATH:$PREFIX/harpy-3.1/LEVIATHAN/bin:$PREFIX/harpy-3.1/LEVIATHAN/LRez/bin
# sv naibr
export PATH=$PATH:$PREFIX/harpy-3.1/NAIBR  

update snp_mpileup.smk!