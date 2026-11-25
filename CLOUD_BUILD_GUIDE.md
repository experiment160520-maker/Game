# Build Wild Frontier APK using GitHub (phone-only workflow)

This project includes a GitHub Actions workflow at `.github/workflows/android.yml`.
It attempts to compile a debug APK on a GitHub-hosted cloud runner.

## Phone-only steps

1. Create/sign in to a free account at https://github.com/.
2. In GitHub, create a new repository named `wild-frontier` (Public or Private).
3. On the repository page choose **Add file > Upload files**.
4. Upload the *contents* of this ZIP after extracting it on your phone. Make sure the `.github` folder is included. If your file manager hides dot-folders, use GitHub's web upload carefully or a ZIP upload workflow that preserves hidden files.
5. Commit the uploaded files.
6. Open the repository's **Actions** tab, choose **Build Wild Frontier Android APK**, then **Run workflow**.
7. Wait for the run to finish. Open the completed run and find **Artifacts** near the bottom.
8. Download `Wild-Frontier-APK`, extract that downloaded ZIP, then tap `WildFrontier.apk` to install.

## Notes
- This is an automated, best-effort starter workflow. GitHub Actions build minutes and account limits apply.
- The workflow creates an unsigned/debug APK suitable for testing; it is not a Play Store release build.
- If the workflow fails, open the failed run, copy the error text, and share it so the build configuration can be corrected.
- The app package identifier is currently `com.example.wildfrontier`; change it before public release.
