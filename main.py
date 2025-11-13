import getpass


def hello():
    """Print hello message"""
    username = getpass.getuser()
    print(f"Hello from {username}!")


if __name__ == "__main__":
    hello()
