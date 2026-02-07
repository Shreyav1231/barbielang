export const toolbox = {
  'kind': 'categoryToolbox',
  'contents': [
    {
      'kind': 'category',
      'name': 'Logic',
      'categorystyle': 'logic_category',
      'contents': [
        {
          'kind': 'block',
          'type': 'controls_if'
        },
        {
          'kind': 'block',
          'type': 'logic_compare'
        },
        {
          'kind': 'block',
          'type': 'logic_boolean'
        },
        {
          'kind': 'block',
          'type': 'logic_null'
        }
      ]
    },
    {
      'kind': 'category',
      'name': 'Loops',
      'categorystyle': 'loop_category',
      'contents': [
        {
          'kind': 'block',
          'type': 'controls_whileUntil'
        },
        {
          'kind': 'block',
          'type': 'controls_repeat_ext'
        },
        {
          'kind': 'block',
          'type': 'controls_flow_statements'
        }
      ]
    },
    {
      'kind': 'category',
      'name': 'Math',
      'categorystyle': 'math_category',
      'contents': [
        {
          'kind': 'block',
          'type': 'math_number'
        },
        {
          'kind': 'block',
          'type': 'math_arithmetic'
        }
      ]
    },
    {
      'kind': 'category',
      'name': 'Text',
      'categorystyle': 'text_category',
      'contents': [
        {
          'kind': 'block',
          'type': 'text'
        },
        {
          'kind': 'block',
          'type': 'text_print'
        }
      ]
    },
    {
      'kind': 'category',
      'name': 'Variables',
      'categorystyle': 'variable_category',
      'contents': [
        {
          'kind': 'block',
          'type': 'variables_set'
        },
        {
          'kind': 'block',
          'type': 'variables_get'
        }
      ]
    }
  ]
};