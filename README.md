# gleesend

[![Package Version](https://img.shields.io/hexpm/v/gleesend)](https://hex.pm/packages/gleesend)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/gleesend/)

```sh
gleam add gleesend@1
```

```gleam
import gleesend
import gleesend/emails.{create_email, send_email, with_html}

pub fn main() {
  let client =
    gleesend.Resend(api_key: "// Replace this with your resend api key")

  create_email(
    client:,
    from: "from@example.com",
    to: ["to@example.com"],
    subject: ":)",
  )
  |> with_html("<p>Email sent</p>")
  |> send_email()
}
```

Further documentation can be found at <https://hexdocs.pm/resend>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
