<p>This is a file upload platform where users can upload, view, and delete files. The platform supports handling large files up to 1GB and only accepts JPEG or PNG file formats.</p>

Authentication: Used Devise for user sign-up, login, and logout.
Route is: http://127.0.0.1:3000/users/sign_in (after setting up the rails server)
<br>
Users can:
1. Upload Files with title, description, and attachment(jpg/png).
2. View Uploaded Files in dashboard.
3. Download File.
4. Delete Files they’ve uploaded.

For files download - Used rails_blob_path which is a Rails helper used to generate a download link for files managed by ActiveStorage(local db).

For Testing:
1. Log in or sign up.
2. Upload a file from the dashboard.
3. Download a single file using the "Download" button.