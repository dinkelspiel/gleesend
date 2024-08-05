import gleam/dynamic
import gleam/hackney
import gleam/http.{Post}
import gleam/http/request
import gleam/json
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result.{try}
import gleesend.{type Resend}

pub type ResendEmail {
  ResendEmail(
    client: Resend,
    from: String,
    to: List(String),
    subject: String,
    bcc: Option(List(String)),
    cc: Option(List(String)),
    reply_to: Option(List(String)),
    html: Option(String),
    text: Option(String),
  )
}

pub fn with_bcc(resend: ResendEmail, bcc: List(String)) {
  ResendEmail(..resend, bcc: Some(bcc))
}

pub fn with_cc(resend: ResendEmail, cc: List(String)) {
  ResendEmail(..resend, cc: Some(cc))
}

pub fn with_reply_to(resend: ResendEmail, reply_to: List(String)) {
  ResendEmail(..resend, reply_to: Some(reply_to))
}

pub fn with_html(resend: ResendEmail, html: String) {
  ResendEmail(..resend, html: Some(html))
}

pub fn with_text(resend: ResendEmail, text: String) {
  ResendEmail(..resend, text: Some(text))
}

pub fn create_email(
  client client: Resend,
  from from: String,
  to to: List(String),
  subject subject: String,
) {
  ResendEmail(
    client:,
    from:,
    to:,
    subject:,
    bcc: None,
    cc: None,
    reply_to: None,
    html: None,
    text: None,
  )
}

pub type SendEmailError {
  RequestError
  BadRequestError
  ParseResponseBodyError
}

pub type SuccessResponse {
  SuccessResponse(id: String)
}

pub fn send_email(email: ResendEmail) {
  let assert Ok(request) = request.to("https://api.resend.com/emails")

  let body =
    json.object(
      list.concat([
        [
          #("from", json.string(email.from)),
          #("to", json.array(email.to, fn(a) { json.string(a) })),
          #("subject", json.string(email.string)),
        ],
        case email.bcc {
          Some(bcc) -> [#("bcc", json.array(bcc, fn(a) { json.string(a) }))]
          None -> []
        },
        case email.cc {
          Some(cc) -> [#("cc", json.array(cc, fn(a) { json.string(a) }))]
          None -> []
        },
        case email.reply_to {
          Some(reply_to) -> [
            #("reply_to", json.array(reply_to, fn(a) { json.string(a) })),
          ]
          None -> []
        },
        case email.html {
          Some(html) -> [#("html", json.string(html))]
          None -> []
        },
        case email.text {
          Some(text) -> [#("text", json.string(text))]
          None -> []
        },
      ]),
    )

  use response <- try(
    request
    |> request.prepend_header("accept", "application/vnd.hmrc.1.0+json")
    |> request.prepend_header("Content-Type", "application/json")
    |> request.prepend_header(
      "Authorization",
      "Bearer " <> email.client.api_key,
    )
    |> request.set_method(Post)
    |> request.set_body(
      body
      |> json.to_string,
    )
    |> hackney.send
    |> result.replace_error(RequestError),
  )

  let body_decoder =
    dynamic.decode1(SuccessResponse, dynamic.field("id", dynamic.string))

  case response.status {
    200 ->
      case json.decode(response.body, body_decoder) {
        Ok(body) -> Ok(body)
        Error(_) -> Error(ParseResponseBodyError)
      }
    _ -> Error(BadRequestError)
  }
}
