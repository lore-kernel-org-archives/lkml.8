Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C48A1C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DE2206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbgCaNwc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:52:32 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:43666 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730720AbgCaNwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:52:30 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-143-jkmKQ7PtMXS4q6yTaSr5GQ-1; Tue, 31 Mar 2020 14:52:24 +0100
X-MC-Unique: jkmKQ7PtMXS4q6yTaSr5GQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 31 Mar 2020 14:52:23 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 31 Mar 2020 14:52:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 12/12] lib/iov_iter: Remove import_iovec() and
 compat_import_iovec()
Thread-Topic: [RFC PATCH 12/12] lib/iov_iter: Remove import_iovec() and
 compat_import_iovec()
Thread-Index: AdYHY1UVNWOYnMjFTbW4EDiG1D+Hjw==
Date:   Tue, 31 Mar 2020 13:52:23 +0000
Message-ID: <d56dbd1ad6914d2d8ef7e90c3862e17f@AcuMS.aculab.com>
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


All the callers have been changed to use iovec_import() and
compat_iovec_import().

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/uio.h |  8 -------
 lib/iov_iter.c      | 61 -----------------------------------------------------
 2 files changed, 69 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 1e7a3f1..a2762e1 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -271,20 +271,12 @@ struct iovec_cache {
 	struct iovec  iov[UIO_FASTIOV];
 };
 
-ssize_t import_iovec(int type, const struct iovec __user * uvector,
-		 unsigned nr_segs, unsigned fast_segs,
-		 struct iovec **iov, struct iov_iter *i);
-
 struct iovec *iovec_import(int type, const struct iovec __user * uvector,
 		unsigned int nr_segs, struct iovec_cache *cache,
 		struct iov_iter *i);
 
 #ifdef CONFIG_COMPAT
 struct compat_iovec;
-ssize_t compat_import_iovec(int type, const struct compat_iovec __user * uvector,
-		 unsigned nr_segs, unsigned fast_segs,
-		 struct iovec **iov, struct iov_iter *i);
-
 struct iovec *compat_iovec_import(int type,
 		const struct compat_iovec __user * uvector,
 		unsigned int nr_segs, struct iovec_cache *cache,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index ab33b69..fc31e41 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1739,47 +1739,6 @@ struct iovec *iovec_import(int type, const struct iovec __user * uvector,
 }
 EXPORT_SYMBOL(iovec_import);
 
-/**
- * import_iovec() - Copy an array of &struct iovec from userspace
- *     into the kernel, check that it is valid, and initialize a new
- *     &struct iov_iter iterator to access it.
- *
- * @type: One of %READ or %WRITE.
- * @uvector: Pointer to the userspace array.
- * @nr_segs: Number of elements in userspace array.
- * @fast_segs: Number of elements in @iov.
- * @iov: (input and output parameter) Pointer to pointer to (usually small
- *     on-stack) kernel array.
- * @i: Pointer to iterator that will be initialized on success.
- *
- * If the array pointed to by *@iov is large enough to hold all @nr_segs,
- * then this function places %NULL in *@iov on return. Otherwise, a new
- * array will be allocated and the result placed in *@iov. This means that
- * the caller may call kfree() on *@iov regardless of whether the small
- * on-stack array was used or not (and regardless of whether this function
- * returns an error or not).
- *
- * Return: Negative error code on error, bytes imported on success
- */
-ssize_t import_iovec(int type, const struct iovec __user * uvector,
-		 unsigned nr_segs, unsigned fast_segs,
-		 struct iovec **iov, struct iov_iter *i)
-{
-	struct iovec *iov_kmalloc;
-
-	iov_kmalloc = iovec_import(type, uvector, nr_segs,
-		fast_segs >= UIO_FASTIOV ? (void *)*iov : NULL, i);
-
-	if (IS_ERR(iov_kmalloc)) {
-		*iov = NULL;
-		return PTR_ERR(iov_kmalloc);
-	}
-
-	*iov = iov_kmalloc;
-	return i->count;
-}
-EXPORT_SYMBOL(import_iovec);
-
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
 
@@ -1849,26 +1808,6 @@ struct iovec *compat_iovec_import(int type,
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(compat_iovec_import);
-
-ssize_t compat_import_iovec(int type,
-		const struct compat_iovec __user * uvector,
-		unsigned nr_segs, unsigned fast_segs,
-		struct iovec **iov, struct iov_iter *i)
-{
-	struct iovec *iov_kmalloc;
-
-	iov_kmalloc = compat_iovec_import(type, uvector, nr_segs,
-		fast_segs >= UIO_FASTIOV ? (void *)*iov : NULL, i);
-
-	if (IS_ERR(iov_kmalloc)) {
-		*iov = NULL;
-		return PTR_ERR(iov_kmalloc);
-	}
-
-	*iov = iov_kmalloc;
-	return i->count;
-}
-EXPORT_SYMBOL(compat_import_iovec);
 #endif
 
 int import_single_range(int rw, void __user *buf, size_t len,
-- 
1.8.1.2

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

