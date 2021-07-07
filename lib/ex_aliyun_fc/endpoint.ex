defmodule ExAliyunFc.Endpoint do
  @moduledoc false
  use Plug.Router
  require Logger

  plug Plug.Logger
  plug :match
  plug :dispatch

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

  match "/:version/proxy/:service_version/:function_name/*path" do
    Logger.info("invoke req_headers: " <> inspect(conn.req_headers))
    {:ok, body, conn} = read_body(conn)
    Logger.info("invoke body: " <> body)
    encoded_filename = URI.encode_www_form("text.csv")
    contents = "a,b/r/n1,2/r/n3,4/r/n"

    conn
    |> put_resp_content_type("text/csv", "utf-8")
    |> put_resp_header("content-disposition", ~s[attachment; filename="#{encoded_filename}"])
    |> send_resp(200, contents)
  end

  match _ do
    path = conn.request_path
    Logger.info("call path: #{path} req_headers: " <> inspect(conn.req_headers))
    {:ok, body, conn} = read_body(conn)
    Logger.info("call path: #{path} body: " <> body)
    send_resp(conn, 404, "oops")
  end
end
