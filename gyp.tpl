# -*- mode: Python; tab-width: 2; indent-tabs-mode: nil -*-
# vim: set filetype=python tabstop=2 shiftwidth=2 softtabstop=2 expandtab:

{
  'target_defaults': {
    'conditions': [
      ['OS=="linux"', {
        'defines': [
          '__unix__',
          '_LINUX'
        ],
        'cflags': [
          '-Wall'
        ]
      }],
      ['OS=="win"', {
        'defines': [
          'WIN32'
        ],
        'msvs_configuration_attributes': {
          'CharacterSet': '1'
        },
        'msvs_settings': {
          'VCCLCompilerTool': {
            'WarningLevel': '4',
            'Detect64BitPortabilityProblems': 'true'
          }
        }
      }],
      ['OS=="mac"', {
        'defines': [
          '__unix__',
          '_MACOS'
        ],
        'cflags': [
          '-Wall'
        ]
      }]
    ],

    'configurations': {
      'Debug': {
        'defines': [
          '_DEBUG'
        ],
        'conditions': [
          ['OS=="linux" or OS=="freebsd" or OS=="openbsd"', {
            'cflags': [
              '-g'
            ]
          }],
          ['OS=="win"', {
            'msvs_settings': {
              'VCCLCompilerTool': {
                'Optimization': '0',
                'MinimalRebuild': 'true',
                'BasicRuntimeChecks': '3',
                'DebugInformationFormat': '4',

                'conditions': [
                  ['library=="shared_library"', {
                    'RuntimeLibrary': '3'  # /MDd
                  }, {
                    'RuntimeLibrary': '1'  # /MTd
                  }]
                ]
              },
              'VCLinkerTool': {
                'GenerateDebugInformation': 'true',
                'LinkIncremental': '2'
              }
            }
          }],
          ['OS=="mac"', {
            'xcode_settings': {
              'GCC_GENERATE_DEBUGGING_SYMBOLS': 'YES'
            }
          }]
        ]
      },

      'Release': {
        'conditions': [
          ['OS=="linux" or OS=="freebsd" or OS=="openbsd"', {
            'cflags': [
              '-O3'
            ]
          }],
          ['OS=="win"', {
            'msvs_settings': {
              'VCCLCompilerTool': {
                'Optimization': '2',

                'conditions': [
                  ['library=="shared_library"', {
                    'RuntimeLibrary': '2'  # /MD
                  }, {
                    'RuntimeLibrary': '0'  # /MT
                  }]
                ]
              }
            }
          }],
          ['OS=="mac"', {
            'xcode_settings': {
              'GCC_GENERATE_DEBUGGING_SYMBOLS': 'NO',
              'GCC_OPTIMIZATION_LEVEL': '3',

              # -fstrict-aliasing. Mainline gcc enables
              # this at -O2 and above, but Apple gcc does
              # not unless it is specified explicitly.
              'GCC_STRICT_ALIASING': 'YES'
            }
          }]
        ]
      }
    }
  },

  'targets': [
    {
      'target_name': '(>>>FILE_SANS<<<)',
      'type': '(>>>POINT<<<)',  # executable, <(library)
      # 'dependencies': [
      # ],
      # 'defines': [
      # ],
      # 'include_dirs': [
      # ],
      'sources': [
      ],
      # 'conditions': [
      #   ['OS=="linux" or OS=="freebsd" or OS=="openbsd"', {
      #     'ldflags': [
      #       '-'
      #     ]
      #   }],
      #   ['OS=="win"', {
      #     'msvs_settings': {
      #       'VCLinkerTool': {
      #         'AdditionalDependencies': '',
      #         'conditions': [
      #           ['library=="static_library"', {
      #             'AdditionalLibraryDirectories': '$(OutDir)\\lib'
      #           }]
      #         ]
      #       }
      #     }
      #   }],
      #   ['OS=="mac"', {
      #     'link_settings': {
      #       'libraries': [
      #         ''
      #       ]
      #     }
      #   }]
      # ]
    }
  ]
}
