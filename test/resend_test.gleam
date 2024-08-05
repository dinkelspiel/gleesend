import gleeunit
import gleeunit/should
import resend
import resend/emails.{create_email, send_email, with_html}

pub fn main() {
  gleeunit.main()
}

pub fn resend_test() {
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
