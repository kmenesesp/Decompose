//
//  CounterInnerView.swift
//  ios-app
//
//  Created by Arkadii Ivanov on 9/12/20.
//  Copyright © 2020 Arkadii Ivanov. All rights reserved.
//

import SwiftUI
import Counter

struct CounterInnerView: View {
    private let events: CounterInnerContainerEvents
    private let counter: CounterModel
    
    @ObservedObject
    private var leftChild: ObservableValue<RouterState<AnyObject, CounterInnerContainerChild>>
    
    @ObservedObject
    private var rightChild: ObservableValue<RouterState<AnyObject, CounterInnerContainerChild>>
    
    init(_ model: CounterInnerContainerModel) {
        self.events = model
        self.counter = model.counter
        self.leftChild = ObservableValue(model.leftChild)
        self.rightChild = ObservableValue(model.rightChild)
    }
    
    var body: some View {
        let activeLeftChild = self.leftChild.value.activeChild.component
        let activeRightChild = self.rightChild.value.activeChild.component

        return VStack(spacing: 8) {
            CounterView(self.counter)
            
            HStack(spacing: 8) {
                ChildView(child: activeLeftChild, next: self.events.onNextLeftChild, prev: self.events.onPrevLeftChild)
                ChildView(child: activeRightChild, next: self.events.onNextRightChild, prev: self.events.onPrevRightChild)
            }
        }
    }
    
    private func ChildView(
        child: CounterInnerContainerChild,
        next: @escaping () -> Void,
        prev: @escaping () -> Void
    ) -> some View {
        return VStack(spacing: 8) {
            Button(action: next, label: { Text("Next Counter") })
            
            Button(action: prev, label: { Text("Prev Counter") })
                .disabled(!child.isBackEnabled)
            
            CounterView(child.counter)
        }
    }
}

struct CounterInnerView_Previews: PreviewProvider {
    static var previews: some View {
        CounterInnerView(Model())
    }
    
    class Model : CounterInnerContainerModel {
        let counter: CounterModel = CounterView_Previews.Model()
        
        let leftChild: Value<RouterState<AnyObject, CounterInnerContainerChild>> =
            simpleRouterState(
                CounterInnerContainerChild(
                    counter: CounterView_Previews.Model(),
                    isBackEnabled: true
                )
        )
        
        let rightChild: Value<RouterState<AnyObject, CounterInnerContainerChild>> =
            simpleRouterState(
                CounterInnerContainerChild(
                    counter: CounterView_Previews.Model(),
                    isBackEnabled: false
                )
        )
        
        init() {
        }
        
        func onNextLeftChild() {
        }
        
        func onNextRightChild() {
        }
        
        func onPrevLeftChild() {
        }
        
        func onPrevRightChild() {
        }
    }
}
