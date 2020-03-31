Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F96FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C70920784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbgCaNwQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:52:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:33876 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731057AbgCaNwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:52:14 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-167-Tx5hOMWfNXW-RDVHHSlZrA-1; Tue, 31 Mar 2020 14:52:11 +0100
X-MC-Unique: Tx5hOMWfNXW-RDVHHSlZrA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 31 Mar 2020 14:52:10 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 31 Mar 2020 14:52:10 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 07/12] mm/process_vm_access: Use iovec_import() instead of
 import_iovec().
Thread-Topic: [RFC PATCH 07/12] mm/process_vm_access: Use iovec_import()
 instead of import_iovec().
Thread-Index: AdYHYglIBZNWUXakSjKnMjGogvIqMQ==
Date:   Tue, 31 Mar 2020 13:52:10 +0000
Message-ID: <8950a02e53124117aacc56633c00b0ab@AcuMS.aculab.com>
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
 mm/process_vm_access.c | 81 ++++++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index 2829e26..96fec46 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -260,10 +260,10 @@ static ssize_t process_vm_rw(pid_t pid,
 			     unsigned long riovcnt,
 			     unsigned long flags, int vm_write)
 {
-	struct iovec iovstack_l[UIO_FASTIOV];
-	struct iovec iovstack_r[UIO_FASTIOV];
-	struct iovec *iov_l = iovstack_l;
-	struct iovec *iov_r = iovstack_r;
+	struct iovec_cache cache_l;
+	struct iovec_cache cache_r;
+	struct iovec *iov_l;
+	struct iovec *iov_r;
 	struct iov_iter iter_l, iter_r;
 	ssize_t rc;
 	int dir = vm_write ? WRITE : READ;
@@ -272,24 +272,25 @@ static ssize_t process_vm_rw(pid_t pid,
 		return -EINVAL;
 
 	/* Check iovecs */
-	rc = import_iovec(dir, lvec, liovcnt, UIO_FASTIOV, &iov_l, &iter_l);
-	if (rc < 0)
-		return rc;
-	if (!iov_iter_count(&iter_l))
-		goto free_iovecs;
-
-	rc = import_iovec(CHECK_IOVEC_ONLY, rvec, riovcnt, UIO_FASTIOV, &iov_r, &iter_r);
-	if (rc <= 0)
-		goto free_iovecs;
-
-	rc = process_vm_rw_core(pid, &iter_l, iter_r.iov, iter_r.nr_segs,
-				flags, vm_write);
+	iov_l = iovec_import(dir, lvec, liovcnt, &cache_l, &iter_l);
+	if (IS_ERR(iov_l))
+		return PTR_ERR(iov_l);
+	if (!iov_iter_count(&iter_l)) {
+		rc = 0;
+		goto free_iovec_l;
+	}
 
-free_iovecs:
-	if (iov_r != iovstack_r)
+	iov_r = iovec_import(CHECK_IOVEC_ONLY, rvec, riovcnt, &cache_r, &iter_r);
+	if (IS_ERR(iov_r)) {
+		rc = PTR_ERR(iov_r);
+	} else {
+		rc = process_vm_rw_core(pid, &iter_l, iter_r.iov,
+				iter_r.nr_segs, flags, vm_write);
 		kfree(iov_r);
-	if (iov_l != iovstack_l)
-		kfree(iov_l);
+	}
+
+free_iovec_l:
+	kfree(iov_l);
 
 	return rc;
 }
@@ -319,10 +320,10 @@ static ssize_t process_vm_rw(pid_t pid,
 		     unsigned long riovcnt,
 		     unsigned long flags, int vm_write)
 {
-	struct iovec iovstack_l[UIO_FASTIOV];
-	struct iovec iovstack_r[UIO_FASTIOV];
-	struct iovec *iov_l = iovstack_l;
-	struct iovec *iov_r = iovstack_r;
+	struct iovec_cache cache_l;
+	struct iovec_cache cache_r;
+	struct iovec *iov_l;
+	struct iovec *iov_r;
 	struct iov_iter iter_l, iter_r;
 	ssize_t rc = -EFAULT;
 	int dir = vm_write ? WRITE : READ;
@@ -330,23 +331,25 @@ static ssize_t process_vm_rw(pid_t pid,
 	if (flags != 0)
 		return -EINVAL;
 
-	rc = compat_import_iovec(dir, lvec, liovcnt, UIO_FASTIOV, &iov_l, &iter_l);
-	if (rc < 0)
-		return rc;
-	if (!iov_iter_count(&iter_l))
-		goto free_iovecs;
-	rc = compat_import_iovec(0, rvec, riovcnt, UIO_FASTIOV, &iov_r, &iter_r);
-	if (rc <= 0)
-		goto free_iovecs;
-
-	rc = process_vm_rw_core(pid, &iter_l, iter_r.iov, iter_r.nr_segs,
-				flags, vm_write);
+	iov_l = compat_iovec_import(dir, lvec, liovcnt, &cache_l, &iter_l);
+	if (IS_ERR(iov_l))
+		return PTR_ERR(iov_l);
+	if (!iov_iter_count(&iter_l)) {
+		rc = 0;
+		goto free_iovec_l;
+	}
 
-free_iovecs:
-	if (iov_r != iovstack_r)
+	iov_r = compat_iovec_import(0, rvec, riovcnt, &cache_r, &iter_r);
+	if (IS_ERR(iov_r)) {
+		rc = PTR_ERR(iov_r);
+	} else {
+		rc = process_vm_rw_core(pid, &iter_l, iter_r.iov,
+				iter_r.nr_segs, flags, vm_write);
 		kfree(iov_r);
-	if (iov_l != iovstack_l)
-		kfree(iov_l);
+	}
+
+free_iovec_l:
+	kfree(iov_l);
 	return rc;
 }
 
-- 
1.8.1.2

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

