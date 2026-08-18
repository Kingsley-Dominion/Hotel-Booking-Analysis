# 🏨 Hotel Booking Analysis in R

An exploratory data analysis project in **R** focused on understanding hotel booking patterns, cancellations, pricing, customer types, market segments, booking lead times, and length of stay.

The project uses a real-world hotel bookings dataset and applies **data cleaning, transformation, statistical summaries, segmentation, correlation analysis, and visualization** to generate useful business insights.

---

## 📌 Table of Contents

* [Project Overview](#-project-overview)
* [Project Objectives](#-project-objectives)
* [Dataset](#-dataset)
* [Technologies and Libraries](#-technologies-and-libraries)
* [Project Structure](#-project-structure)
* [Data Preparation](#-data-preparation)
* [Derived Variables](#-derived-variables)
* [Key Performance Indicators](#-key-performance-indicators)
* [Analysis Performed](#-analysis-performed)
* [Visualizations](#-visualizations)
* [How to Run](#-how-to-run)
* [Implementation Notes](#-implementation-notes)
* [Business Questions](#-business-questions)
* [Future Improvements](#-future-improvements)
* [Conclusion](#-conclusion)

---

## 🔎 Project Overview

The objective of this project is to explore hotel booking data and identify patterns that can support better understanding of:

* Booking performance
* Cancellation behavior
* Average Daily Rate (ADR)
* Length of stay
* Booking seasonality
* Market segments
* Customer types
* Booking lead times
* Relationships between key numerical variables

The analysis combines **data wrangling, exploratory data analysis (EDA), descriptive statistics, segmentation, and visualization** using R.

---

## 🎯 Project Objectives

The main objectives of this project are to:

* Analyze overall hotel booking performance.
* Calculate the hotel cancellation rate.
* Examine Average Daily Rate (ADR).
* Analyze average length of stay.
* Identify monthly booking trends.
* Compare cancellation rates across market segments.
* Analyze booking behavior by customer type.
* Examine the relationship between booking lead time and cancellations.
* Categorize bookings based on lead time and length of stay.
* Explore relationships between key numerical variables using correlation analysis.
* Visualize important patterns using `ggplot2` and `corrplot`.

---

## 📊 Dataset

The project uses a hotel bookings dataset stored as:

```text
hotel_bookings.csv
```

The original script imports the dataset using a Windows-specific absolute path:

```r
hotel <- read.csv(
  "C:/Users/HomePC/Documents/Projects/R/hotel_bookings.csv"
)
```

For portability and reproducibility, the recommended approach is to use a relative path:

```r
hotel <- read.csv("data/hotel_bookings.csv")
```

The script also inspects the dataset structure and reports the number of rows and columns before beginning the analysis.

---

## 🛠️ Technologies and Libraries

The project is implemented in **R** using the following packages:

| Package     | Purpose                              |
| ----------- | ------------------------------------ |
| `tidyverse` | Data manipulation and analysis       |
| `dplyr`     | Data transformation and aggregation  |
| `lubridate` | Date and time operations             |
| `skimr`     | Exploratory data inspection          |
| `scales`    | Formatting and visualization support |
| `ggplot2`   | Data visualization                   |
| `corrplot`  | Correlation matrix visualization     |
| `gridExtra` | Arranging graphical outputs          |
| `viridis`   | Color palettes                       |

The script automatically checks whether the required packages are installed and installs missing packages before loading them.

---

## 📁 Project Structure

A recommended project structure is:

```text
Hotel-Booking-Analysis/
│
├── README.md
├── Hotel Booking Analysis (1).R
│
├── data/
│   └── hotel_bookings.csv
│
└── outputs/
    ├── adr_distribution.png
    ├── monthly_booking_trends.png
    ├── cancellation_by_market_segment.png
    ├── customer_type_adr.png
    └── correlation_heatmap.png
```

> **Note:** The current R script displays the visualizations but does not explicitly save them as image files. The `outputs/` directory is therefore recommended for future project organization.

---

# 🧹 Data Preparation

Before performing the analysis, the dataset goes through several preprocessing steps.

## Missing Values

The script checks for missing values across all columns and identifies columns containing missing observations.

Rows with missing values in the `children` variable are subsequently removed.

Example:

```r
colSums(is.na(hotel))
```

---

## 📅 Date Transformation

The `arrival_date_month` variable is converted from month names into numeric values.

An `arrival_date` variable is then constructed using:

* Arrival year
* Arrival month
* Arrival day

This makes it easier to perform time-based analysis and seasonal comparisons.

---

# 🔧 Derived Variables

Several variables are created to make the analysis more meaningful.

| Variable            | Description                                              |
| ------------------- | -------------------------------------------------------- |
| `arrival_date`      | Complete hotel arrival date                              |
| `total_guests`      | Adults + children + babies                               |
| `total_nights`      | Week nights + weekend nights                             |
| `is_cancelled`      | Factor representation of cancellation status             |
| `adr`               | Average Daily Rate, with negative values replaced by `0` |
| `revenue`           | `ADR × total_nights`                                     |
| `booking_lead_band` | Categorization of booking lead time                      |
| `stay_type`         | Categorization of length of stay                         |
| `arrival_season`    | Seasonal classification of arrival                       |

### Booking Lead-Time Bands

Bookings are categorized into:

| Lead-Time Band | Description                                |
| -------------- | ------------------------------------------ |
| Same Day       | Booking made on the arrival date           |
| 1–30 Days      | Booking made 1–30 days in advance          |
| 31–90 Days     | Booking made 31–90 days in advance         |
| 91–180 Days    | Booking made 91–180 days in advance        |
| 180+ Days      | Booking made more than 180 days in advance |

### Length-of-Stay Categories

Bookings are also classified into:

* **No Stay**
* **Short Stay**
* **Medium Stay**
* **Long Stay**

---

# 📈 Key Performance Indicators

The project calculates several high-level hotel performance indicators.

### Total Bookings

The total number of booking records remaining after data preparation.

### Cancellation Rate

The percentage of bookings that were cancelled.

### Average Daily Rate

The average value of the `adr` variable.

### Average Length of Stay

The average number of nights represented by each booking.

The results are printed to the console in a format similar to:

```text
TOTAL BOOKINGS: ...

CANCELLATION RATE: ... %

AVERAGE DAILY RATE: ...

AVERAGE LENGTH OF STAY: ... nights
```

---

# 🔍 Analysis Performed

## 1. 📅 Monthly Booking Trends

Bookings are grouped by **arrival year** and **arrival month**.

The analysis calculates:

* Number of bookings
* Number of cancellations
* Average ADR

This summary is then used to visualize booking volume across different months and years.

### Key Question

> When are hotel bookings highest, and how does booking activity change over time?

---

## 2. 🏷️ Market Segment Analysis

Bookings are grouped by `market_segment`.

For each segment, the analysis calculates:

* Number of bookings
* Cancellation rate
* Average ADR

The resulting summary is ordered by booking volume.

### Key Question

> Which market segments generate the most bookings and which have the highest cancellation rates?

---

## 3. 👥 Customer Type Analysis

The project analyzes booking behavior by customer type.

For each customer category, it calculates:

* Number of bookings
* Cancellation rate
* Average ADR

This makes it possible to identify differences in pricing and cancellation behavior between customer groups.

### Key Question

> How does booking behavior differ between customer types?

---

## 4. ⏳ Booking Lead Time

Bookings are grouped into lead-time categories ranging from same-day bookings to bookings made more than 180 days in advance.

The project also compares the **average and median lead time** between:

* Cancelled bookings
* Non-cancelled bookings

### Key Question

> Are bookings made further in advance more likely to be cancelled?

---

## 5. 🌦️ Seasonality Analysis

An `arrival_season` variable is created to classify arrivals into:

* **Winter**
* **Spring**
* **Summer**
* **Autumn**

This provides a foundation for examining booking patterns across different seasons.

### Key Question

> How do booking patterns vary throughout the year?

---

## 6. 🔗 Correlation Analysis

The analysis examines relationships among selected numerical variables:

* ADR
* Total nights
* Lead time
* Total guests
* Booking changes

A correlation matrix is generated and visualized using `corrplot`.

Example:

```r
cor_matrix <- cor(
  numeric_vars,
  use = "complete.obs"
)

corrplot(
  cor_matrix,
  method = "color"
)
```

### Key Question

> What relationships exist between pricing, lead time, guests, length of stay, and booking changes?

---

# 📊 Visualizations

The project produces several visualizations using `ggplot2` and `corrplot`.

## ADR Distribution

A histogram showing the distribution of **Average Daily Rate (ADR)** across hotel bookings.

```text
ADR Distribution
        │
        │       ▇
        │      ▇▇
        │    ▇▇▇
        │  ▇▇▇▇
        └────────────────
             ADR
```

---

## Monthly Booking Trends

A line chart showing monthly booking volumes by arrival year.

This visualization helps identify:

* Seasonal trends
* High-demand periods
* Year-over-year differences

---

## Cancellation Rate by Market Segment

A horizontal bar chart comparing cancellation rates across different market segments.

This makes it easier to identify segments with unusually high cancellation behavior.

---

## Average ADR by Customer Type

A bar chart comparing the average daily rate across customer types.

This helps highlight pricing differences between customer categories.

---

## Correlation Heatmap

A correlation heatmap showing relationships between selected numerical variables.

The visualization uses `corrplot` together with the `viridis` color palette.

---

# 🚀 How to Run

## 1. Install R

Download and install R from the official **R Project** website.

---

## 2. Clone or Download the Project

Clone this repository or download the project files to your computer.

---

## 3. Add the Dataset

Place `hotel_bookings.csv` inside the project's `data/` directory:

```text
Hotel-Booking-Analysis/
└── data/
    └── hotel_bookings.csv
```

---

## 4. Update the File Path

For a shareable project, use a relative path instead of the original Windows-specific path.

### Recommended

```r
hotel <- read.csv("data/hotel_bookings.csv")
```

Instead of:

```r
hotel <- read.csv(
  "C:/Users/HomePC/Documents/Projects/R/hotel_bookings.csv"
)
```

---

## 5. Install Dependencies

The script automatically checks for missing packages and installs them before loading the required libraries.

---

## 6. Run the Script

Execute the R script from beginning to end.

The script will:

1. Load the required libraries.
2. Import the hotel booking data.
3. Inspect the dataset.
4. Check and handle missing values.
5. Transform and create variables.
6. Calculate KPIs.
7. Generate analytical summaries.
8. Perform exploratory analysis.
9. Generate visualizations.

---

# ⚠️ Implementation Notes

A few items should be reviewed before using the project as a fully reproducible analysis.

## 1. File Path

The dataset is currently referenced using a Windows-specific absolute path.

For portability, use:

```r
hotel <- read.csv("data/hotel_bookings.csv")
```

---

## 2. Correlation Matrix

The final `corrplot()` call uses `cor_matrix`, but the matrix needs to be explicitly created from `numeric_vars`.

Use:

```r
cor_matrix <- cor(
  numeric_vars,
  use = "complete.obs"
)
```

before calling:

```r
corrplot(cor_matrix)
```

---

## 3. Season Variable

`arrival_date_month` is converted to numeric earlier in the script.

However, the later season calculation compares this variable with month-name strings.

This logic should be revised so that the season classification operates on the correct month representation.

For example, the analysis can either:

* Keep the original month names for season classification, or
* Use numeric month values consistently.

---

## 4. Revenue Interpretation

The project calculates:

```r
revenue = adr * total_nights
```

This should be interpreted as an **analytical revenue proxy** rather than necessarily representing the hotel's actual realized revenue.

Actual revenue may differ because of factors such as:

* Discounts
* Taxes
* Additional services
* Deposits
* Changes or cancellations
* Other hotel-specific revenue adjustments

---

# 💡 Potential Business Questions

This project can be used to investigate questions such as:

* When are hotel bookings highest?
* Which market segments have the highest cancellation rates?
* How does ADR differ between customer types?
* Do customers who book further in advance have different cancellation behavior?
* How long do customers typically stay?
* What relationships exist between ADR, lead time, guests, nights, and booking changes?
* How do booking patterns vary across seasons?
* Which customer groups generate higher-value bookings?
* Which booking segments may require stronger cancellation policies?

---

# 🔮 Future Improvements

The project can be extended in several ways.

### Data & Analysis

* [ ] Add automated saving of plots to the `outputs/` directory.
* [ ] Add more detailed revenue analysis.
* [ ] Analyze cancellation behavior by lead-time band.
* [ ] Compare hotel types if the dataset contains multiple hotel categories.
* [ ] Investigate country and distribution-channel patterns.
* [ ] Add statistical tests to support observed differences.
* [ ] Explore relationships between deposit type and cancellation behavior.
* [ ] Analyze repeat guests and returning customers.

### Visualization & Reporting

* [ ] Create an interactive dashboard using **Shiny**.
* [ ] Improve visualization styling and consistency.
* [ ] Add interactive filters for hotel type, market segment, customer type, and season.
* [ ] Create automated reports using **R Markdown** or **Quarto**.

### Reproducibility

* [ ] Create a reproducible R Project (`.Rproj`) structure.
* [ ] Use relative file paths throughout the project.
* [ ] Add a package management solution such as `renv`.
* [ ] Automate data validation and preprocessing.

---

# 📌 Example Outputs

The analysis produces console outputs such as:

```text
TOTAL BOOKINGS: ...

CANCELLATION RATE: ... %

AVERAGE DAILY RATE: ...

AVERAGE LENGTH OF STAY: ... nights
```

It also produces visualizations covering:

| Output                               | Description                             |
| ------------------------------------ | --------------------------------------- |
| `adr_distribution.png`               | ADR distribution                        |
| `monthly_booking_trends.png`         | Monthly booking trends                  |
| `cancellation_by_market_segment.png` | Cancellation rate by market segment     |
| `customer_type_adr.png`              | Average ADR by customer type            |
| `correlation_heatmap.png`            | Correlation between numerical variables |

---

# 🏁 Conclusion

This project provides an exploratory framework for analyzing hotel booking data using **R**.

By combining **data preparation, KPI calculation, segmentation, exploratory analysis, correlation analysis, and visualization**, the project examines important aspects of hotel booking behavior, including:

* Booking volume
* Cancellations
* Pricing
* Customer types
* Market segments
* Lead times
* Length of stay
* Seasonality

The analysis can serve as a foundation for more advanced applications such as:

* **Hotel revenue management**
* **Customer segmentation**
* **Cancellation prediction**
* **Demand forecasting**
* **Pricing optimization**
* **Business intelligence**

Ultimately, this project demonstrates how exploratory data analysis can transform raw hotel booking data into insights that can support better business decision-making.
