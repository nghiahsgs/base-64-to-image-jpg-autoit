kq=base64.b64decode(snapshot)
f=open(r'snapshot.png','wb')
f.write(kq)
f.close()