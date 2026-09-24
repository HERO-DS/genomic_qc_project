import pandas as pd

df = pd.read_csv("cleaned_reads.csv")
print(df.head())

df_metrics = df.groupby('sample_type')[['phred_score','gc_content']].mean()
print(df_metrics.head())