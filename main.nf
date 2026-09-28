nextflow.enable.dsl=2

/*
   Process 1: Run FastQC on each raw FASTQ file individually
*/
process FASTQC {
    tag "FastQC on ${reads.fileName}"
    publishDir "results/fastqc", mode: 'copy'

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
   Process 2: Aggregate all FastQC outputs into a single MultiQC report
*/
process MULTIQC {
    publishDir "results/multiqc", mode: 'copy'

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
   Workflow: Connect Channels across Processes
*/
workflow {
    // 1. Create a channel for all FASTQ files in the directory
    fastq_ch = Channel.fromPath("*.fastq")

    // 2. Run FastQC on each FASTQ file
    FASTQC(fastq_ch)

    // 3. Collect all outputs from FastQC into a single list and pass to MultiQC
    MULTIQC(FASTQC.out.qc_files.collect())
}