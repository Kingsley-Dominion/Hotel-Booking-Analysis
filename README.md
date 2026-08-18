Hotel Booking Analysis
An exploratory data analysis project in R focused on understanding hotel booking patterns, cancellations, pricing, customer types, market segments, booking lead times, and length of stay.
The project uses a real-world hotel bookings dataset and applies data cleaning, transformation, statistical summaries, segmentation, and visualization to generate useful business insights.
Project Objectives
The main objectives of this project are to:
•	Analyze overall hotel booking performance.
•	Measure the hotel cancellation rate.
•	Examine Average Daily Rate (ADR).
•	Analyze average length of stay.
•	Identify monthly booking trends.
•	Compare cancellation rates across market segments.
•	Analyze booking behavior by customer type.
•	Examine the relationship between booking lead time and cancellations.
•	Categorize bookings based on lead time and length of stay.
•	Explore relationships between key numerical variables using correlation analysis.
•	Visualize important patterns using ggplot2 and corrplot.
Dataset
The project expects a CSV file named:
hotel_bookings.csv
The dataset is imported using:
hotel <- read.csv("C:/Users/HomePC/Documents/Projects/R/hotel_bookings.csv")
For portability, this absolute path should be changed to a relative path when sharing or deploying the project.
The script inspects the dataset structure and reports its number of rows and columns before beginning the analysis.
Technologies and Libraries
The analysis is implemented in R and uses the following packages:
•	tidyverse – Data manipulation and analysis
•	lubridate – Date and time operations
•	skimr – Data exploration
•	scales – Formatting and visualization support
•	dplyr – Data manipulation
•	ggplot2 – Data visualization
•	corrplot – Correlation matrix visualization
•	gridExtra – Arranging graphical outputs
•	viridis – Color palettes
The script automatically checks whether the required packages are installed and installs missing packages before loading them.
Data Preparation
Several preprocessing steps are performed before analysis.
Missing Values
The script checks for missing values across all columns and prints columns containing missing observations.
Rows with missing values in the children variable are subsequently removed.
Date Transformation
The arrival month is converted from month names into numeric values. An arrival_date variable is then constructed from:
•	Arrival year
•	Arrival month
•	Arrival day
Derived Variables
The analysis creates several useful variables:
Variable	Description
arrival_date	Complete hotel arrival date
total_guests	Adults + children + babies
total_nights	Week nights + weekend nights
is_cancelled	Factor representation of cancellation status
adr	Average Daily Rate, with negative values replaced by 0
revenue	ADR × total nights
booking_lead_band	Categorization of booking lead time
stay_type	Categorization of length of stay
arrival_season	Seasonal classification of arrival
The lead-time bands are Same Day, 1–30 Days, 31–90 Days, 91–180 Days, and 180+ Days. Stay types are categorized as No Stay, Short Stay, Medium Stay, and Long Stay.
Key Performance Indicators
The project calculates several high-level hotel performance indicators:
Total Bookings
The total number of records remaining after data preparation.
Cancellation Rate
The percentage of bookings that were cancelled.
Average Daily Rate
The average value of the adr variable.
Average Length of Stay
The average number of nights represented by each booking.
These KPIs are calculated and printed as part of the analysis.
Analysis Performed
1. Monthly Booking Trends
Bookings are grouped by arrival year and arrival month to calculate:
•	Number of bookings
•	Number of cancellations
•	Average ADR
This produces the data used for the monthly booking trend visualization.
2. Market Segment Analysis
Bookings are grouped by market_segment to calculate:
•	Number of bookings
•	Cancellation rate
•	Average ADR
The resulting summary is ordered by booking volume.
3. Customer Type Analysis
The project analyzes customer types based on:
•	Number of bookings
•	Cancellation rate
•	Average ADR
This allows differences in pricing and cancellation behavior between customer categories to be explored.
4. Booking Lead Time
Bookings are grouped into lead-time bands ranging from same-day bookings to bookings made more than 180 days in advance.
The project also compares average and median lead time between cancelled and non-cancelled bookings.
5. Seasonality
An additional seasonal variable is created to classify arrivals into:
•	Winter
•	Spring
•	Summer
•	Autumn
The seasonal classification is intended to support analysis of booking patterns across different periods of the year.
6. Correlation Analysis
The analysis selects several numerical variables for correlation analysis:
•	ADR
•	Total nights
•	Lead time
•	Total guests
•	Booking changes
A correlation heatmap is generated using corrplot and the viridis color palette.
Visualizations
The project generates the following visualizations:
ADR Distribution
A histogram showing the distribution of Average Daily Rate across hotel bookings.
Monthly Booking Trends
A line chart showing monthly booking volumes by arrival year.
Cancellation Rate by Market Segment
A horizontal bar chart comparing cancellation rates across market segments.
Average ADR by Customer Type
A bar chart comparing average daily rates across customer types.
Correlation Heatmap
A correlation heatmap showing relationships among selected numerical variables.
The visualization section of the script implements these plots using ggplot2 and corrplot.
Project Structure
A recommended project structure is:
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
The current R script displays the plots but does not explicitly save them as image files. The outputs/ directory above is therefore a recommended structure for future project organization.
How to Run
1. Install R
Install R from the official R Project website.
2. Open the Project
Open the R script:
Hotel Booking Analysis (1).R
3. Add the Dataset
Place hotel_bookings.csv in the project’s data/ directory.
For a shareable project, update the current absolute file path:
hotel <- read.csv("C:/Users/HomePC/Documents/Projects/R/hotel_bookings.csv")
to a relative path such as:
hotel <- read.csv("data/hotel_bookings.csv")
4. Install Dependencies
The script automatically installs packages that are missing from the R environment.
5. Run the Script
Execute the script from beginning to end. It will:
1.	Load the required libraries.
2.	Import the hotel booking data.
3.	Inspect the dataset.
4.	Check and handle missing values.
5.	Transform and create variables.
6.	Calculate KPIs.
7.	Generate analytical summaries.
8.	Perform exploratory analysis.
9.	Produce visualizations.
Example Outputs
The analysis produces console outputs for metrics such as:
TOTAL BOOKINGS: ...
CANCELLATION RATE: ... %
AVERAGE DAILY RATE: ...
AVERAGE LENGTH OF STAY: ... nights
It also generates graphical outputs for booking trends, ADR, cancellations, customer types, and correlations.
Important Implementation Notes
There are a few items to review before using the script as a fully reproducible project:
1.	File path
The dataset is currently referenced using a Windows-specific absolute path. A relative path is recommended.
2.	Correlation matrix
The final corrplot() call uses cor_matrix, but the script shown does not explicitly create cor_matrix. The correlation matrix should be created from numeric_vars before calling corrplot().
 	For example:
 	cor_matrix <- cor(numeric_vars, use = "complete.obs")
3.	Season variable
arrival_date_month is converted to numeric earlier in the script, while the later Season calculation compares it with month-name strings. This means that section should be revised if the seasonal variable is intended to be populated correctly.
4.	Revenue interpretation
The script calculates:
 	revenue = adr * total_nights
 	This should be treated as an analytical revenue proxy rather than necessarily the hotel’s recorded realized revenue.
Potential Business Questions
This project can be used to investigate questions such as:
•	When are hotel bookings highest?
•	Which market segments have the highest cancellation rates?
•	How does ADR differ between customer types?
•	Do customers who book further in advance have different cancellation behavior?
•	How long do customers typically stay?
•	What relationships exist between ADR, lead time, guests, nights, and booking changes?
•	How do booking patterns vary across seasons?
Future Improvements
Potential extensions to the project include:
•	Add automated saving of plots to the outputs/ directory.
•	Build an interactive dashboard using Shiny.
•	Add more detailed revenue analysis.
•	Analyze cancellation behavior by lead-time band.
•	Compare hotel types if the dataset contains multiple hotel categories.
•	Investigate country and distribution-channel patterns.
•	Add statistical tests to support observed differences.
•	Create a reproducible R Project (.Rproj) structure.
•	Add automated reporting using R Markdown or Quarto.
Conclusion
This project provides an exploratory framework for analyzing hotel booking data in R. It combines data preparation, KPI calculation, segmentation, exploratory analysis, correlation analysis, and visualization to examine booking behavior, cancellations, pricing, customer types, and stay characteristics.
The analysis can serve as a foundation for more advanced hotel revenue management, customer segmentation, cancellation prediction, and business intelligence work.
