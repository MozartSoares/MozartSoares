name: Update README cards
on:
  schedule:
    - cron: "0 3 * * *" # Every day 3 am
  workflow_dispatch: # Manual trigger

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      # General stats
      - name: Generate stats card
        uses: readme-tools/github-readme-stats-action@v1
        with:
          card: stats
          options: username=${{ github.repository_owner }}&show_icons=true&theme=onedark&count_private=true
          path: profile/stats.svg
          token: ${{ secrets.GH_PAT }}

      # Top Languages
      - name: Generate languages card
        uses: readme-tools/github-readme-stats-action@v1
        with:
          card: top-langs
          options: username=${{ github.repository_owner }}&layout=compact&langs_count=7&theme=onedark&count_private=true
          path: profile/langs.svg
          token: ${{ secrets.GH_PAT }}

      - name: Commit cards
        run: |
          git config user.name "github-actions"
          git config user.email "github-actions@users.noreply.github.com"
          git add profile/*.svg
          git commit -m "Update README cards" || exit 0
          git push
