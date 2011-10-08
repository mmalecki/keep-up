require "lfs"

function updategitrepos(dir)
  for file in lfs.dir(dir) do
    if file ~= "." and file ~= ".." then
      file = dir .. "/" .. file
      if lfs.attributes(file .. "/.git") then
        print("\27[32mFound git repo at " .. file .. "\27[0m")

        local cwd = lfs.currentdir()
        lfs.chdir(file)

        if not lfs.attributes(".git/refs/upstream") then
          print("  No upstream, pulling")
          if os.execute("git pull") ~= 0 then
            print("  \27[31m`git pull` failed, please review log.\27[0m")
          end
        end

        lfs.chdir(cwd)
      end
    end
  end
end

updategitrepos(arg[1])

