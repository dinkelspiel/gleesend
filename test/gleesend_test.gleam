import gleam/hackney
import gleam/io
import gleam/result.{try}
import gleesend
import gleesend/emails.{
  BadRequestError, ParseResponseBodyError, create_email, to_request, to_response,
  with_html,
}
import gleeunit

pub fn main() {
  gleeunit.main()
}

pub fn gleesend_test() {
  io.println("Uncomment code and change values if you want to run the tests")
  // let client =
  //   gleesend.Resend(api_key: "// Replace this with your resend api key")

  // let request =
  //   create_email(
  //     client:,
  //     from: "from@example.com",
  //     to: ["to@example.com"],
  //     subject: ":)",
  //   )
  //   |> with_html("<p>Successful response</p>")
  //   |> to_request()

  // use response <- try(
  //   request
  //   |> hackney.send
  //   |> result.replace_error(BadRequestError),
  // )

  // case to_response(response.body, response.status) {
  //   Ok(a) -> Ok(a)
  //   Error(err) ->
  //     case err {
  //       BadRequestError -> panic as "Non-200 status code in response"
  //       ParseResponseBodyError -> panic as "Problem parsing response body"
  //     }
  // }
}
