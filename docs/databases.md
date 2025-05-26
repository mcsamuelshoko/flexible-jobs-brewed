# [Postgres]

---

#### Users

#### Authentication

#### Jobs

#### Messages

#### Media

#### Resume

#### Settings


-------

-------

Great! Here's a clean **PostgreSQL schema** tailored for an **Elixir Phoenix job board**, with thoughtfully designed tables, data types, and relationships.

Each table includes a primary key, common fields, and foreign keys where needed. I’ve assumed some logical extensions to your structure and added table descriptions.

---

## 🧩 Base Schema Overview

### 1. **Users**

Represents both job seekers and employers.

| Column            | Type             | Description                       |
| ----------------- | ---------------- | --------------------------------- |
| `id`              | `uuid` (PK)      | Primary key                       |
| `email`           | `string`         | Unique email                      |
| `hashed_password` | `string`         | Hashed password (auth use)        |
| `role`            | `string`         | `job_seeker`, `employer`, `admin` |
| `full_name`       | `string`         | User's full name                  |
| `company_id`      | `uuid` (FK)      | For employers (optional)          |
| `inserted_at`     | `naive_datetime` | Created timestamp                 |
| `updated_at`      | `naive_datetime` | Updated timestamp                 |

> Use `Ecto.UUID` in Phoenix and `binary_id` in migrations for `uuid`.

---

### 2. **Authentication (Sessions, Tokens)**

| Column        | Type             | Description                        |
| ------------- | ---------------- | ---------------------------------- |
| `id`          | `uuid` (PK)      | Primary key                        |
| `user_id`     | `uuid` (FK)      | Reference to `users`               |
| `token`       | `string`         | Session or refresh token           |
| `context`     | `string`         | e.g., `"session"`, `"reset_token"` |
| `expires_at`  | `utc_datetime`   | Token expiration                   |
| `inserted_at` | `naive_datetime` |                                    |

---

### 3. **Jobs**

| Column         | Type             | Description                    |
| -------------- | ---------------- | ------------------------------ |
| `id`           | `uuid` (PK)      | Primary key                    |
| `employer_id`  | `uuid` (FK)      | Refers to `users` (employer)   |
| `title`        | `string`         | Job title                      |
| `description`  | `text`           | Full job description           |
| `location`     | `string`         | City, remote, etc.             |
| `type`         | `string`         | `full_time`, `part_time`, etc. |
| `salary_range` | `string`         | Optional: e.g. “60k-80k”       |
| `status`       | `string`         | `open`, `closed`, `draft`      |
| `inserted_at`  | `naive_datetime` |                                |
| `updated_at`   | `naive_datetime` |                                |

---

### 4. **Messages**

For communication between job seekers and employers (e.g., after applying).

| Column        | Type             | Description                 |
| ------------- | ---------------- | --------------------------- |
| `id`          | `uuid` (PK)      |                             |
| `sender_id`   | `uuid` (FK)      | From `users`                |
| `receiver_id` | `uuid` (FK)      | To `users`                  |
| `job_id`      | `uuid` (FK)      | Optional: relevant to a job |
| `content`     | `text`           | Message body                |
| `read`        | `boolean`        | Message seen or not         |
| `inserted_at` | `naive_datetime` |                             |

---

### 5. **Media**

| Column        | Type             | Description                |
| ------------- | ---------------- | -------------------------- |
| `id`          | `uuid` (PK)      |                            |
| `user_id`     | `uuid` (FK)      | Owner                      |
| `job_id`      | `uuid` (FK)      | Optional: used in job post |
| `url`         | `string`         | Media file URL             |
| `type`        | `string`         | `image`, `pdf`, etc.       |
| `inserted_at` | `naive_datetime` |                            |

---

### 6. **Resumes**

| Column        | Type             | Description             |
| ------------- | ---------------- | ----------------------- |
| `id`          | `uuid` (PK)      |                         |
| `user_id`     | `uuid` (FK)      | Job seeker              |
| `file_url`    | `string`         | Link to uploaded resume |
| `summary`     | `text`           | Optional: short summary |
| `skills`      | `jsonb`          | List of skills          |
| `inserted_at` | `naive_datetime` |                         |

---

### 7. **Settings**

| Column        | Type             | Description                 |
| ------------- | ---------------- | --------------------------- |
| `id`          | `uuid` (PK)      |                             |
| `user_id`     | `uuid` (FK)      |                             |
| `preferences` | `jsonb`          | Notification, privacy, etc. |
| `inserted_at` | `naive_datetime` |                             |

---

## ✅ Bonus Tables You Might Want

### 8. **Applications**

| Column         | Type             | Description                 |
| -------------- | ---------------- | --------------------------- |
| `id`           | `uuid` (PK)      |                             |
| `user_id`      | `uuid` (FK)      | Job seeker                  |
| `job_id`       | `uuid` (FK)      | Job applied to              |
| `status`       | `string`         | `pending`, `accepted`, etc. |
| `cover_letter` | `text`           | Optional letter             |
| `inserted_at`  | `naive_datetime` |                             |

### 9. **Companies**

| Column        | Type             | Description   |
| ------------- | ---------------- | ------------- |
| `id`          | `uuid` (PK)      |               |
| `name`        | `string`         | Company name  |
| `description` | `text`           | About company |
| `website`     | `string`         |               |
| `logo_url`    | `string`         |               |
| `location`    | `string`         |               |
| `inserted_at` | `naive_datetime` |               |

---

## 🛠️ Phoenix/Ecto Tips

* Use `timestamps()` in each schema for `inserted_at` and `updated_at`.
* Define `@primary_key {:id, :binary_id, autogenerate: true}` in each schema if using UUIDs.
* Prefer `Ecto.UUID` and `:binary_id` in migrations for IDs.

---

Would you like this turned into Phoenix Ecto migration files or schema modules?


---

Perfect — adding **reviews**, **payments**, and **subscriptions** will complete the core feature set of your job board. Below are **additional tables** with structure and reasoning, designed for a scalable **Elixir Phoenix + Postgres** stack.

---

## 📝 **8. Reviews (Job Reviews)**

This allows **job seekers** to review jobs they've applied to or companies they've worked for.

| Column        | Type             | Description                       |
| ------------- | ---------------- | --------------------------------- |
| `id`          | `uuid` (PK)      |                                   |
| `user_id`     | `uuid` (FK)      | Job seeker who left the review    |
| `job_id`      | `uuid` (FK)      | Job being reviewed                |
| `company_id`  | `uuid` (FK)      | (Optional) Company being reviewed |
| `rating`      | `integer`        | 1–5 rating                        |
| `title`       | `string`         | Review headline                   |
| `body`        | `text`           | Detailed review                   |
| `anonymous`   | `boolean`        | Hide user's name                  |
| `approved`    | `boolean`        | Admin/mod approval for publishing |
| `inserted_at` | `naive_datetime` |                                   |

> Add an index on `(job_id, approved)` for efficient filtering.

---

## 💳 **9. Payments**

Tracks all transactions (e.g., employer purchases a job post, or a subscription).

| Column         | Type             | Description                             |
| -------------- | ---------------- | --------------------------------------- |
| `id`           | `uuid` (PK)      |                                         |
| `user_id`      | `uuid` (FK)      | Employer who paid                       |
| `amount`       | `integer`        | In cents (e.g., \$20.00 = 2000)         |
| `currency`     | `string`         | Usually `USD`, `EUR`, etc.              |
| `status`       | `string`         | `pending`, `paid`, `failed`, `refunded` |
| `provider`     | `string`         | `stripe`, `paypal`, etc.                |
| `provider_ref` | `string`         | External payment ID                     |
| `type`         | `string`         | `job_post`, `subscription`, etc.        |
| `inserted_at`  | `naive_datetime` |                                         |

---

## 🧾 **10. Subscriptions**

Subscription plans and users subscribed to them.

| Column         | Type             | Description                       |
| -------------- | ---------------- | --------------------------------- |
| `id`           | `uuid` (PK)      |                                   |
| `user_id`      | `uuid` (FK)      | Subscriber (employer)             |
| `plan_id`      | `uuid` (FK)      | References the plan below         |
| `status`       | `string`         | `active`, `cancelled`, `past_due` |
| `started_at`   | `utc_datetime`   |                                   |
| `ends_at`      | `utc_datetime`   |                                   |
| `provider_ref` | `string`         | e.g., Stripe subscription ID      |
| `inserted_at`  | `naive_datetime` |                                   |

---

## 📦 **11. Subscription Plans**

Predefined pricing tiers.

| Column        | Type             | Description                          |
| ------------- | ---------------- | ------------------------------------ |
| `id`          | `uuid` (PK)      |                                      |
| `name`        | `string`         | `Starter`, `Pro`, `Enterprise`, etc. |
| `price_cents` | `integer`        | Price per month (in cents)           |
| `currency`    | `string`         | `USD`, etc.                          |
| `job_limit`   | `integer`        | Max jobs per month                   |
| `highlighted` | `boolean`        | Featured plan in UI                  |
| `inserted_at` | `naive_datetime` |                                      |

---

## 🧩 Updated Schema Summary

Here's how these additions connect:

* **Users** can be **job seekers** or **employers**.
* **Employers** create **Jobs** and optionally belong to a **Company**.
* **Job seekers** submit **Applications**, send **Messages**, upload **Resumes**, and leave **Reviews**.
* **Employers** make **Payments** to post jobs or subscribe.
* **Subscriptions** link to **Subscription Plans**, with billing handled by Stripe/other.

---

Would you like Ecto migration or schema code for these tables? I can also scaffold example commands for generating these in Phoenix.
