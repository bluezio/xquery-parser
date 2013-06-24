lexer grammar XQueryLexer;

tokens {
  // This virtual token is used by the rewriter to join all the little
  // tokens in dirElemContent together.
  ELEMENT_CONTENT
}

// NUMBERS

IntegerLiteral: Digits ;
DecimalLiteral: '.' Digits | Digits '.' [0-9]* ;
DoubleLiteral: ('.' Digits | Digits ('.' [0-9]*)?) [eE] [+-]? Digits ;

fragment
Digits: [0-9]+ ;

// STRINGS

StringLiteral: '"' (PredefinedEntityRef | CharRef | EscapeQuot | ~[^"&])* '"'
             | '\'' (PredefinedEntityRef | CharRef | EscapeApos | ~[^'&])* '\''
             ;
PredefinedEntityRef: '&' ('lt'|'gt'|'amp'|'quot'|'apos') ';' ;
EscapeQuot: '""' ;
EscapeApos: '\'\'' ;
Quot: '"'  ;
Apos: '\'' ;

// XML-SPECIFIC

COMMENT: '<!--' .*? '-->' ;
PI:      '<?' .*? '?>' ;
CDATA:   '<![CDATA[' .*? ']]>' ;
PRAGMA:  '(#' .*? '#)' ;

// This could be checked elsewhere: http://www.w3.org/TR/REC-xml/#wf-Legalchar
CharRef: '&#' [0-9]+ ';' | '&#x' [0-9a-fA-F]+ ';' ;

// WHITESPACE

// S ::= (#x20 | #x9 | #xD | #xA)+
WS: [ \t\r\n]+ -> channel(HIDDEN);

// OPERATORS

EQUAL:     '='  ;
NOT_EQUAL: '!=' ;
LPAREN:    '(' ;
RPAREN:    ')' ;
LBRACKET:  '[' ;
RBRACKET:  ']' ;
LBRACE:    '{' ;
RBRACE:    '}' ;

STAR:  '*' ;
PLUS:  '+' ;
MINUS: '-' ;

COMMA:     ',' ;
DOT:       '.' ;
DDOT:      '..' ;
COLON:     ':' ;
DCOLON:    '::' ;
COLON_EQ:  ':=' ;
SEMICOLON: ';' ;

SLASH:  '/'  ;
DSLASH: '//' ;
VBAR:   '|'  ;

LANGLE:    '<'  ;
DLANGLE:   '<<' ;
RANGLE:    '>'  ;
DRANGLE:   '>>' ;
LANGLE_EQ: '<=' ;
RANGLE_EQ: '>=' ;

QUESTION: '?' ;
AT: '@' ;
DOLLAR: '$' ;

// KEYWORDS

KW_ANCESTOR:           'ancestor';
KW_ANCESTOR_OR_SELF:   'ancestor-or-self';
KW_AND:                'and';
KW_AS:                 'as';
KW_ASCENDING:          'ascending';
KW_AT:                 'at';
KW_ATTRIBUTE:          'attribute';
KW_BASE_URI:           'base-uri';
KW_BOUNDARY_SPACE:     'boundary-space';
KW_BY:                 'by';
KW_CASE:               'case';
KW_CAST:               'cast';
KW_CASTABLE:           'castable';
KW_CHILD:              'child';
KW_COLLATION:          'collation';
KW_COMMENT:            'comment';
KW_CONSTRUCTION:       'construction';
KW_COPY_NS:            'copy-namespaces';
KW_DECLARE:            'declare';
KW_DEFAULT:            'default';
KW_DESCENDANT:         'descendant';
KW_DESCENDANT_OR_SELF: 'descendant-or-self';
KW_DESCENDING:         'descending';
KW_DIV:                'div';
KW_DOCUMENT:           'document';
KW_DOCUMENT_NODE:      'document-node';
KW_ELEMENT:            'element';
KW_ELSE:               'else';
KW_EMPTY:              'empty';
KW_EMPTY_SEQUENCE:     'empty-sequence';
KW_ENCODING:           'encoding';
KW_EQ:                 'eq';
KW_EVERY:              'every';
KW_EXCEPT:             'except';
KW_EXTERNAL:           'external';
KW_FOLLOWING:          'following';
KW_FOLLOWING_SIBLING:  'following-sibling';
KW_FOR:                'for';
KW_FUNCTION:           'function';
KW_GE:                 'ge';
KW_GREATEST:           'greatest';
KW_GT:                 'gt';
KW_IDIV:               'idiv';
KW_IF:                 'if';
KW_IMPORT:             'import';
KW_IN:                 'in';
KW_INHERIT:            'inherit';
KW_INSTANCE:           'instance';
KW_INTERSECT:          'intersect';
KW_IS:                 'is';
KW_ITEM:               'item';
KW_LATEST:             'latest';
KW_LAX:                'lax';
KW_LE:                 'le';
KW_LEAST:              'least';
KW_LET:                'let';
KW_LT:                 'lt';
KW_MOD:                'mod';
KW_MODULE:             'module';
KW_NAMESPACE:          'namespace';
KW_NE:                 'ne';
KW_NO_INHERIT:         'no-inherit';
KW_NO_PRESERVE:        'no-preserve';
KW_NODE:               'node';
KW_OF:                 'of';
KW_OPTION:             'option';
KW_OR:                 'or';
KW_ORDER:              'order';
KW_ORDERED:            'ordered';
KW_ORDERING:           'ordering';
KW_PARENT:             'parent';
KW_PRECEDING:          'preceding';
KW_PRECEDING_SIBLING:  'preceding-sibling';
KW_PRESERVE:           'preserve';
KW_PI:                 'processing-instruction';
KW_RETURN:             'return';
KW_SATISFIES:          'satisfies';
KW_SCHEMA:             'schema';
KW_SCHEMA_ATTR:        'schema-attribute';
KW_SCHEMA_ELEM:        'schema-element';
KW_SELF:               'self';
KW_SOME:               'some';
KW_STABLE:             'stable';
KW_STRICT:             'strict';
KW_STRIP:              'strip';
KW_TEXT:               'text';
KW_THEN:               'then';
KW_TO:                 'to';
KW_TREAT:              'treat';
KW_TYPESWITCH:         'typeswitch';
KW_UNION:              'union';
KW_UNORDERED:          'unordered';
KW_VALIDATE:           'validate';
KW_VARIABLE:           'variable';
KW_VERSION:            'version';
KW_WHERE:              'where';
KW_XQUERY:             'xquery';

// NAMES

// We create these basic variants in order to honor ws:explicit in some basic cases
FullQName: NCName ':' NCName ;
NCNameWithLocalWildcard:  NCName ':' '*' ;
NCNameWithPrefixWildcard: '*' ':' NCName ; 

// According to http://www.w3.org/TR/REC-xml-names/#NT-NCName,
// it is 'an XML Name, minus the ":"'
NCName: NameStartChar NameChar*;

fragment
NameStartChar: [_a-zA-Z]
    | '\u00C0'..'\u00D6'
    | '\u00D8'..'\u00F6'
    | '\u00F8'..'\u02FF'
    | '\u0370'..'\u037D'
    | '\u037F'..'\u1FFF'
    | '\u200C'..'\u200D'
    | '\u2070'..'\u218F'
    | '\u2C00'..'\u2FEF'
    | '\u3001'..'\uD7FF'
    | '\uF900'..'\uFDCF'
    | '\uFDF0'..'\uFFFD'
    ;

fragment
NameChar: NameStartChar
        | '-'
        | '.'
        | [0-9]
        | '\u00B7'
        | '\u0300'..'\u036F'
        | '\u203F'..'\u2040'
        ;

// SPECIAL CHARACTER DEFINITIONS (LOWEST PRIORITY)

// [148] ElementContentChar  ::= Char - [{}<&] -> fallback for dirElemContent
ElementContentChar:  ~[{}<&]  ;

// [149] QuotAttrContentChar ::= Char - ["{}<&] -> better handled in a separate parser
//QuotAttrContentChar: {quotAttr}? ~["{}<&] ;

// [150] AposAttrContentChar ::= Char - ['{}<&] -> better handled in a separate parser
//AposAttrContentChar: {aposAttr}? ~['{}<&] ;

// XQUERY COMMENTS /////////////////////////////////////////////////////////////

XQCommentOpen: '(:' -> more, pushMode(XQC1);

mode XQC1;

XQCOpen:   '(:' -> more, pushMode(XQC2);
XQComment: ':)' -> popMode, channel(HIDDEN);
XQCIgnore: .    -> more;

mode XQC2;

XQC2Open: '(:'  -> more, pushMode(XQC2);
XQC2Close: ':)' -> more, popMode;
XQC2Ignore: .   -> more;
