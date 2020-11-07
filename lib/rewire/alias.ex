defmodule Rewire.Alias do
  @moduledoc false

  def rewire_alias(
        opts = %{
          module_shorthand: module_shorthand,
          new_module_ast: new_module_ast
        }
      ) do
    quote do
      # First, we generate the rewired module.
      unquote(Rewire.Module.rewire_module(opts))

      # Then, we add an alias for the newly generated module using the name of the original module.
      unquote(
        {:alias, [context: Elixir],
         [
           {:__aliases__, [alias: false], new_module_ast},
           [
             as: {:__aliases__, [alias: false], [module_shorthand]}
           ]
         ]}
      )
    end
  end
end
