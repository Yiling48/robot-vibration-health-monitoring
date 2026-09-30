# Industrial Robot Vibration Health Monitoring

A team project that explored vibration-signal analysis for industrial robotic-arm health monitoring and translated the analytical workflow into an R Shiny decision-support dashboard prototype.

> **Project type:** Team project  
> **My contribution:** Project planning, workflow design, presentation design, and R Shiny dashboard design / partial implementation.

## Overview

Industrial robotic arms can experience abnormal operating conditions that affect production efficiency and equipment reliability. This project used multi-axis vibration signals collected from four sensor positions to explore whether abnormal load conditions could be distinguished from signal characteristics.

The full team workflow covered signal preprocessing, frequency-domain analysis, feature extraction, Random Forest classification, cross-validation, and dashboard design.

## Data

The project used four 3-axis accelerometer positions:

| Sensor | Position |
|---|---|
| Xa | Horizontal motion — motor side |
| Xb | Horizontal motion — idler side |
| Ya | Vertical motion — motor side |
| Yb | Vertical motion — idler side |

The raw data are **not included in this repository** because the original dataset is not intended for public redistribution.

See [data/README.md](data/README.md) for details.

## Team Methodology

The team explored the following workflow:

1. Inspect raw vibration signals and remove non-vibration periods.
2. Transform signals into the frequency domain using Fast Fourier Transform (FFT).
3. Explore entropy-based features.
4. Extract segmented maximum-amplitude features from frequency spectra.
5. Train a Random Forest classifier.
6. Use K-fold cross-validation to assess model stability.
7. Design an R Shiny dashboard as a decision-support interface.

The project report states that the final Random Forest workflow achieved **over 95% classification accuracy** after model selection and cross-validation.

### Main team findings

- Entropy-based features were not retained in the final workflow.
- Segmented maximum-amplitude features produced more stable performance than the broader feature set.
- For horizontal motion, the idler-side sensor (**Xb**) showed stronger and more stable classification performance.
- For vertical motion, the motor-side sensor (**Ya**) performed better.

## My Contribution

My responsibilities focused on translating the analytical project into a clear and usable presentation and interface:

- Designed the project execution plan and workflow diagram.
- Organized and designed the project presentation.
- Designed the R Shiny dashboard structure and interaction flow.
- Participated in partial implementation of the dashboard.
- Helped define how users select sensor positions and upload vibration files for monitoring.

Because this was a team project, the modeling methodology above is presented as **team work**, while this section explicitly identifies my individual contribution.

## Dashboard Prototypes

Two R Shiny prototype scripts are included under [app/](app/):

### `Dashboard.R`

A basic upload-and-selection interface that allows users to:

- Select Xa / Xb / Ya / Yb.
- Upload up to 25 `.txt` files.
- Validate file count.
- Display selected position and uploaded filenames.

### `piechart.R`

A visualization prototype that extends the interface with:

- A pie-chart view.
- An interactive Plotly grid.
- Simulated values used to demonstrate the intended dashboard presentation.

> **Important:** The included dashboard scripts are interface prototypes. The current files do **not** contain the complete signal-processing and model-inference pipeline described in the team report.

## Repository Structure

```text
robot-vibration-health-monitoring/
├── README.md
├── app/
│   ├── Dashboard.R
│   └── piechart.R
├── R/
│   └── README.md
├── data/
│   └── README.md
├── figures/
│   └── README.md
├── report/
│   └── README.md
├── install_packages.R
└── .gitignore
```

## Run the Dashboard Prototype

Install the required packages:

```r
source("install_packages.R")
```

Then run either prototype:

```r
shiny::runApp("app/Dashboard.R")
```

or

```r
shiny::runApp("app/piechart.R")
```

## Tools

- R
- R Shiny
- ggplot2
- Plotly
- Signal processing
- Fast Fourier Transform (team methodology)
- Random Forest (team methodology)
- K-fold cross-validation (team methodology)

## Project Materials

The full written report is available in my Notion portfolio:

[Data Analytics & Science Portfolio](https://app.notion.com/p/Data-Analytics-Science-Portfolio-160bcf9053b6800198faddd8f6e6a8ab)

## Future Improvements

- Integrate the full preprocessing and feature-extraction pipeline into the Shiny app.
- Replace simulated dashboard values with model outputs.
- Add reproducible model-training scripts when redistribution rights for the source data and code are confirmed.
- Add screenshots and deployment instructions for the dashboard.

---
Portfolio repository maintained by **Yi-Ling Dai**.
