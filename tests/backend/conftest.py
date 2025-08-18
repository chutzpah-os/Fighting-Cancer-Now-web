"""Pytest configuration for backend tests"""
import pytest
from fastapi.testclient import TestClient
from src.backend.app.main import app

@pytest.fixture
def client():
    return TestClient(app)
