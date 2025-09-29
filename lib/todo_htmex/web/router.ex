defmodule TodoHtmex.Web.Router do
  require Logger
  use Plug.Router
  use Plug.ErrorHandler

  alias TodoHtmex.Web.Todo.Html, as: TodoHtml

  plug(Plug.Logger, log: :debug)
  plug(Plug.Static, at: "/static/", from: {:todo_htmex, "priv/static/"})
  plug(:match)
  plug(:dispatch)

  forward("/todos", to: TodoHtmex.Web.Todo.Controller)

  get "/health" do
    send_resp(conn, 200, "ok")
  end

  # Redirect "/" to "/todos"
  get "/" do
    conn
    |> put_resp_header("location", "/todos")
    |> send_resp(301, "")
  end

  match _ do
    send_resp(conn, 404, TodoHtml.error(404))
  end

  @impl Plug.ErrorHandler
  def handle_errors(conn, %{kind: kind, reason: reason, stack: stack}) do
    Logger.error("kind: #{inspect(kind)}, reason: #{inspect(reason)}, stack: #{inspect(stack)}")

    # conn = put_resp_header(conn, "hx-retarget", "body")
    send_resp(conn, conn.status, TodoHtml.error(conn.status))
  end
end
