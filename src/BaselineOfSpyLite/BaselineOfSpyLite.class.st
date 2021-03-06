Class {
	#name : #BaselineOfSpyLite,
	#superclass : #BaselineOf,
	#category : #BaselineOfSpyLite
}

{ #category : #baselines }
BaselineOfSpyLite >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'SpyLite';
				package: 'SpyLite-Scenario';
				package: 'SpyLite-Tests' ]
]
