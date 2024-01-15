import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterOutlet } from '@angular/router';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterOutlet],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent implements OnInit {
  private BOOKS_URL = 'http://localhost:3000/api/books';
  title = 'frontend';
  books: Book[] = []

  ngOnInit() {
    this.loadBooks();
  }

  private async loadBooks(){
    const fetchData = await fetch(this.BOOKS_URL);
    this.books = await fetchData.json();
  }
}

interface Book {
  name: string;
  author: string;
  year: string;
  isbn: string;
}
