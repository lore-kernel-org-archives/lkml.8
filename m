Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E50C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7855520774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MppwvfZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732571AbgFWLt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732420AbgFWLt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:49:58 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB19C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 04:49:58 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k6so9013398pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 04:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=70/IVEhJ02HvpdsdNd9PlWVOivEwQQMsYQTKyuJVw5w=;
        b=MppwvfZJn8ecf5EIZhuRbEQ8l3NLLdTBNC06snahwn8RnuLn37zTW3Xh1tgQBJu5Vt
         zZyxaozNnvbmbkJvjzRixuvhZtfr9BzypqeE7l/aJ6+mEpn+h5IJNmHFc6l0ee/FvwOI
         Bl7TfpCpdRUnxhNvJmSg5FqkwoCFnVEYKOMeoe4LE1sLzSHyQqXCwHUCpL38FDtoPAOh
         E0mzT9Toou2nx99Ka5OdaBLolD3f2E9ypbp04kqP1nUuCWYyUKkhv/38fkxmjhwbUb0b
         pvjqBWy8ekO5F4RnkOQutCDq2i7behQUQ7VGXx3Sx0N6fwI8lTypVzf2fMihGCmML3cx
         47wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=70/IVEhJ02HvpdsdNd9PlWVOivEwQQMsYQTKyuJVw5w=;
        b=iK1151WXiWNShtujGIANoXVP7sIzdFCUS90uaB2T3MkMFpSpGg0xna5WuRA3ItweFD
         5WkFtXZDyYFQyqvFUoxc+/MxnXgQaZbOmoI61kwMOYWu/XHv9lsWm/jKPmXwrbnjMG7Z
         xkzhB8ZPdwrFXLn6IYZQLIFPo4UxiHKDYgLPvb1mEYoaklmcLz9oV+uzkr5vHAZguu2x
         Fe0iQBkJnTfxWQMOobJvZo/jXh4J11OVi73hpQyePDDyWqDdAQ3gawtJ/A0nYJBtzmAd
         nkoT7RNGHquJuho5m21mJL9ZQ7lK+IZ0mRqVQKhtYlpGuiPgH0ySBI+taos5Q29mFJDK
         WJCA==
X-Gm-Message-State: AOAM530Igt98/U8c9LRCN0uG8KhkIKDuBp/oMTXEoz7b1sdOrLt4NH3B
        HU1vEJYfaXAJXGVvzJqiEFA=
X-Google-Smtp-Source: ABdhPJyStVCImaOd+pzTqmM89EzcHfoa9xSYUzHKMG+nb3a6hRmdLRowoxq6o0VzoGGzLOSJsnRG7w==
X-Received: by 2002:a17:902:8b8a:: with SMTP id ay10mr10745807plb.235.1592912997980;
        Tue, 23 Jun 2020 04:49:57 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.179.62.127])
        by smtp.gmail.com with ESMTPSA id cm13sm2290720pjb.5.2020.06.23.04.49.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2020 04:49:57 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     jgross@suse.com, boris.ostrovsky@oracle.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [RFC PATCH v2] xen/privcmd: Convert get_user_pages*() to pin_user_pages*()
Date:   Tue, 23 Jun 2020 17:28:19 +0530
Message-Id: <1592913499-15558-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 2019, we introduced pin_user_pages*() and now we are converting
get_user_pages*() to the new API as appropriate. [1] & [2] could
be referred for more information. This is case 5 as per document [1].

As discussed, pages need to be marked as dirty before unpinned it.

Previously, if lock_pages() end up partially mapping pages, it used
to return -ERRNO due to which unlock_pages() have to go through
each pages[i] till *nr_pages* to validate them. This can be avoided
by passing correct number partially mapped pages & -ERRNO separately
while returning from lock_pages() due to error.
With this fix unlock_pages() doesn't need to validate pages[i] till
*nr_pages* for error scenario.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
        https://lwn.net/Articles/807108/

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/privcmd.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index a250d11..013d23b 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -580,25 +580,30 @@ static long privcmd_ioctl_mmap_batch(
 
 static int lock_pages(
 	struct privcmd_dm_op_buf kbufs[], unsigned int num,
-	struct page *pages[], unsigned int nr_pages)
+	struct page *pages[], unsigned int nr_pages, int *errno)
 {
 	unsigned int i;
+	int pinned = 0, rc = 0;
 
 	for (i = 0; i < num; i++) {
 		unsigned int requested;
-		int pinned;
 
+		rc += pinned;
 		requested = DIV_ROUND_UP(
 			offset_in_page(kbufs[i].uptr) + kbufs[i].size,
 			PAGE_SIZE);
-		if (requested > nr_pages)
-			return -ENOSPC;
+		if (requested > nr_pages) {
+			*errno = -ENOSPC;
+			return rc;
+		}
 
-		pinned = get_user_pages_fast(
+		pinned = pin_user_pages_fast(
 			(unsigned long) kbufs[i].uptr,
 			requested, FOLL_WRITE, pages);
-		if (pinned < 0)
-			return pinned;
+		if (pinned < 0) {
+			*errno = pinned;
+			return rc;
+		}
 
 		nr_pages -= pinned;
 		pages += pinned;
@@ -609,15 +614,10 @@ static int lock_pages(
 
 static void unlock_pages(struct page *pages[], unsigned int nr_pages)
 {
-	unsigned int i;
-
 	if (!pages)
 		return;
 
-	for (i = 0; i < nr_pages; i++) {
-		if (pages[i])
-			put_page(pages[i]);
-	}
+	unpin_user_pages_dirty_lock(pages, nr_pages, 1);
 }
 
 static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
@@ -630,6 +630,7 @@ static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
 	struct xen_dm_op_buf *xbufs = NULL;
 	unsigned int i;
 	long rc;
+	int errno = 0;
 
 	if (copy_from_user(&kdata, udata, sizeof(kdata)))
 		return -EFAULT;
@@ -683,9 +684,12 @@ static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
 		goto out;
 	}
 
-	rc = lock_pages(kbufs, kdata.num, pages, nr_pages);
-	if (rc)
+	rc = lock_pages(kbufs, kdata.num, pages, nr_pages, &errno);
+	if (errno < 0) {
+		nr_pages = rc;
+		rc = errno;
 		goto out;
+	}
 
 	for (i = 0; i < kdata.num; i++) {
 		set_xen_guest_handle(xbufs[i].h, kbufs[i].uptr);
-- 
1.9.1

