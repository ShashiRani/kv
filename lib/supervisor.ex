defmodule KV.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  # def init(:ok) do
  #   children = [
  #     {KV.Registry, name: KV.Registry}
  #   ]

  #   Supervisor.init(children, strategy: :one_for_one)
  # end

  def init(:ok) do
    children = [
      {DynamicSupervisor, name: KV.BucketSupervisor, strategy: :one_for_one},
      {KV.Registry, name: KV.Registry}
    ]
    #using one_for_all strategy will kill and restarat when any of children process dies
    Supervisor.init(children, strategy: :one_for_all)

  end
end
