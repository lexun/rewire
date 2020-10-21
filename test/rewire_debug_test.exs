defmodule RewireDebugTest do
  use ExUnit.Case
  import Rewire

  test "debug mode" do
    rewire Rewire.Hello, as: Hello, debug: true do
      actual =
        File.read!("fixtures/hello.debug")
        |> String.replace(~r/:R[0-9]+/, ":R")
        |> String.replace(~r/\.R[0-9]+/, ".R")
        |> String.replace(":\"::\"", ":::")

      expected =
        File.read!("fixtures/hello.debug.fixture")
        |> String.replace(":\"::\"", ":::")

      assert actual == expected
    end
  end
end
