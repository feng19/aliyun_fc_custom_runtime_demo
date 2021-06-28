defmodule ExAliyunFc.Endpoint do
  @moduledoc false
  use Plug.Router
  require Logger

  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  post "/initialize" do
    Logger.info("initialize req_headers: " <> inspect(conn.req_headers))
    {:ok, body, conn} = read_body(conn)
    Logger.info("initialize body: " <> body)

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "initialize")
  end

  post "/invoke" do
    Logger.info("invoke req_headers: " <> inspect(conn.req_headers))
    {:ok, body, conn} = read_body(conn)
    Logger.info("invoke body: " <> body)

    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "invoke")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
