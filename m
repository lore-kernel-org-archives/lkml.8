Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43266C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF1C20784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbgCaNv5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:51:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:21130 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730932AbgCaNv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:51:56 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-3-9pj3e-AOPTeJpB1kh0EHVw-1; Tue, 31 Mar 2020 14:51:51 +0100
X-MC-Unique: 9pj3e-AOPTeJpB1kh0EHVw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 31 Mar 2020 14:51:51 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 31 Mar 2020 14:51:51 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 03/12] fs: Move rw_copy_check_uvector() into
 lib/iov_iter.c and make static.
Thread-Topic: [RFC PATCH 03/12] fs: Move rw_copy_check_uvector() into
 lib/iov_iter.c and make static.
Thread-Index: AdYHYXyfFOA8C1+qTDGwDlT1PXM6rA==
Date:   Tue, 31 Mar 2020 13:51:51 +0000
Message-ID: <7cf3e62a13c943f99d8915024925a15f@AcuMS.aculab.com>
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

This lets the compiler inline it into import_iovec() generating
much better code.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 fs/read_write.c        | 179 -------------------------------------------------
 include/linux/compat.h |   6 --
 include/linux/fs.h     |   5 --
 lib/iov_iter.c         | 178 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 178 insertions(+), 190 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 59d819c..a6f914c 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -732,185 +732,6 @@ static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
 	return ret;
 }
 
-/**
- * rw_copy_check_uvector() - Copy an array of &struct iovec from userspace
- *     into the kernel and check that it is valid.
- *
- * @type: One of %CHECK_IOVEC_ONLY, %READ, or %WRITE.
- * @uvector: Pointer to the userspace array.
- * @nr_segs: Number of elements in userspace array.
- * @fast_segs: Number of elements in @fast_pointer.
- * @fast_pointer: Pointer to (usually small on-stack) kernel array.
- * @ret_pointer: (output parameter) Pointer to a variable that will point to
- *     either @fast_pointer, a newly allocated kernel array, or NULL,
- *     depending on which array was used.
- *
- * This function copies an array of &struct iovec of @nr_segs from
- * userspace into the kernel and checks that each element is valid (e.g.
- * it does not point to a kernel address or cause overflow by being too
- * large, etc.).
- *
- * As an optimization, the caller may provide a pointer to a small
- * on-stack array in @fast_pointer, typically %UIO_FASTIOV elements long
- * (the size of this array, or 0 if unused, should be given in @fast_segs).
- *
- * @ret_pointer will always point to the array that was used, so the
- * caller must take care not to call kfree() on it e.g. in case the
- * @fast_pointer array was used and it was allocated on the stack.
- *
- * Return: The total number of bytes covered by the iovec array on success
- *   or a negative error code on error.
- */
-ssize_t rw_copy_check_uvector(int type, const struct iovec __user * uvector,
-			      unsigned long nr_segs, unsigned long fast_segs,
-			      struct iovec *fast_pointer,
-			      struct iovec **ret_pointer)
-{
-	unsigned long seg;
-	ssize_t ret;
-	struct iovec *iov = fast_pointer;
-
-	/*
-	 * SuS says "The readv() function *may* fail if the iovcnt argument
-	 * was less than or equal to 0, or greater than {IOV_MAX}.  Linux has
-	 * traditionally returned zero for zero segments, so...
-	 */
-	if (nr_segs == 0) {
-		ret = 0;
-		goto out;
-	}
-
-	/*
-	 * First get the "struct iovec" from user memory and
-	 * verify all the pointers
-	 */
-	if (nr_segs > UIO_MAXIOV) {
-		ret = -EINVAL;
-		goto out;
-	}
-	if (nr_segs > fast_segs) {
-		iov = kmalloc_array(nr_segs, sizeof(struct iovec), GFP_KERNEL);
-		if (iov == NULL) {
-			ret = -ENOMEM;
-			goto out;
-		}
-	}
-	if (copy_from_user(iov, uvector, nr_segs*sizeof(*uvector))) {
-		ret = -EFAULT;
-		goto out;
-	}
-
-	/*
-	 * According to the Single Unix Specification we should return EINVAL
-	 * if an element length is < 0 when cast to ssize_t or if the
-	 * total length would overflow the ssize_t return value of the
-	 * system call.
-	 *
-	 * Linux caps all read/write calls to MAX_RW_COUNT, and avoids the
-	 * overflow case.
-	 */
-	ret = 0;
-	for (seg = 0; seg < nr_segs; seg++) {
-		void __user *buf = iov[seg].iov_base;
-		ssize_t len = (ssize_t)iov[seg].iov_len;
-
-		/* see if we we're about to use an invalid len or if
-		 * it's about to overflow ssize_t */
-		if (len < 0) {
-			ret = -EINVAL;
-			goto out;
-		}
-		if (type >= 0
-		    && unlikely(!access_ok(buf, len))) {
-			ret = -EFAULT;
-			goto out;
-		}
-		if (len > MAX_RW_COUNT - ret) {
-			len = MAX_RW_COUNT - ret;
-			iov[seg].iov_len = len;
-		}
-		ret += len;
-	}
-out:
-	*ret_pointer = iov;
-	return ret;
-}
-
-#ifdef CONFIG_COMPAT
-ssize_t compat_rw_copy_check_uvector(int type,
-		const struct compat_iovec __user *uvector, unsigned long nr_segs,
-		unsigned long fast_segs, struct iovec *fast_pointer,
-		struct iovec **ret_pointer)
-{
-	compat_ssize_t tot_len;
-	struct iovec *iov = *ret_pointer = fast_pointer;
-	ssize_t ret = 0;
-	int seg;
-
-	/*
-	 * SuS says "The readv() function *may* fail if the iovcnt argument
-	 * was less than or equal to 0, or greater than {IOV_MAX}.  Linux has
-	 * traditionally returned zero for zero segments, so...
-	 */
-	if (nr_segs == 0)
-		goto out;
-
-	ret = -EINVAL;
-	if (nr_segs > UIO_MAXIOV)
-		goto out;
-	if (nr_segs > fast_segs) {
-		ret = -ENOMEM;
-		iov = kmalloc_array(nr_segs, sizeof(struct iovec), GFP_KERNEL);
-		if (iov == NULL)
-			goto out;
-	}
-	*ret_pointer = iov;
-
-	ret = -EFAULT;
-	if (!access_ok(uvector, nr_segs*sizeof(*uvector)))
-		goto out;
-
-	/*
-	 * Single unix specification:
-	 * We should -EINVAL if an element length is not >= 0 and fitting an
-	 * ssize_t.
-	 *
-	 * In Linux, the total length is limited to MAX_RW_COUNT, there is
-	 * no overflow possibility.
-	 */
-	tot_len = 0;
-	ret = -EINVAL;
-	for (seg = 0; seg < nr_segs; seg++) {
-		compat_uptr_t buf;
-		compat_ssize_t len;
-
-		if (__get_user(len, &uvector->iov_len) ||
-		   __get_user(buf, &uvector->iov_base)) {
-			ret = -EFAULT;
-			goto out;
-		}
-		if (len < 0)	/* size_t not fitting in compat_ssize_t .. */
-			goto out;
-		if (type >= 0 &&
-		    !access_ok(compat_ptr(buf), len)) {
-			ret = -EFAULT;
-			goto out;
-		}
-		if (len > MAX_RW_COUNT - tot_len)
-			len = MAX_RW_COUNT - tot_len;
-		tot_len += len;
-		iov->iov_base = compat_ptr(buf);
-		iov->iov_len = (compat_size_t) len;
-		uvector++;
-		iov++;
-	}
-	ret = tot_len;
-
-out:
-	return ret;
-}
-#endif
-
 static ssize_t do_iter_read(struct file *file, struct iov_iter *iter,
 		loff_t *pos, rwf_t flags)
 {
diff --git a/include/linux/compat.h b/include/linux/compat.h
index df2475b..c161507 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -444,12 +444,6 @@ extern long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 struct epoll_event;	/* fortunately, this one is fixed-layout */
 
-extern ssize_t compat_rw_copy_check_uvector(int type,
-		const struct compat_iovec __user *uvector,
-		unsigned long nr_segs,
-		unsigned long fast_segs, struct iovec *fast_pointer,
-		struct iovec **ret_pointer);
-
 extern void __user *compat_alloc_user_space(unsigned long len);
 
 int compat_restore_altstack(const compat_stack_t __user *uss);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index abedbff..c7335a1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1907,11 +1907,6 @@ static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
 	return file->f_op->mmap(file, vma);
 }
 
-ssize_t rw_copy_check_uvector(int type, const struct iovec __user * uvector,
-			      unsigned long nr_segs, unsigned long fast_segs,
-			      struct iovec *fast_pointer,
-			      struct iovec **ret_pointer);
-
 extern ssize_t __vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 51595bf..d8bc770 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1648,6 +1648,111 @@ const void *dup_iter(struct iov_iter *new, struct iov_iter *old, gfp_t flags)
 }
 EXPORT_SYMBOL(dup_iter);
 
+
+/**
+ * rw_copy_check_uvector() - Copy an array of &struct iovec from userspace
+ *     into the kernel and check that it is valid.
+ *
+ * @type: One of %CHECK_IOVEC_ONLY, %READ, or %WRITE.
+ * @uvector: Pointer to the userspace array.
+ * @nr_segs: Number of elements in userspace array.
+ * @fast_segs: Number of elements in @fast_pointer.
+ * @fast_pointer: Pointer to (usually small on-stack) kernel array.
+ * @ret_pointer: (output parameter) Pointer to a variable that will point to
+ *     either @fast_pointer, a newly allocated kernel array, or NULL,
+ *     depending on which array was used.
+ *
+ * This function copies an array of &struct iovec of @nr_segs from
+ * userspace into the kernel and checks that each element is valid (e.g.
+ * it does not point to a kernel address or cause overflow by being too
+ * large, etc.).
+ *
+ * As an optimization, the caller may provide a pointer to a small
+ * on-stack array in @fast_pointer, typically %UIO_FASTIOV elements long
+ * (the size of this array, or 0 if unused, should be given in @fast_segs).
+ *
+ * @ret_pointer will always point to the array that was used, so the
+ * caller must take care not to call kfree() on it e.g. in case the
+ * @fast_pointer array was used and it was allocated on the stack.
+ *
+ * Return: The total number of bytes covered by the iovec array on success
+ *   or a negative error code on error.
+ */
+static ssize_t rw_copy_check_uvector(int type, const struct iovec __user * uvector,
+			      unsigned long nr_segs, unsigned long fast_segs,
+			      struct iovec *fast_pointer,
+			      struct iovec **ret_pointer)
+{
+	unsigned long seg;
+	ssize_t ret;
+	struct iovec *iov = fast_pointer;
+
+	/*
+	 * SuS says "The readv() function *may* fail if the iovcnt argument
+	 * was less than or equal to 0, or greater than {IOV_MAX}.  Linux has
+	 * traditionally returned zero for zero segments, so...
+	 */
+	if (nr_segs == 0) {
+		ret = 0;
+		goto out;
+	}
+
+	/*
+	 * First get the "struct iovec" from user memory and
+	 * verify all the pointers
+	 */
+	if (nr_segs > UIO_MAXIOV) {
+		ret = -EINVAL;
+		goto out;
+	}
+	if (nr_segs > fast_segs) {
+		iov = kmalloc_array(nr_segs, sizeof(struct iovec), GFP_KERNEL);
+		if (iov == NULL) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+	if (copy_from_user(iov, uvector, nr_segs*sizeof(*uvector))) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	/*
+	 * According to the Single Unix Specification we should return EINVAL
+	 * if an element length is < 0 when cast to ssize_t or if the
+	 * total length would overflow the ssize_t return value of the
+	 * system call.
+	 *
+	 * Linux caps all read/write calls to MAX_RW_COUNT, and avoids the
+	 * overflow case.
+	 */
+	ret = 0;
+	for (seg = 0; seg < nr_segs; seg++) {
+		void __user *buf = iov[seg].iov_base;
+		ssize_t len = (ssize_t)iov[seg].iov_len;
+
+		/* see if we we're about to use an invalid len or if
+		 * it's about to overflow ssize_t */
+		if (len < 0) {
+			ret = -EINVAL;
+			goto out;
+		}
+		if (type >= 0
+		    && unlikely(!access_ok(buf, len))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		if (len > MAX_RW_COUNT - ret) {
+			len = MAX_RW_COUNT - ret;
+			iov[seg].iov_len = len;
+		}
+		ret += len;
+	}
+out:
+	*ret_pointer = iov;
+	return ret;
+}
+
 /**
  * import_iovec() - Copy an array of &struct iovec from userspace
  *     into the kernel, check that it is valid, and initialize a new
@@ -1693,6 +1798,79 @@ ssize_t import_iovec(int type, const struct iovec __user * uvector,
 #ifdef CONFIG_COMPAT
 #include <linux/compat.h>
 
+static ssize_t compat_rw_copy_check_uvector(int type,
+		const struct compat_iovec __user *uvector, unsigned long nr_segs,
+		unsigned long fast_segs, struct iovec *fast_pointer,
+		struct iovec **ret_pointer)
+{
+	compat_ssize_t tot_len;
+	struct iovec *iov = *ret_pointer = fast_pointer;
+	ssize_t ret = 0;
+	int seg;
+
+	/*
+	 * SuS says "The readv() function *may* fail if the iovcnt argument
+	 * was less than or equal to 0, or greater than {IOV_MAX}.  Linux has
+	 * traditionally returned zero for zero segments, so...
+	 */
+	if (nr_segs == 0)
+		goto out;
+
+	ret = -EINVAL;
+	if (nr_segs > UIO_MAXIOV)
+		goto out;
+	if (nr_segs > fast_segs) {
+		ret = -ENOMEM;
+		iov = kmalloc_array(nr_segs, sizeof(struct iovec), GFP_KERNEL);
+		if (iov == NULL)
+			goto out;
+	}
+	*ret_pointer = iov;
+
+	ret = -EFAULT;
+	if (!access_ok(uvector, nr_segs*sizeof(*uvector)))
+		goto out;
+
+	/*
+	 * Single unix specification:
+	 * We should -EINVAL if an element length is not >= 0 and fitting an
+	 * ssize_t.
+	 *
+	 * In Linux, the total length is limited to MAX_RW_COUNT, there is
+	 * no overflow possibility.
+	 */
+	tot_len = 0;
+	ret = -EINVAL;
+	for (seg = 0; seg < nr_segs; seg++) {
+		compat_uptr_t buf;
+		compat_ssize_t len;
+
+		if (__get_user(len, &uvector->iov_len) ||
+		   __get_user(buf, &uvector->iov_base)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		if (len < 0)	/* size_t not fitting in compat_ssize_t .. */
+			goto out;
+		if (type >= 0 &&
+		    !access_ok(compat_ptr(buf), len)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		if (len > MAX_RW_COUNT - tot_len)
+			len = MAX_RW_COUNT - tot_len;
+		tot_len += len;
+		iov->iov_base = compat_ptr(buf);
+		iov->iov_len = (compat_size_t) len;
+		uvector++;
+		iov++;
+	}
+	ret = tot_len;
+
+out:
+	return ret;
+}
+
 ssize_t compat_import_iovec(int type,
 		const struct compat_iovec __user * uvector,
 		unsigned nr_segs, unsigned fast_segs,
-- 
1.8.1.2

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

