**Normal Sequencing pipeline paired with tumor sequencing**
- contains aws setup script: setup_insance.sh
- Normal sequencing pipeline discover SNV's single nucleotide variants
- Tumor sequencing pipeline discover SV's structural variants
- Produces one unified report including SNV's for normal sequence analysis and SV's for cancer specific analysis

**Pipeline:**

Sarek somatic
|
|------> Mutect2 --> MAVIS  \
|                            ------> Normalization layer --> one TSV   
|------> Manta --> VEP      /


Testing Data:
- HCC1395 tumor + HCC1395BL matched normal
- 1st test on chromosome 17
- tested on high-confidence benchmark calls


1. Start project:
    - ```bash conda activate nf-core-env```
    - test sarek CPU only: ```bash nextflow run nf-core/sarek -profile test,docker -c nextflow.config --outdir results -resume```
    - test sarek GPU: ```bash nextflow run nf-core/sarek -profile test,docker,gpu -c nextflow.config -c parabricks.config --aligner parabricks --outdir results-parabricks -with-trace```
    - test sarek somatic ```nextflow run nf-core/sarek -profile test full,docker -c nextflow.config --outdir results_somatic --tools strelka```