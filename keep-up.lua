require "lfs"

function findrepos(path)
  repos = {}
  for file in lfs.dir(path) do
    if file ~= "." and file ~= ".." then
      file = path .. "/" .. file
      if lfs.attributes(file .. "/.git") then
        print("\27[32mFound git repo at " .. file .. "\27[0m")
        table.insert(repos, file)
      end
    end
  end
  return repos
end

function updaterepo(path)
  print("\27[32mUpdating git repo at " .. path .. "\27[0m")

  local cwd = lfs.currentdir()
  lfs.chdir(path)

  if not lfs.attributes(".git/refs/upstream") then
    print("  No upstream, pulling")
    if os.execute("git pull") ~= 0 then
      print("  \27[31m`git pull` failed, please review log.\27[0m")
    end
  end
  lfs.chdir(cwd)
end

function updaterepos(path)
  repos = findrepos(path)
  for _, repo in ipairs(repos) do
    updaterepo(repo)
  end
end

updaterepos(arg[1])

