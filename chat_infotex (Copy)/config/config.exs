import Config

config :kvs,
  dba: :kvs_ets,
  schema: [:kvs, :kvs_feed, :kvs_stream, :topic]


config :n2o,
  port: 8001,
  upload: "/tmp",
  routes: [
    {:index, ChatInfotex.RoomSelector},
    {"/app/rooms.htm", ChatInfotex.RoomSelector},
    {"/app/chat.htm", ChatInfotex.Chat}
  ],
  mq: :n2o_syn,
  proto: [:n2o_ftp, :n2o_nitro],
  ttl: 3600,
  session: :n2o_session,
  pickler: :n2o_pickle,
  formatter: :n2o_html,
  tables: [:n2o_async, :n2o_route, :n2o_session, :n2o_pickler],
  log_level: :info
