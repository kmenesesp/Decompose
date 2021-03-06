package com.arkivanov.sample.counter.shared.ui.compose

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import com.arkivanov.decompose.extensions.compose.jetpack.asState
import com.arkivanov.sample.counter.shared.counter.Counter

@Composable
operator fun Counter.Model.invoke() {
    val data by data.asState()

    Box(modifier = Modifier.border(BorderStroke(width = 1.dp, color = Color.Black)).padding(16.dp)) {
        Text(text = data.text)
    }
}
