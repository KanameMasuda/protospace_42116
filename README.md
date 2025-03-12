# ProtoSpace テーブル設計

## users テーブル

|Column                 | Type   | Options             |
| --------------------- | ------ | ------------------- |
| email                 | string | NOT NULL,ユニーク制約 |
| encrypted_password    | string | NOT NULL            |
| name                  | string | NOT NULL            |
| occupation            | text   | NOT NULL            |
| position              | text   | NOT NULL            |

### Association

- has_many :prototypes
- has_many :comments

## prototypes テーブル

|Column                 | Type       | Options             |
| --------------------- | ---------- | ------------------- |
| title                 | string     | NOT NULL            |
| catch_copy            | string     | NOT NULL            |
| concept               | string     | NOT NULL            |
| user                  | references | NOT NULL,外部キー    |

### Association

- belongs_to :user
- has_many :comments

## comments テーブル

|Column                 | Type       | Options             |
| --------------------- | ---------- | ------------------- |
| title                 | string     | NOT NULL            |
| catch_copy            | references | NOT NULL,外部キー    |
| user                  | references | NOT NULL,外部キー    |

### Association

- belongs_to :prototypes
- belongs_to :user

