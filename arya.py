import hmac, hashlib

key = b"koenci"
msg = b"user:teller|bank:Fortis Bank"
sig = hmac.new(key, msg, hashlib.sha256).hexdigest()

print(sig)