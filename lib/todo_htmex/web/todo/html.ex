defmodule TodoHtmex.Web.Todo.Html do
  require EEx
  require Logger

  @template_dir File.cwd!() <> "/lib/todo_htmex/web/templates/"

  EEx.function_from_file(:def, :root_html, @template_dir <> "root.html.eex", [
    :inner_content,
    :title
  ])

  EEx.function_from_file(:def, :home_html, @template_dir <> "todo/home.html.eex", [:todos])
  EEx.function_from_file(:def, :about_html, @template_dir <> "todo/about.html.eex")
  EEx.function_from_file(:def, :detail_html, @template_dir <> "todo/detail.html.eex", [:todo])
  EEx.function_from_file(:def, :search, @template_dir <> "todo/search.html.eex", [:todos])

  EEx.function_from_file(:def, :all_completed, @template_dir <> "todo/all_completed.html.eex", [
    :todos
  ])

  EEx.function_from_file(:def, :edit, @template_dir <> "todo/edit.html.eex", [:todo])
  EEx.function_from_file(:def, :flash, @template_dir <> "todo/flash.html.eex", [:kind, :message])
  EEx.function_from_file(:def, :error_html, @template_dir <> "todo/error.html.eex", [:kind])

  def index(todos, title) do
    todos
    |> home_html()
    |> root_html(title)
  end

  def about(title) do
    about_html()
    |> root_html(title)
  end

  def detail(todo, title) do
    todo
    |> detail_html()
    |> root_html(title)
  end

  def error(kind) do
    error_html(kind)
    |> root_html("Todoapp in Elixir & HTMX | Error #{kind}")
  end
end
