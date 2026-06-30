import pandas as pd
import numpy as np

df = pd.read_csv("Loan Dataset.csv")

df.drop_duplicates(inplace=True)

df["Debt_to_Income_Ratio"] = (
    df["Outstanding_Debt"] / df["Annual_Income"]
)

df["Loan_to_Income_Ratio"] = (
    df["Loan_Amount_Requested"] / df["Annual_Income"]
)

# Replace Infinity with NaN
df.replace([np.inf, -np.inf], np.nan, inplace=True)

# Replace all NaN with 0
df.fillna(0, inplace=True)

# Save the cleaned CSV
df.to_csv("clean_loan_data.csv", index=False)

print("File saved successfully!")