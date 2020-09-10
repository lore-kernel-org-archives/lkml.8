Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC1BC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C3F21D90
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbgIJOJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 10:09:28 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:40504 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731027AbgIJOEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:04:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id E2E7220519;
        Thu, 10 Sep 2020 15:55:01 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UI58fvqxwK8p; Thu, 10 Sep 2020 15:55:01 +0200 (CEST)
Received: from cas-essen-02.secunet.de (202.40.53.10.in-addr.arpa [10.53.40.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 69EF820501;
        Thu, 10 Sep 2020 15:55:01 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Sep 2020 15:55:01 +0200
Received: from [172.18.3.9] (172.18.3.9) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 10 Sep
 2020 15:55:00 +0200
To:     "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>,
        "Klassert, Steffen" <Steffen.Klassert@secunet.com>
From:   Christian Langrock <christian.langrock@secunet.com>
Subject: [PATCH] drivers: net: Fix *_ipsec_offload_ok(): Use ip_hdr family
Autocrypt: addr=christian.langrock@secunet.com; prefer-encrypt=mutual;
 keydata=
 LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tClZlcnNpb246IEdudVBHIHYy
 CgptUUVOQkZlZTdqa0JDQUNrZU1JdXpadS9LQkExcTNrS0dyN2Q5aWlaR0Y1SXBKbklFOWRN
 aUszdWF6N3VNMjZWClNUSlZwNmpkR3VTR0dHbWI4MU9TTEVjSUVJc1lLWHZqYmxBS1VYMUE3
 NHQzV01SY2t5M013SmJtTjZBa044UWwKUDQ1bURkZHRQUmYxRWxCMlMzMmk5T3JFa3Z3OHhj
 dkhZUHdiYUhlblhpYzQvOGZIV0VoK3Z0ZC81LzVURFRJVQovYWc5dFFmUGVhMTNpeFhOMFB1
 Y2NNdWJGZVVNcHdGQ2czMjQrWjE5aUd2ZkRXV1ptUVFHbEJqYzNRNnowaFhPCmIvZGVXTC8r
 bFBTNHQrdFRncG1tWk80WGtJcysxOEtxeENWdWtDYm5xVjB5KzA0c2ozRzFHUS9EbEd2Wkh4
 d3kKd0JjZUFMN0J2bWRlWFFLQVMwS1JMNXpyZ2hJQkNnblV5dXREQUJFQkFBRzBNME5vY21s
 emRHbGhiaUJNWVc1bgpjbTlqYXlBOFkyaHlhWE4wYVdGdUxteGhibWR5YjJOclFITmxZM1Z1
 WlhRdVkyOXRQb2tCTndRVEFRZ0FJUVVDClY1N3VPUUliQXdVTENRZ0hBZ1lWQ0FrS0N3SUVG
 Z0lEQVFJZUFRSVhnQUFLQ1JDamVNZGZndXRyWHUza0NBQ0kKQng2VUhSZUJ0QmNpTlVQa1Az
 ZlJhR2VTT0FESXJxbDcyVktEOWZhTEFIVHQ2dzhrdnl6YjhDdHBhNzdqc3dKdAoyMWMzNDlt
 RjNtYVBscE50cHN3cUgyN2JUbFhZaE5jWHhjbUhQQ2JOdE4zeUdVeTBVdUlKZkJNWmM4UExx
 aXFZCm9ZNUdLRDN1aW1lVmJEWWpnTmhlYk8yZjFjVXZ3WTJ3VHdYNmIwdGdLVksweFlZVERw
 WEkxLzJNVkdzalhxYWsKN1BRb3FWcTBzRHUwZ0lBQWkxUU8wRmJiNmpJYUhqNkNFTTJocEJU
 Qms4cWJrUHMvTXFZR2RMbDRvWHZrV1RMZAp1UWptNmRNdGp4dkl0NldKV1pRYkxqVGVRSWZj
 MjFsdU5RS0RtZlQ2MjNwVlRQUE1NQWNpV2ZwZHc2M0ZibGZHCmNmQm5BS0NKOEpCajB6OVQ2
 L1BtdVFFTkJGZWU3amtCQ0FEUzdhbUpQYlkyZFdwZUd0RStJOXlMTDUzbFNyaVAKNEw2ckk5
 VW9Fd05NMU9ram5CN3dGbkg4ZG04TjY4SzJPSm9na0h3b1gyT256R2h4SjI4TkhSdUFoKysz
 aElZWQorZ1U0SE1MYVgzb25ESzFvcUFkWWN6aEo3ZjZVQ1BiWWFnaGt6SjZWZy9GRVdwQTh1
 NXZHL0JYNHkrRjMvWTk4Cmw2bXpBWDV3TG1UYXBSd2RmdVJDWFJBNmpsSUhJT3dQM05QS0s0
 UHoyRTd3aXRzaW1WMXVjTjR1WEZpWjM2Q1UKUEFpWFhsRVI5aVBablFVU3lDb2JxSk9KS200
 Qzd3VU5RMW5lZ0NYREJkM0tqU3l6VElhZncvb1lHNFJyV0d1bAppSTJpZy9xVFVDOGNaZEFK
 VE1CalVKUjZ1Z0phek1CMVJnMTdwMkdSRDBBelVPVjJxZHFZRnFRRkFCRUJBQUdKCkFSOEVH
 QUVJQUFrRkFsZWU3amtDR3d3QUNna1FvM2pIWDRMcmExN3Z0UWdBZzJnMEpFWFZUR1QzNkJE
 SmdWakkKVVkxZXZubTFmV3dUUHBjb2tQLzgvYU8ydWJtbHh0V1EyaFY1T1BmTDVuRGRheTJT
 NE5xNWoza3FRcStydlVyTwpSVm12VDRXeFlaTTFmcjJuaWJ1emFVYnNKdHhwaE5wamFocnNF
 Y0xMVHpCVzRDYkhUYUw0WVRUK1pEL0dEZUhvCnhBaDlKZk1rZE1CWEh5V1R1dytRU1AwcHA3
 V3ZOc0Rvc3VrS0Z5UTBydmU5UEgyZHJ5NkEwb0xQN1V4dEF6RUUKUlYyU2UwQnVlWlBRdVZu
 VTZDdmozWlN0SzI4SkRoTWp4SVBrWlBFNWtDVjhRTkY4T3Npd3ltQTNhb1BLZTVCdwowbE9j
 anV1Smt4UmE1YmF6eXV1Ylg5cElJZ1RlR3NlY2dwU2dwZkE5anNFSEtGcW9MdXhVQSs3N1ZR
 NWhTeWRWCmFRPT0KPU82RWEKLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=
Message-ID: <90008df8-c3b5-8f17-9007-589a36c0be42@secunet.com>
Date:   Thu, 10 Sep 2020 15:54:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="Jy5hbqDbKTD1UkvGYA45RAzkdXWZC54Kn"
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Jy5hbqDbKTD1UkvGYA45RAzkdXWZC54Kn
Content-Type: multipart/mixed; boundary="lzhpMulXL15L3l0CJhW0Be0KUKekFrSMe";
 protected-headers="v1"
From: Christian Langrock <christian.langrock@secunet.com>
To: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 "Klassert, Steffen" <Steffen.Klassert@secunet.com>
Message-ID: <90008df8-c3b5-8f17-9007-589a36c0be42@secunet.com>
Subject: [PATCH] drivers: net: Fix *_ipsec_offload_ok(): Use ip_hdr family

--lzhpMulXL15L3l0CJhW0Be0KUKekFrSMe
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: de-DE

WGZybV9kZXZfb2ZmbG9hZF9vaygpIGlzIGNhbGxlZCB3aXRoIHRoZSB1bmVuY3J5cHRlZCBT
S0IuIFNvIGluIGNhc2Ugb2YKaW50ZXJmYW1pbHkgaXBzZWMgdHJhZmZpYyAoSVB2NC1pbi1J
UHY2IGFuZCBJUHY2IGluIElQdjQpIHRoZSBjaGVjawphc3N1bWVzIHRoZSB3cm9uZyBmYW1p
bHkgb2YgdGhlIHNrYiAoSVAgZmFtaWx5IG9mIHRoZSBzdGF0ZSkuCldpdGggdGhpcyBwYXRj
aCB0aGUgaXAgaGVhZGVyIG9mIHRoZSBTS0IgaXMgdXNlZCB0byBkZXRlcm1pbmUgdGhlCmZh
bWlseS4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBMYW5ncm9jayA8Y2hyaXN0aWFuLmxh
bmdyb2NrQHNlY3VuZXQuY29tPgotLS0KwqBkcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
eGdiZS9peGdiZV9pcHNlYy5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyICstCsKgZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmV2Zi9pcHNlYy5jwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8IDIgKy0KwqBkcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1
L2NvcmUvZW5fYWNjZWwvaXBzZWMuYyB8IDIgKy0KwqAzIGZpbGVzIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9l
dGhlcm5ldC9pbnRlbC9peGdiZS9peGdiZV9pcHNlYy5jCmIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaXhnYmUvaXhnYmVfaXBzZWMuYwppbmRleCBlY2E3MzUyNmFjODYuLjM2MDFk
ZDI5MzQ2MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaXhnYmUv
aXhnYmVfaXBzZWMuYworKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZS9p
eGdiZV9pcHNlYy5jCkBAIC04MTMsNyArODEzLDcgQEAgc3RhdGljIHZvaWQgaXhnYmVfaXBz
ZWNfZGVsX3NhKHN0cnVjdCB4ZnJtX3N0YXRlICp4cykKwqAgKiovCsKgc3RhdGljIGJvb2wg
aXhnYmVfaXBzZWNfb2ZmbG9hZF9vayhzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3QKeGZy
bV9zdGF0ZSAqeHMpCsKgewotwqDCoMKgwqDCoMKgIGlmICh4cy0+cHJvcHMuZmFtaWx5ID09
IEFGX0lORVQpIHsKK8KgwqDCoMKgwqDCoCBpZiAoaXBfaGRyKHNrYiktPnZlcnNpb24gPT0g
NCkgewrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogT2ZmbG9hZCB3aXRoIElQ
djQgb3B0aW9ucyBpcyBub3Qgc3VwcG9ydGVkIHlldCAqLwrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKGlwX2hkcihza2IpLT5paGwgIT0gNSkKwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7CmRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZXZmL2lwc2VjLmMKYi9kcml2
ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9peGdiZXZmL2lwc2VjLmMKaW5kZXggNTE3MGRkOWQ4
NzA1Li5iMWQ3MmQ1ZDE3NDQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2l4Z2JldmYvaXBzZWMuYworKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
eGdiZXZmL2lwc2VjLmMKQEAgLTQxOCw3ICs0MTgsNyBAQCBzdGF0aWMgdm9pZCBpeGdiZXZm
X2lwc2VjX2RlbF9zYShzdHJ1Y3QgeGZybV9zdGF0ZSAqeHMpCsKgICoqLwrCoHN0YXRpYyBi
b29sIGl4Z2JldmZfaXBzZWNfb2ZmbG9hZF9vayhzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1
Y3QKeGZybV9zdGF0ZSAqeHMpCsKgewotwqDCoMKgwqDCoMKgIGlmICh4cy0+cHJvcHMuZmFt
aWx5ID09IEFGX0lORVQpIHsKK8KgwqDCoMKgwqDCoCBpZiAoaXBfaGRyKHNrYiktPnZlcnNp
b24gPT0gNCkgewrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogT2ZmbG9hZCB3
aXRoIElQdjQgb3B0aW9ucyBpcyBub3Qgc3VwcG9ydGVkIHlldCAqLwrCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgaWYgKGlwX2hkcihza2IpLT5paGwgIT0gNSkKwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7CmRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5f
YWNjZWwvaXBzZWMuYwpiL2RyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94L21seDUvY29y
ZS9lbl9hY2NlbC9pcHNlYy5jCmluZGV4IGQzOTk4OWNkZGQ5MC4uZTNhOWIzMTNiMDFmIDEw
MDY0NAotLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1L2NvcmUvZW5f
YWNjZWwvaXBzZWMuYworKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9tZWxsYW5veC9tbHg1
L2NvcmUvZW5fYWNjZWwvaXBzZWMuYwpAQCAtNDYwLDcgKzQ2MCw3IEBAIHZvaWQgbWx4NWVf
aXBzZWNfY2xlYW51cChzdHJ1Y3QgbWx4NWVfcHJpdiAqcHJpdikKwqAKwqBzdGF0aWMgYm9v
bCBtbHg1ZV9pcHNlY19vZmZsb2FkX29rKHN0cnVjdCBza19idWZmICpza2IsIHN0cnVjdAp4
ZnJtX3N0YXRlICp4KQrCoHsKLcKgwqDCoMKgwqDCoCBpZiAoeC0+cHJvcHMuZmFtaWx5ID09
IEFGX0lORVQpIHsKK8KgwqDCoMKgwqDCoCBpZiAoaXBfaGRyKHNrYiktPnZlcnNpb24gPT0g
NCkgewrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogT2ZmbG9hZCB3aXRoIElQ
djQgb3B0aW9ucyBpcyBub3Qgc3VwcG9ydGVkIHlldCAqLwrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKGlwX2hkcihza2IpLT5paGwgPiA1KQrCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsKLS0gCjIuMjEu
MAoK

--lzhpMulXL15L3l0CJhW0Be0KUKekFrSMe--

--Jy5hbqDbKTD1UkvGYA45RAzkdXWZC54Kn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJfWjArAAoJEKN4x1+C62teWPUH/i6xqBNeT1XQaJ4lAqo3MQi5
pfx7Le0s9asAw9EMkQy93LGiwhv+lpUDYub8ByeiQHQm04DqRASaLwTHy6Fg079V
AbyF1Z6BG9ty0HEpJKI6fIB0oTvNqOctxHlG11hIOVfN7+tfZb1y8O7nhf8PI3cB
6o9wSpfT6fBLpB2eq5ftvzYouWg93q4wJ2UUZAjuoa0hYuX5914W67LWJWPbHB6r
UdoNA0QtBp7+yVZ7gu3EbZIYrjUoWXb8ZHfYra0l+nXU+Fesgwejm+MV3a62GGt4
4FBOdI9daMdiQSKPwsybWBH/VWoGpSIRPAuPrHqq68lI7Vigyy979RWWITircQg=
=z2k1
-----END PGP SIGNATURE-----

--Jy5hbqDbKTD1UkvGYA45RAzkdXWZC54Kn--
