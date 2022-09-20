# 公式ドキュメント: https://railsguides.jp/i18n.html
# config/locales/**/*.rb or *.ymlのファイルを読み込むよう設定
I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

# デフォルトの言語は日本語
I18n.default_locale = :ja
