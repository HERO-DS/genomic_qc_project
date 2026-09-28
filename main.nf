nextflow.enable.dsl=2

/* 
   Process 1: Run Quality Control via Python Docker Container 
*/
process RUN_GENOMIC_QC {
    container 'genomic-qc' // Uses local Docker image built earlier
    publishDir "results", mode: 'copy'

    input:
    path input_file

    output:
    path "cleaned_reads.csv", emit: cleaned_csv
    path "summary_report.txt", emit: report

    script:
    """
    python /app/02_clean_data.py
    python /app/03_summary_metrics.py > summary_report.txt
    """
}

/* 
   Workflow: Connect Channels and Execute Processes 
*/
workflow {
    // 1. Create a Channel pointing to the raw input file
    input_ch = Channel.fromPath("sample_reads.csv")

    // 2. Trigger the process with the channel input
    RUN_GENOMIC_QC(input_ch)
}