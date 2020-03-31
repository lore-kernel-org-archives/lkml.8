Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B86DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287C120784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgCaNwN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:52:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:47200 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730358AbgCaNwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:52:12 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-118-Mbas2b6EMiWakey4l12CzQ-1; Tue, 31 Mar 2020 14:52:08 +0100
X-MC-Unique: Mbas2b6EMiWakey4l12CzQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 31 Mar 2020 14:52:08 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 31 Mar 2020 14:52:08 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 06/12] security/keys: Use iovec_import() instead of
 import_iovec().
Thread-Topic: [RFC PATCH 06/12] security/keys: Use iovec_import() instead of
 import_iovec().
Thread-Index: AdYHYfLlusnfXX0iSViMb7YRvmbBBQ==
Date:   Tue, 31 Mar 2020 13:52:08 +0000
Message-ID: <94adff930f134d77acc3b394b0fedf77@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: David Laight <david.laight@aculab.com>
---
 security/keys/compat.c | 11 +++++------
 security/keys/keyctl.c | 10 +++++-----
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/security/keys/compat.c b/security/keys/compat.c
index b975f8f..178412a 100644
--- a/security/keys/compat.c
+++ b/security/keys/compat.c
@@ -26,18 +26,17 @@ static long compat_keyctl_instantiate_key_iov(
 	unsigned ioc,
 	key_serial_t ringid)
 {
-	struct iovec iovstack[UIO_FASTIOV], *iov = iovstack;
+	struct iovec_cache cache;
 	struct iov_iter from;
+	struct iovec *iov;
 	long ret;
 
 	if (!_payload_iov)
 		ioc = 0;
 
-	ret = compat_import_iovec(WRITE, _payload_iov, ioc,
-				  ARRAY_SIZE(iovstack), &iov,
-				  &from);
-	if (ret < 0)
-		return ret;
+	iov = compat_iovec_import(WRITE, _payload_iov, ioc, &cache, &from);
+	if (IS_ERR(iov))
+		return PTR_ERR(iov);
 
 	ret = keyctl_instantiate_key_common(id, &from, ringid);
 	kfree(iov);
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 9b898c9..e93b4e6 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1208,17 +1208,17 @@ long keyctl_instantiate_key_iov(key_serial_t id,
 				unsigned ioc,
 				key_serial_t ringid)
 {
-	struct iovec iovstack[UIO_FASTIOV], *iov = iovstack;
+	struct iovec_cache cache;
 	struct iov_iter from;
+	struct iovec *iov;
 	long ret;
 
 	if (!_payload_iov)
 		ioc = 0;
 
-	ret = import_iovec(WRITE, _payload_iov, ioc,
-				    ARRAY_SIZE(iovstack), &iov, &from);
-	if (ret < 0)
-		return ret;
+	iov = iovec_import(WRITE, _payload_iov, ioc, &cache, &from);
+	if (IS_ERR(iov))
+		return PTR_ERR(iov);
 	ret = keyctl_instantiate_key_common(id, &from, ringid);
 	kfree(iov);
 	return ret;
-- 
1.8.1.2

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

