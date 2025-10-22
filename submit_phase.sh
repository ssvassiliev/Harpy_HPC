#!/bin/bash
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=3000
#$SBATCH --time=3:0:0

PREFIX=/project/def-rebekaho
module load python/3.11.5 arrow/21.0.0 r/4.5.0

source $PREFIX/env-harpy/bin/activate
export PATH=$PATH:$PREFIX/harpy-3.1/quarto-1.8.25/bin:$PREFIX/harpy-3.1/HapCUT2/build:$PREFIX/harpy-3.1/HapCUT2/utilities

export R_LIBS=$PREFIX/R/$EBVERSIONR/

harpy phase --threads 10 SNP/mpileup/variants.raw.bcf Align/bwa/
