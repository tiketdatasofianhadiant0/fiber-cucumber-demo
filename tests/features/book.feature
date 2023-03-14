Feature: Book management
    In order to use book API
    As a Librarian
    I need to be able to manage books

    Scenario: at first, should get empty books
        When I send "GET" request to "/books"
        Then the response code should be 200
        And the response payload should match json:
        """
        []
        """
    
    Scenario: try to insert one book, should get one created book
        When I send "POST" request to "/books" with payload:
        """
        {
            "id": 1,
            "title": "Dune",
            "author": "Frank Herbert"
        }   
        """
        Then the response code should be 201
        And the response payload should match json:
        """
        [
            {
                "id": 1,
                "title": "Dune",
                "author": "Frank Herbert"
            }
        ]   
        """

    Scenario: enable to search by title
        When I send "GET" request to "/books?title=Dune"
        Then the response code should be 200
        And the response payload should match json:
        """
        [
            {
                "id": 1,
                "title": "Dune",
                "author": "Frank Herbert"
            }
        ]
        """
    
    Scenario: should get all books
        Given there are books:
          | id | title        | author        |
          | 2  | Frankenstein | Mary Shelley  |
          | 3  | The Martian  | Andy Wier     |
        When I send "GET" request to "/books"
        Then the response code should be 200
        And the response payload should match json:
        """
        [
            {
                "id": 1,
                "title": "Dune",
                "author": "Frank Herbert"
            },
            {
                "id": 2,
                "title": "Frankenstein",
                "author": "Mary Shelley"
            },
            {
                "id": 3,
                "title": "The Martian",
                "author": "Andy Wier"
            }
        ]
        """