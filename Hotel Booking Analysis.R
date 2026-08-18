

# 1. LOAD REQUIRED LIBRARIES

required_packages <- c(
  "tidyverse", "lubridate", "scales",
  "gridExtra", "corrplot", "viridis"
)
installed <- required_packages %in% installed.packages()
if (any(!installed)) {
  install.packages(required_packages[!installed])
}
library(tidyverse)
library(lubridate)
library(skimr)
library(scales)
library(dplyr)
library(ggplot2)
library(corrplot)
library(gridExtra)
library(viridis)
 
# 2. IMPORT REAL-LIFE DATASET
hotel <- read.csv("C:/Users/HomePC/Documents/Projects/R/hotel_bookings.csv")

cat("Dataset Structure:\n")
str(hotel)
cat("\nRows:", nrow(hotel), " Columns:", ncol(hotel), "\n\n")

# 3. DATA EXPLORATION & PREPARATION

# Check missing values
missing_values <- colSums(is.na(hotel))
print(missing_values[missing_values > 0])

# Convert month name to numeric
hotel$arrival_date_month <- match(
  hotel$arrival_date_month,
  month.name
)

# Create Arrival Date
hotel <- hotel %>%
  mutate(
    arrival_date = as.Date(
      paste(arrival_date_year,
            arrival_date_month,
            arrival_date_day_of_month,
            sep = "-")
    ),
    total_guests = adults + children + babies,
    total_nights = stays_in_week_nights + stays_in_weekend_nights,
    is_cancelled = as.factor(is_canceled),
    adr = ifelse(adr < 0, 0, adr) # clean invalid ADR
  )


# Remove rows with missing guest counts
hotel <- hotel %>% drop_na(children)

# 4. DATA MANIPULATION
# Key Performance Indicators
total_bookings <- nrow(hotel)
cancellation_rate <- mean(as.numeric(as.character(hotel$is_cancelled))) * 100
avg_adr <- mean(hotel$adr)
avg_stay <- mean(hotel$total_nights)

cat("TOTAL BOOKINGS:", total_bookings, "\n")
cat("CANCELLATION RATE:", round(cancellation_rate, 2), "%\n")
cat("AVERAGE DAILY RATE:", round(avg_adr, 2), "\n")
cat("AVERAGE LENGTH OF STAY:", round(avg_stay, 2), " nights\n\n")

# Booking Trends
monthly_trends <- hotel %>%
  group_by(arrival_date_year, arrival_date_month) %>%
  summarise(
    bookings = n(),
    cancellations = sum(is_cancelled == 1),
    avg_adr = mean(adr),
    .groups = "drop"
  )

# Market Segment Analysis
segment_summary <- hotel %>%
  group_by(market_segment) %>%
  summarise(
    bookings = n(),
    cancellation_rate = mean(is_cancelled == 1) * 100,
    avg_adr = mean(adr),
    .groups = "drop"
  ) %>%
  arrange(desc(bookings))

# Customer Type Analysis
customer_summary <- hotel %>%
  group_by(customer_type) %>%
  summarise(
    bookings = n(),
    cancellation_rate = mean(is_cancelled == 1) * 100,
    avg_adr = mean(adr),
    .groups = "drop"
  )


#booking_lead_band
Booking_lead_band <- hotel %>%
  mutate(
    booking_lead_band = cut(
      lead_time,
      breaks = c(-Inf, 0, 30, 90, 180, Inf),
      labels = c("Same Day", "1–30 Days", "31–90 Days", "91–180 Days", "180+ Days")
    ),
    stay_type = case_when(
      total_nights == 0 ~ "No Stay",
      total_nights <= 3 ~ "Short Stay",
      total_nights <= 7 ~ "Medium Stay",
      TRUE ~ "Long Stay"
    ),
    revenue = adr * total_nights,
    arrival_season = case_when(
      arrival_date_month %in% c(12,1,2) ~ "Winter",
      arrival_date_month %in% c(3,4,5) ~ "Spring",
      arrival_date_month %in% c(6,7,8) ~ "Summer",
      TRUE ~ "Autumn"
    )
  )








# 5. EXPLORATORY DATA ANALYSIS (EDA)
summary(hotel)

# Numerical correlation
numeric_vars <- hotel %>%
  select(adr, total_nights, lead_time,
         total_guests, booking_changes)

#KPIs summary
kpi_summary <- hotel %>%
  summarise(
    Avg_Lead_Time = mean(lead_time),
    Avg_Guests = mean(total_guests),
    Cancellation_Rate = mean(is_cancelled == 1) * 100
  )

print(kpi_summary)
#Cancellation vs Lead Time
hotel$is_canceled <- as.factor(hotel$is_canceled)
cancel_leadtime <- hotel %>%
  group_by(is_canceled) %>%
  summarise(
    Avg_Lead_Time = mean(lead_time, na.rm = TRUE),
    Median_Lead_Time = median(lead_time, na.rm = TRUE),
    Count = n(),
    .groups = "drop"
  )

#Season Variables
Season <- hotel %>%
  mutate(
    Season = case_when(
      arrival_date_month %in% c("December","January","February") ~ "Winter",
      arrival_date_month %in% c("March","April","May") ~ "Spring",
      arrival_date_month %in% c("June","July","August") ~ "Summer",
      arrival_date_month %in% c("September","October","November") ~ "Autumn"
    )
  )



# 6. DATA VISUALIZATION

#Distribution of ADR
ggplot(hotel, aes(x = adr)) +
  
  geom_histogram(bins = 50, fill = "steelblue", color = "white") +
  labs(
    title = "Distribution of Average Daily Rate (ADR)",
    x = "ADR",
    y = "Frequency"
  ) +
  theme_minimal()




# Monthly Booking Trend
monthly_plot <- ggplot(monthly_trends,
                       aes(x = arrival_date_month,
                           y = bookings,
                           group = arrival_date_year)) +
  geom_line(aes(color = as.factor(arrival_date_year)), size = 1) +
  geom_point() +
  scale_x_continuous(breaks = 1:12, labels = month.abb) +
  labs(
    title = "Monthly Booking Trends by Year",
    x = "Month",
    y = "Number of Bookings",
    color = "Year"
  ) +
  theme_minimal()

print(monthly_plot)

# Cancellation by Market Segment
segment_plot <- ggplot(segment_summary,
                       aes(x = reorder(market_segment, bookings),
                           y = cancellation_rate)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Cancellation Rate by Market Segment",
    x = "Market Segment",
    y = "Cancellation Rate (%)"
  ) +
  theme_minimal()
print(segment_plot)

# Customer Type ADR

customer_plot <- ggplot(customer_summary,
                        aes(x = customer_type, y = avg_adr)) +
  geom_bar(stat = "identity", fill = "steelblue") +
 
  labs(
    title = "Average Daily Rate by Customer Type",
    x = "Customer Type",
    y = "ADR"
  ) +
  theme_minimal() +
  theme(legend.position = "none")

print(customer_plot)


# Correlation Heatmap
corrplot(
  cor_matrix,
  method = "color",
  type = "upper",
  col = viridis(100),
  tl.col = "black",
  addCoef.col = "black"
)


