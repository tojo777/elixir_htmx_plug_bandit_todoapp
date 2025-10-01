defmodule TodoHtmex.Web.Todo.Controller do
  require Logger
  use Plug.Router

  alias TodoHtmex.Todo.Server, as: TodoServer
  alias TodoHtmex.Web.Todo.Html, as: TodoHtml
  alias TodoHtmex.Web.Todo.Item, as: TodoItem

  plug(:match)
  plug(Plug.Parsers, parsers: [:urlencoded])
  plug(:dispatch)

  @title "Todoapp in Elixir & HTMX"

  # index path (home)
  get "/" do
    TodoServer.all_todos()
    |> TodoHtml.index(@title <> " | Home")
    |> then(&send_resp(conn, 200, &1))
  end

  # about path
  get "/about" do
    (@title <> " | About")
    |> TodoHtml.about()
    |> then(&send_resp(conn, 200, &1))
  end

  # search
  get "/search" do
    qparams = conn.query_params

    Logger.debug("search - #{inspect(qparams)}")

    note = qparams["note"] |> Plug.HTML.html_escape()

    TodoServer.all_todos()
    |> TodoServer.search_todo(note)
    |> TodoHtml.search()
    |> then(&send_resp(conn, 200, &1))
  end

  # todo detail
  get "/:id/detail" do
    params = conn.params

    Logger.debug("detail - #{inspect(params)}")

    params["id"]
    |> String.to_integer()
    |> find_todo_by_id()
    |> TodoHtml.detail(@title <> " | Todo ##{params["id"]}")
    |> then(&send_resp(conn, 200, &1))
  end

  # edit
  get "/:id/edit" do
    params = conn.params

    Logger.debug("edit - #{inspect(params)}")

    params["id"]
    |> String.to_integer()
    |> find_todo_by_id()
    |> TodoHtml.edit()
    |> then(&send_resp(conn, 200, &1))
  end

  # show (cancel action)
  get "/:id/show" do
    params = conn.params

    Logger.debug("show - #{inspect(params)}")

    params["id"]
    |> String.to_integer()
    |> find_todo_by_id()
    |> TodoItem.item()
    |> then(&send_resp(conn, 200, &1))
  end

  # create
  post "/" do
    bparams = conn.body_params

    Logger.debug("create - #{inspect(bparams)}")

    note = bparams["note"] |> Plug.HTML.html_escape()
    # Logger.debug("date - #{inspect(DateTime.to_string(DateTime.utc_now()))}")
    # new_note = %{note: note, id: nil, dt: DateTime.to_string(DateTime.utc_now())}

    TodoServer.all_todos()
    |> TodoServer.create_todo(%{note: note, id: nil, dt: nil})

    conn
    |> put_resp_header("location", "/todos")
    |> send_resp(303, "")
  end

  # update
  patch "/:id" do
    params = conn.params
    bparams = conn.body_params

    Logger.debug("update - #{inspect(params)} - #{inspect(bparams)}")

    id = params["id"] |> String.to_integer()
    note = bparams["note"] |> Plug.HTML.html_escape()

    todo = %{find_todo_by_id(id) | note: note}

    TodoServer.all_todos() |> TodoServer.update_todo(todo)

    # we request the "fresh" data again from the GenServer and render it
    id
    |> find_todo_by_id()
    |> TodoItem.item()
    |> then(&send_resp(conn, 200, &1))
  end

  # delete
  delete "/:id" do
    params = conn.params

    Logger.debug("delete - #{inspect(params)}")

    id = params["id"] |> String.to_integer()

    TodoServer.all_todos() |> TodoServer.delete_todo(id)

    # conn |> send_resp(201, "")
    send_resp(put_resp_header(conn, "hx-trigger", "succ-todo-del-evt"), 201, "")
  end

  # bulk delete
  put "/completed" do
    bparams = conn.body_params

    Logger.debug("bulk delete - #{inspect(bparams)}")

    bparams["ids"]
    |> Enum.map(fn id ->
      id = String.to_integer(id)
      TodoServer.all_todos() |> TodoServer.delete_todo(id)
    end)

    if length(TodoServer.all_todos()) <= 1 do
      TodoServer.all_todos()
      |> TodoHtml.all_completed()
      |> then(&send_resp(put_resp_header(conn, "hx-trigger", "succ-bulk-del-evt"), 200, &1))
    else
      TodoServer.all_todos()
      |> TodoHtml.search()
      |> then(&send_resp(put_resp_header(conn, "hx-trigger", "succ-bulk-del-evt"), 200, &1))
    end
  end

  get "/flash" do
    [msg | []] = get_req_header(conn, "content-msg")
    Logger.debug("msg - #{inspect(msg)}")

    TodoHtml.flash(msg)
    |> then(&send_resp(conn, 200, &1))
  end

  match _ do
    send_resp(conn, 404, TodoHtml.error(404))
  end

  defp find_todo_by_id(id) do
    TodoServer.all_todos()
    |> TodoServer.get_todo(id)
  end
end
