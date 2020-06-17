# Actions

## release

1. Find the last tag without "unstable"
2. Get log of commits
3. Bump to next major.minor.patch
4. Generate changelog
5. Tag and release

## canary

1. Find last tag
2. Create new version

  ```   
   If tag == unstable
       increment prerelease version: major.minor.patch.unstable.(prerelease+1)
   Else
       Bump patch, add prerelease token: major.minor.(patch+1).unstable.0
  ```

3. Tag