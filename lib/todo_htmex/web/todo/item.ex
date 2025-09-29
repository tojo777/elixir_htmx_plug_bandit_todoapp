defmodule TodoHtmex.Web.Todo.Item do
  require EEx

  @template_dir File.cwd!() <> "/lib/todo_htmex/web/templates/"

  EEx.function_from_file(:def, :item, @template_dir <> "todo/item.html.eex", [:todo])
end
