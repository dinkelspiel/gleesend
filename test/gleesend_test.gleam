import gleesend
import gleesend/emails.{create_email, send_email, with_html}
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn gleesend_test() {
  let client =
    resend.Resend(api_key: "// Replace this with your resend api key")

  create_email(
    client:,
    from: "from@example.com",
    to: ["to@example.com"],
    subject: ":)",
  )
  |> with_html("<p>Successful response</p>")
  |> send_email()
}
