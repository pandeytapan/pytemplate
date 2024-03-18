# test_empty.py
from src import app


def test_always_true():
    app.main()
    assert True
