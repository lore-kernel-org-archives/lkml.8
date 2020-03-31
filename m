Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20745C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3DA20784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbgCaNwX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:52:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:46729 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731097AbgCaNwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:52:21 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-143-CV1vAavVOfKGO2gQPAvgMg-1; Tue, 31 Mar 2020 14:52:16 +0100
X-MC-Unique: CV1vAavVOfKGO2gQPAvgMg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 31 Mar 2020 14:52:16 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 31 Mar 2020 14:52:16 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 09/12] fs: Use iovec_import() instead of import_iovec().
Thread-Topic: [RFC PATCH 09/12] fs: Use iovec_import() instead of
 import_iovec().
Thread-Index: AdYHYu6Jf/b+zzsyTDSOH29HTRD1CA==
Date:   Tue, 31 Mar 2020 13:52:16 +0000
Message-ID: <a83ce4e3038a483dacb028c2f938d8c0@AcuMS.aculab.com>
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
 fs/aio.c        | 34 +++++++++++++---------------
 fs/read_write.c | 69 +++++++++++++++++++++++++++++++--------------------------
 fs/splice.c     | 22 +++++++++---------
 3 files changed, 65 insertions(+), 60 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 5f3d3d8..15dc2e3 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1477,24 +1477,20 @@ static int aio_prep_rw(struct kiocb *req, const struct iocb *iocb)
 	return 0;
 }
 
-static ssize_t aio_setup_rw(int rw, const struct iocb *iocb,
-		struct iovec **iovec, bool vectored, bool compat,
+static struct iovec *aio_setup_rw(int rw, const struct iocb *iocb,
+		struct iovec_cache *cache, bool vectored, bool compat,
 		struct iov_iter *iter)
 {
 	void __user *buf = (void __user *)(uintptr_t)iocb->aio_buf;
 	size_t len = iocb->aio_nbytes;
 
-	if (!vectored) {
-		ssize_t ret = import_single_range(rw, buf, len, *iovec, iter);
-		*iovec = NULL;
-		return ret;
-	}
+	if (!vectored)
+		return ERR_PTR(import_single_range(rw, buf, len, cache->iov, iter));
 #ifdef CONFIG_COMPAT
 	if (compat)
-		return compat_import_iovec(rw, buf, len, UIO_FASTIOV, iovec,
-				iter);
+		return compat_iovec_import(rw, buf, len, cache, iter);
 #endif
-	return import_iovec(rw, buf, len, UIO_FASTIOV, iovec, iter);
+	return iovec_import(rw, buf, len, cache, iter);
 }
 
 static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
@@ -1520,8 +1516,9 @@ static inline void aio_rw_done(struct kiocb *req, ssize_t ret)
 static int aio_read(struct kiocb *req, const struct iocb *iocb,
 			bool vectored, bool compat)
 {
-	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
+	struct iovec_cache cache;
 	struct iov_iter iter;
+	struct iovec *iovec;
 	struct file *file;
 	int ret;
 
@@ -1535,9 +1532,9 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
 	if (unlikely(!file->f_op->read_iter))
 		return -EINVAL;
 
-	ret = aio_setup_rw(READ, iocb, &iovec, vectored, compat, &iter);
-	if (ret < 0)
-		return ret;
+	iovec = aio_setup_rw(READ, iocb, &cache, vectored, compat, &iter);
+	if (IS_ERR(iovec))
+		return PTR_ERR(iovec);
 	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret)
 		aio_rw_done(req, call_read_iter(file, req, &iter));
@@ -1548,8 +1545,9 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
 static int aio_write(struct kiocb *req, const struct iocb *iocb,
 			 bool vectored, bool compat)
 {
-	struct iovec inline_vecs[UIO_FASTIOV], *iovec = inline_vecs;
+	struct iovec_cache cache;
 	struct iov_iter iter;
+	struct iovec *iovec;
 	struct file *file;
 	int ret;
 
@@ -1563,9 +1561,9 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 	if (unlikely(!file->f_op->write_iter))
 		return -EINVAL;
 
-	ret = aio_setup_rw(WRITE, iocb, &iovec, vectored, compat, &iter);
-	if (ret < 0)
-		return ret;
+	iovec = aio_setup_rw(WRITE, iocb, &cache, vectored, compat, &iter);
+	if (IS_ERR(iovec))
+		return PTR_ERR(iovec);
 	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret) {
 		/*
diff --git a/fs/read_write.c b/fs/read_write.c
index a6f914c..5713032 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -864,35 +864,38 @@ ssize_t vfs_iter_write(struct file *file, struct iov_iter *iter, loff_t *ppos,
 ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
 		  unsigned long vlen, loff_t *pos, rwf_t flags)
 {
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov = iovstack;
+	struct iovec_cache cache;
 	struct iov_iter iter;
+	struct iovec *iov;
 	ssize_t ret;
 
-	ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
-	if (ret >= 0) {
-		ret = do_iter_read(file, &iter, pos, flags);
-		kfree(iov);
-	}
+	iov = iovec_import(READ, vec, vlen, &cache, &iter);
+	if (IS_ERR(iov))
+		return PTR_ERR(iov);
+
+	ret = do_iter_read(file, &iter, pos, flags);
 
+	kfree(iov);
 	return ret;
 }
 
 static ssize_t vfs_writev(struct file *file, const struct iovec __user *vec,
 		   unsigned long vlen, loff_t *pos, rwf_t flags)
 {
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov = iovstack;
+	struct iovec_cache cache;
 	struct iov_iter iter;
+	struct iovec *iov;
 	ssize_t ret;
 
-	ret = import_iovec(WRITE, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
-	if (ret >= 0) {
-		file_start_write(file);
-		ret = do_iter_write(file, &iter, pos, flags);
-		file_end_write(file);
-		kfree(iov);
-	}
+	iov = iovec_import(WRITE, vec, vlen, &cache, &iter);
+	if (IS_ERR(iov))
+		return PTR_ERR(iov);
+
+	file_start_write(file);
+	ret = do_iter_write(file, &iter, pos, flags);
+	file_end_write(file);
+
+	kfree(iov);
 	return ret;
 }
 
@@ -1053,16 +1056,17 @@ static size_t compat_readv(struct file *file,
 			   const struct compat_iovec __user *vec,
 			   unsigned long vlen, loff_t *pos, rwf_t flags)
 {
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov = iovstack;
+	struct iovec_cache cache;
 	struct iov_iter iter;
+	struct iovec *iov;
 	ssize_t ret;
 
-	ret = compat_import_iovec(READ, vec, vlen, UIO_FASTIOV, &iov, &iter);
-	if (ret >= 0) {
-		ret = do_iter_read(file, &iter, pos, flags);
-		kfree(iov);
-	}
+	iov = compat_iovec_import(READ, vec, vlen, &cache, &iter);
+	if (IS_ERR(iov))
+		return PTR_ERR(iov);
+
+	ret = do_iter_read(file, &iter, pos, flags);
+	kfree(iov);
 	if (ret > 0)
 		add_rchar(current, ret);
 	inc_syscr(current);
@@ -1161,18 +1165,19 @@ static size_t compat_writev(struct file *file,
 			    const struct compat_iovec __user *vec,
 			    unsigned long vlen, loff_t *pos, rwf_t flags)
 {
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov = iovstack;
+	struct iovec_cache cache;
 	struct iov_iter iter;
+	struct iovec *iov;
 	ssize_t ret;
 
-	ret = compat_import_iovec(WRITE, vec, vlen, UIO_FASTIOV, &iov, &iter);
-	if (ret >= 0) {
-		file_start_write(file);
-		ret = do_iter_write(file, &iter, pos, flags);
-		file_end_write(file);
-		kfree(iov);
-	}
+	iov = compat_iovec_import(WRITE, vec, vlen, &cache, &iter);
+	if (IS_ERR(iov))
+		return PTR_ERR(iov);
+
+	file_start_write(file);
+	ret = do_iter_write(file, &iter, pos, flags);
+	file_end_write(file);
+	kfree(iov);
 	if (ret > 0)
 		add_wchar(current, ret);
 	inc_syscw(current);
diff --git a/fs/splice.c b/fs/splice.c
index d671936..444c80d 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1375,9 +1375,9 @@ static long do_vmsplice(struct file *f, struct iov_iter *iter, unsigned int flag
 SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, uiov,
 		unsigned long, nr_segs, unsigned int, flags)
 {
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov = iovstack;
+	struct iovec_cache cache;
 	struct iov_iter iter;
+	struct iovec *iov;
 	ssize_t error;
 	struct fd f;
 	int type;
@@ -1387,9 +1387,10 @@ static long do_vmsplice(struct file *f, struct iov_iter *iter, unsigned int flag
 	if (error)
 		return error;
 
-	error = import_iovec(type, uiov, nr_segs,
-			     ARRAY_SIZE(iovstack), &iov, &iter);
-	if (error >= 0) {
+	iov = iovec_import(type, uiov, nr_segs, &cache, &iter);
+	if (IS_ERR(iov)) {
+		error = PTR_ERR(iov);
+	} else {
 		error = do_vmsplice(f.file, &iter, flags);
 		kfree(iov);
 	}
@@ -1401,9 +1402,9 @@ static long do_vmsplice(struct file *f, struct iov_iter *iter, unsigned int flag
 COMPAT_SYSCALL_DEFINE4(vmsplice, int, fd, const struct compat_iovec __user *, iov32,
 		    unsigned int, nr_segs, unsigned int, flags)
 {
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov = iovstack;
+	struct iovec_cache cache;
 	struct iov_iter iter;
+	struct iovec *iov;
 	ssize_t error;
 	struct fd f;
 	int type;
@@ -1413,9 +1414,10 @@ static long do_vmsplice(struct file *f, struct iov_iter *iter, unsigned int flag
 	if (error)
 		return error;
 
-	error = compat_import_iovec(type, iov32, nr_segs,
-			     ARRAY_SIZE(iovstack), &iov, &iter);
-	if (error >= 0) {
+	iov = compat_iovec_import(type, iov32, nr_segs, &cache, &iter);
+	if (IS_ERR(iov)) {
+		error = PTR_ERR(iov);
+	} else {
 		error = do_vmsplice(f.file, &iter, flags);
 		kfree(iov);
 	}
-- 
1.8.1.2

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

