{{ diff(
    ref("user_old"),
    "unique_key",
    ref("user_new"),
    "unique_key",
    [
        "name"
    ]
) }}


