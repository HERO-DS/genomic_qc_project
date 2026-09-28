nextflow.enable.dsl=2

/*
   Pipeline Parameters (with defaults)
*/
params.input  = "*.fastq"
params.outdir = "results"

/*
   Process 1: Run FastQC
*/
process FASTQC {
    tag "FastQC on ${reads.fileName}"
    publishDir "${params.outdir}/fastqc", mode: 'copy'

    input:
    path reads

    output:
    path "*_fastqc.{zip,html}", emit: qc_files

    script:
    """
    fastqc ${reads}
    """
}

/*
   Process 2: Aggregate with MultiQC
*/
process MULTIQC {
    publishDir "${params.outdir}/multiqc", mode: 'copy'

    input:
    path qc_files

    output:
    path "multiqc_report.html", emit: report
    path "multiqc_data", emit: data

    script:
    """
    multiqc .
    """
}

/*
   Workflow Execution
*/
workflow {
    log.info """
    ==================================================
    G E N O M I C   Q C   P I P E L I N E
    ==================================================
    Input files : ${params.input}
    Output dir  : ${params.outdir}
    ==================================================
    """

    fastq_ch = Channel.fromPath(params.input, checkIfExists: true)
    FASTQC(fastq_ch)
    MULTIQC(FASTQC.out.qc_files.collect())
}