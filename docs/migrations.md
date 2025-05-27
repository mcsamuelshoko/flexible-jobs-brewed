Absolutely! Here's a complete set of **Phoenix Ecto schemas and migration commands** for the original core tables you mentioned:

---

## ✅ 1. `Users`

### 🧱 Migration Command

```bash
mix phx.gen.schema Accounts.User users \
  email:string:unique \
  hashed_password:string \
  role:string \
  full_name:string \
  company_id:references:companies
```

### 🧬 Schema (`user.ex`)

```elixir
@primary_key {:id, :binary_id, autogenerate: true}
@foreign_key_type :binary_id
schema "users" do
  field :email, :string
  field :hashed_password, :string
  field :role, :string
  field :full_name, :string

  belongs_to :company, MyApp.Companies.Company

  timestamps()
end
```

---

## ✅ 2. `Jobs`

```bash
mix phx.gen.schema Jobs.Job jobs \
  employer_id:references:users \
  title:string \
  description:text \
  location:string \
  type:string \
  salary_range:string \
  status:string
```

```elixir
schema "jobs" do
  field :title, :string
  field :description, :string
  field :location, :string
  field :type, :string
  field :salary_range, :string
  field :status, :string

  belongs_to :employer, MyApp.Accounts.User

  timestamps()
end
```

---

## ✅ 3. `Messages`

```bash
mix phx.gen.schema Messaging.Message messages \
  sender_id:references:users \
  receiver_id:references:users \
  job_id:references:jobs \
  content:text \
  read:boolean
```

```elixir
schema "messages" do
  field :content, :string
  field :read, :boolean, default: false

  belongs_to :sender, MyApp.Accounts.User
  belongs_to :receiver, MyApp.Accounts.User
  belongs_to :job, MyApp.Jobs.Job

  timestamps()
end
```

---

## ✅ 4. `Media`

```bash
mix phx.gen.schema Media.Asset media \
  user_id:references:users \
  job_id:references:jobs \
  url:string \
  type:string
```

```elixir
schema "media" do
  field :url, :string
  field :type, :string

  belongs_to :user, MyApp.Accounts.User
  belongs_to :job, MyApp.Jobs.Job

  timestamps()
end
```

---

## ✅ 5. `Resume`

```bash
mix phx.gen.schema Resume.Resume resumes \
  user_id:references:users \
  file_url:string \
  summary:text \
  skills:map
```

```elixir
schema "resumes" do
  field :file_url, :string
  field :summary, :string
  field :skills, :map

  belongs_to :user, MyApp.Accounts.User

  timestamps()
end
```

---

## ✅ 6. `Settings`

```bash
mix phx.gen.schema Accounts.Setting settings \
  user_id:references:users \
  preferences:map
```

```elixir
schema "settings" do
  field :preferences, :map

  belongs_to :user, MyApp.Accounts.User

  timestamps()
end
```

---

## ✅ 7. `Authentication Tokens`

You can also generate manually:

```elixir
defmodule MyApp.Accounts.Token do
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "tokens" do
    field :token, :string
    field :context, :string
    field :expires_at, :utc_datetime

    belongs_to :user, MyApp.Accounts.User, type: :binary_id

    timestamps()
  end
end
```

Create a migration for it manually or with `mix ecto.gen.migration`.

---

## 🔄 Next Steps

1. **Run all the commands** above.
2. **Check/edit migrations** if needed.
3. Run:

```bash
mix ecto.create
mix ecto.migrate
```

Would you like me to give you **API controllers** or **contexts** next (e.g. `Accounts`, `Jobs`)? Or help set up **role-based dashboards** (e.g. `/dashboard/employer` vs `/dashboard/seeker`)?



----



To generate Ecto schemas and migrations, you'll need to be logged in to use **ChatGPT canvas**, which supports this kind of collaborative editing.

But no worries — I’ll give you **copy-paste-ready Ecto code** right here to get you started directly in your Phoenix app.

---

## 🛠️ Ecto Schema + Migration Examples

### 1. **Reviews**

Run this command to generate a migration and schema:

```bash
mix phx.gen.schema Reviews.Review reviews \
  user_id:references:users \
  job_id:references:jobs \
  company_id:references:companies \
  rating:integer \
  title:string \
  body:text \
  anonymous:boolean \
  approved:boolean
```

Then in `review.ex`:

```elixir
schema "reviews" do
  field :rating, :integer
  field :title, :string
  field :body, :string
  field :anonymous, :boolean, default: false
  field :approved, :boolean, default: false

  belongs_to :user, MyApp.Accounts.User
  belongs_to :job, MyApp.Jobs.Job
  belongs_to :company, MyApp.Companies.Company

  timestamps()
end
```

---

### 2. **Payments**

```bash
mix phx.gen.schema Billing.Payment payments \
  user_id:references:users \
  amount:integer \
  currency:string \
  status:string \
  provider:string \
  provider_ref:string \
  type:string
```

---

### 3. **Subscriptions**

```bash
mix phx.gen.schema Billing.Subscription subscriptions \
  user_id:references:users \
  plan_id:references:subscription_plans \
  status:string \
  started_at:utc_datetime \
  ends_at:utc_datetime \
  provider_ref:string
```

---

### 4. **Subscription Plans**

```bash
mix phx.gen.schema Billing.SubscriptionPlan subscription_plans \
  name:string \
  price_cents:integer \
  currency:string \
  job_limit:integer \
  highlighted:boolean
```

---

### 🧠 Pro Tips for Schema Setup

* Use `:binary_id` for UUID support:

  * In `config/config.exs`:

    ```elixir
    config :my_app, MyApp.Repo,
      migration_primary_key: [type: :binary_id],
      migration_foreign_key: [type: :binary_id]
    ```
  * In each schema:

    ```elixir
    @primary_key {:id, :binary_id, autogenerate: true}
    @foreign_key_type :binary_id
    ```

* Use `timestamps()` in all schemas.

* Run `mix ecto.migrate` after editing the migration files if needed.

---

Would you like the **company**, **jobs**, or **users** schema scaffolded next? I can batch those out too.
