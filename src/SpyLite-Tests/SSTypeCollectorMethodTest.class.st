Class {
	#name : #SSTypeCollectorMethodTest,
	#superclass : #TestCase,
	#instVars : [
		'typeCollectorMethod'
	],
	#category : #'SpyLite-Tests'
}

{ #category : #tests }
SSTypeCollectorMethodTest >> nameOf: aClass [ 
	^ aClass name
]

{ #category : #running }
SSTypeCollectorMethodTest >> setUp [ 
	typeCollectorMethod := SSTypeCollectorMethod new
]

{ #category : #tests }
SSTypeCollectorMethodTest >> testSelectLiteralsOf [
  | source dictLiterals |
  source := 'test1 
	^ 1
	'.
  typeCollectorMethod selectLiteralsOf: source.
  dictLiterals := typeCollectorMethod dictLiterals.
  self assertCollection: dictLiterals keys hasSameElements: (Array with: (self nameOf: SmallInteger)).
  self assertCollection: (dictLiterals values flatCollect: [:s |  s ]) hasSameElements: #(1).
  source := 'test2
		|number string|
		number := 2.
		string := ''hello''.
		number = 5 ifTrue: [string := ''world''].'.
  typeCollectorMethod selectLiteralsOf: source.
  dictLiterals := typeCollectorMethod dictLiterals.
  self assertCollection: dictLiterals keys hasSameElements: (Array with: (self nameOf: SmallInteger) with: (self nameOf: ByteString)).
  self assertCollection: (dictLiterals values flatCollect: [:val |  val ]) hasSameElements: #(2 5 'hello' 'world')
]

{ #category : #tests }
SSTypeCollectorMethodTest >> testSelectLiteralsOfMethodsWithoutLiterals [
	| source  |
	source := 'test1 
	^ name
	'.
	typeCollectorMethod selectLiteralsOf: source.
	self
		assert: typeCollectorMethod dictLiterals associations isEmpty.
	source := 'test2
		name = nickname ifTrue: [id := age].'.
	typeCollectorMethod selectLiteralsOf: source.
	self
		assert: typeCollectorMethod dictLiterals associations isEmpty
]
