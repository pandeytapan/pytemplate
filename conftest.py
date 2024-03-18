# conftest.py
import sys
from pathlib import Path

# Append src directory to sys.path
sys.path.append(str(Path(__file__).parent / "src"))
