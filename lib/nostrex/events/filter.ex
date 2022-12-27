defmodule Nostrex.Events.Filter do
  use Ecto.Schema
  import Ecto.Changeset

  schema "filters" do
    field :ids, {:array, :string}
    field :authors, {:array, :string}
    field :kinds, {:array, :integer}
    field :"#e", {:array, :string}
    field :"#p", {:array, :string}
    field :since, :integer
    field :until, :integer
    field :limit, :integer
  end
  # defstruct [:ids, :authors, :kinds, :e, :p, :since, :until, :limit]

  @optional_attrs ~w(ids authors kinds #e #p since until limit)a

  def changeset(filter, attrs) do
    filter
    |> cast(attrs, @optional_attrs)
    |> validate_one_field_not_empty()
  end

  defp validate_one_field_not_empty(changeset) do
    changes = changeset.changes
    if Enum.empty?(changes) or Enum.any?(changes, fn {_k,v} -> is_empty?(v) end) do
      add_error(changeset, :ids, "Filter must have one field not empty")
    else
      changeset
    end
  end

  defp is_empty?([]) do
    true
  end

  defp is_empty?(%{}) do
    true
  end

  defp is_empty?("") do
    true
  end

  defp is_empty?(nil) do
    true
  end

  defp is_empty?(_) do
    false
  end


end