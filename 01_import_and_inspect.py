import pandas as pd
from pathlib import Path

data_path = Path('sample_reads.csv')
data = pd.read_csv(data_path, na_values = ["NA","missing","NaN"])
print(data)

data.info()
print(data.head())


#Alternative without defining path
#import pandas as pd
#data = pd.read_csv('sample_reads.csv', na_values = ["NA","missing","NaN"])
#data.info()


# to run in Terminal:
#                1. docker build -t genomic-qc .
#                2. docker run --rm genomic-qc

# to install java & nextflow :conda install -c bioconda -c conda-forge nextflow openjdk -y