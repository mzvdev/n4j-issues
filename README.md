# Neo4j/graphql issue with @authorization() validate, error: String cannot represent a non string value

## Context

We found that when we delete the yarn lock file in our current project, we had that error.
Then we tried to isolate the problem in a separate project, we still had the same issue.

Run tests by executing following commands:

```
yarn install
./test.sh watch-test
```

Test should now fail with:

```
...snipped...
 FAIL  src/index.test.js [ src/index.test.js ]
[
  {
    stack: 'GraphQLError: Invalid argument: validate, error: String cannot represent a non string value.\n' +
      '    at createGraphQLError (/n4j-issue/node_modules/@neo4j/graphql/src/schema/validation/custom-rules/utils/document-validation-error.ts:83:12)\n' +
      '    at mapCustomRuleError (/n4j-issue/node_modules/@neo4j/graphql/src/schema/validation/utils/map-error.ts:61:34)\n' +
      '    at mapError (/n4j-issue/node_modules/@neo4j/graphql/src/schema/validation/utils/map-error.ts:29:16)\n' +
      '    at SDLValidationContext._onError (/n4j-issue/node_modules/@neo4j/graphql/src/schema/validation/validate-sdl.ts:34:37)\n' +
      '    at SDLValidationContext.reportError (/n4j-issue/node_modules/graphql/validation/ValidationContext.js:36:10)\n' +
      '    at Object.Directive (/n4j-issue/node_modules/@neo4j/graphql/src/schema/validation/custom-rules/directive-argument-of-correct-type.ts:100:33)\n' +
      '    at Object.enter (/n4j-issue/node_modules/graphql/language/visitor.js:301:32)\n' +
      '    at visit (/n4j-issue/node_modules/graphql/language/visitor.js:197:21)\n' +
      '    at validateSDL (/n4j-issue/node_modules/@neo4j/graphql/src/schema/validation/validate-sdl.ts:38:10)\n' +
      '    at validateUserDefinition (/n4j-issue/node_modules/@neo4j/graphql/src/schema/validation/schema-validation.ts:106:31)',
    message: 'Invalid argument: validate, error: String cannot represent a non string value.',
    name: 'GraphQLError',
    path: [
      'User',
      '@authorization',
      'validate',
      0,
      'where',
      'node',
      'userId'
    ],
    originalError: undefined,
    nodes: undefined,
    source: undefined,
    positions: undefined,
    locations: undefined,
    extensions: {},
    constructor: 'Function<GraphQLError>',
    toString: 'Function<toString>',
    toJSON: 'Function<toJSON>'
  },
  stacks: []
]
...snipped...
```

Now if you remove following @authorization in schema.graphql:

```
  @authorization(
    validate: [
      { where: { node: { userId: "$jwt.sub" } } }
      { where: { jwt: { roles_INCLUDES: "admin" } } }
    ]
  )
```

Tests will now pass...
(you can force save index.test.js to force rerun of tests)

# n4j-issues
