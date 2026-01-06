{
    "targets": [
        {
            "target_name": "NativeExtension",
            "sources": ["NativeExtension.cc"],
            "link_settings": {
                "conditions": [
                    [
                        'OS=="mac"', {
                            "sources": [
                                "tahoe_corners.mm"
                            ],
                        }
                    ]
                ]
            }
        }
    ],
}
