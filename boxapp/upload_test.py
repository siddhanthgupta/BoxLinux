from box import BoxClient
from StringIO import StringIO


response= {u'access_token': u'VVeRMPOXltFoSWAckvADXTwQyrZsc906', u'restricted_to': [], u'token_type': u'bearer', u'expires_in': 4040, u'refresh_token': u'y5KyiuQstgWdEZsYifALo13EH5x7j5HGxBVlXOnIy6kfeKHSLsMTyA1MC4a5zfdP'}
client = BoxClient(response['access_token'])
client.upload_file('shit.txt', StringIO('fuck the world'))

