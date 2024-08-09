# gleesend

[![Package Version](https://img.shields.io/hexpm/v/gleesend)](https://hex.pm/packages/gleesend)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/gleesend/)

```sh
gleam add gleesend@2
```

```gleam
import gleesend.{Resend}
import gleesend/emails.{create_email, to_response, to_request, with_html, BadRequestError}
import gleam/hackney
import gleam/result.{try}

pub fn main() {
  let client = Resend(api_key: "// Replace this with your resend api key")

  let request =
    create_email(
      client:,
      from: "from@example.com",
      to: ["to@example.com"],
      subject: ":)",
    )
    |> with_html("<p>Successful response</p>")
    |> to_request()

  use response <- try(
    request
    |> hackney.send
    |> result.replace_error(BadRequestError),
  )

  // Optional to_response function that parses the response body and status
  // and returns a result with types for you to handle in your app
  let response = to_response(response.body, response.status)
}
```

Further documentation can be found at <https://hexdocs.pm/gleesend>.

## Development

```sh
gleam test  # Run the tests
```
