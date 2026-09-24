# from file 01
import pandas as pd
from pathlib import Path

data_path = Path('sample_reads.csv')
data = pd.read_csv(data_path, na_values=["NA","missing","NaN"])
print(data)

data.info()
print(data.head())

# 02 codes
data = data[~data['sequence'].str.contains('[-N]')]
median_score = data.phred_score.median()
data['phred_score'] = data['phred_score'].fillna(median_score)
print(data.head())
data.to_csv('cleaned_reads.csv', index=False)