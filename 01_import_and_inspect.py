import pandas as pd
from pathlib import Path

data_path = Path('sample_reads.csv')
data = pd.read_csv(data_path, na_values=["NA","missing","NaN"])
print(data)

data.info()
print(data.head())