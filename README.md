JeFit-Scraper
=============

Scrapes JeFit account for workouts and puts them into sqlite database

## Usage

Edit end of scraper.rb for desired timeframe

`scraper.get_data(start_month=1, end_month=12, year)`

`ruby scraper.rb username password`

## Output

File: workout.sqlite3

Command Line:
```
Log created: 2013-06-15

        Dumbbell Bench Press
                Set 1, Reps: 12, Lbs: 40
                Set 2, Reps: 12, Lbs: 45
                Set 3, Reps: 8, Lbs: 50

        Dumbbell Shoulder Press
                Set 1, Reps: 8, Lbs: 30
                Set 2, Reps: 6, Lbs: 35
                Set 3, Reps: 5, Lbs: 40

        Dumbbell Incline Bench Press
                Set 1, Reps: 8, Lbs: 40
                Set 2, Reps: 8, Lbs: 45
                Set 3, Reps: 4, Lbs: 50

        Dumbbell Arnold Press
                Set 1, Reps: 8, Lbs: 25
                Set 2, Reps: 5, Lbs: 30
                Set 3, Reps: 6, Lbs: 30

Log created: 2013-06-19

        Alternate Seated Dumbbell Curl
                Set 1, Reps: 12, Lbs: 20
                Set 2, Reps: 10, Lbs: 25
                Set 3, Reps: 7, Lbs: 30

        Bent Over Two Dumbbell Row
                Set 1, Reps: 12, Lbs: 20
                Set 2, Reps: 8, Lbs: 25
                Set 3, Reps: 8, Lbs: 30

        Alternate Incline Dumbbell Curl
                Set 1, Reps: 8, Lbs: 20
                Set 2, Reps: 8, Lbs: 25
                Set 3, Reps: 7, Lbs: 30

        Palms In Bent Over Dumbbell Row
                Set 1, Reps: 12, Lbs: 25
                Set 2, Reps: 10, Lbs: 30
                Set 3, Reps: 8, Lbs: 35

        Alternate Seated Hammer Curl
                Set 1, Reps: 8, Lbs: 25
                Set 2, Reps: 8, Lbs: 30
                Set 3, Reps: 8, Lbs: 25
```



