# Initialize git workspace.
```
cd catkin_ws
git init
git config --global user.email "kishoreiey@gmail.com"
git config --global user.name "Kishore Varma"
git remote add origin https://github.com/kishoreiey/Udacity-WhereAmI.git
```

# Clone remote project
```
git pull origin master
```

# Commit changes to master. Not recommended
```
git push --set-upstream origin master
```

# Reset git.
```
git reset
```

# To clone an old repo and create a new one.
git clone --bare https://github.com/exampleuser/old-repository.git
cd old-repository.git
# Create new Repo on GitHub and push to it.
git push --mirror https://github.com/exampleuser/new-repository.git
cd ..
rm -rf old-repository.git
