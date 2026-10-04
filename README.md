# NCH Appointment System

A doctor appointment system for National Hospital Chattogram. Staff log in, book patients with a doctor, and download the daily patient list as a PDF. Built with PHP, MySQLi, MySQL and Bootstrap (AdminLTE).

## Files

| File | What it does |
|---|---|
| index.php | Login page. `?logout=1` ends the session |
| auth.php | Checks the session and sends visitors to the login page if they are not signed in |
| mydb.php | MySQLi database connection |
| navbar.php | Shared top bar, sidebar, page header and footer |
| dashboard.php | Shows the total appointment count |
| all_appointment.php | Shows confirmed, cancelled and per-date counts |
| appointment_list.php | Lists doctors with appointment totals, shows each doctor's patients, cancels appointments, downloads the PDF |
| make_appointment.php | Creates an appointment |
| doctor_schedule.php | Sets each doctor's working days and times |
| database.sql | Full database: tables and doctor data |
| migration.sql | Upgrades an older database to the current structure |
| sample_schedules.sql | Optional sample schedules for all doctors |

## Database structure

Database name: `nch_appointment`

### users

Staff accounts that can log in.

| Column | Data saved |
|---|---|
| id | User ID |
| name | Staff name |
| email | Login email (unique) |
| password | Hashed password |

### doctors

| Column | Data saved |
|---|---|
| id | Doctor ID |
| name | Doctor name |
| bmdc | BMDC registration number (unique) |
| details | Designation and specialty |
| status | 1 = active, 0 = hidden from booking |

### doctor_schedules

One row for each doctor, day and session.

| Column | Data saved |
|---|---|
| id | Schedule ID |
| doctor_id | Doctor this schedule belongs to |
| day_of_week | 0 = Sunday to 6 = Saturday |
| session_name | Morning, Afternoon or Evening |
| start_time, end_time | Working hours |
| slot_minutes | Length of one appointment slot |
| is_active | 1 = on, 0 = off |

### appointments

| Column | Data saved |
|---|---|
| id | Appointment ID |
| doctor_id | Doctor booked |
| serial_no | Serial number for that doctor on that day |
| patient_name, patient_mobile | Patient contact details |
| patient_gender, patient_age | Patient details |
| appointment_date | Date of the appointment |
| time_slot | Time given to the patient |
| status | confirmed or cancelled |
| created_at, created_by | When it was booked and which user booked it |
| cancelled_at, cancelled_by | When it was cancelled and which user cancelled it |

## How data is saved

- **Login:** the email is looked up in `users` and the password is checked against the saved hash. On success, the user ID and name are stored in the PHP session.
- **Doctor schedule:** the Doctor Schedule page adds rows to `doctor_schedules`. Turning a row off or on changes `is_active`. A doctor can be deactivated through `doctors.status`.
- **Booking:** when you pick a doctor, the page reads today's rows in `doctor_schedules` and shows availability. On Create, the system takes the next free slot, sets the serial number to the highest one for that doctor and date plus 1, and inserts a row in `appointments` with status `confirmed`.
- **Double booking:** a unique key on doctor, date and slot stops two confirmed appointments from sharing a slot.
- **Cancel:** the row is not deleted. Its status becomes `cancelled`, and the time and user are saved in `cancelled_at` and `cancelled_by`. The slot becomes free again.
- **PDF:** nothing is saved. The PDF is built in the browser from the confirmed appointments of one doctor on one date.

## Setup

1. Create a database named `nch_appointment` and import `database.sql`.
2. Set your MySQL host, user and password in `mydb.php`.
3. Put the folder in your web root and open it in the browser.
4. Log in with `receptionist@gmail.com` and `1234`, then change the password.
