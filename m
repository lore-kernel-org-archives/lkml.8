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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550AAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F6A620724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0f174T9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732483AbgFWLrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732245AbgFWLrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:47:15 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271A2C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 04:47:15 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b5so9747558pgm.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 04:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pDMz4GEEd1HrNqab3SFEgh4HTzshHqZlUT8h2DVo/0o=;
        b=O0f174T9zxECMIrMcBnJlVgKJZ6AF1eadIxgibscZl51LZvB8RJvrqMkRvOifJ1CI8
         /NW27eFVBws4khf4Q2qK+/MggUcJwyAOfD1inExGIsaCdqPgaVcQI/lpgDRKhxW6DZ4c
         vHpAdYOFKt4Tw7nffVPHnQteL/omtnCI9D+PU6xJ/l+qW4gpxQVfVzLKgBp51y/iJeLb
         BhsNyPZiZimDHSuuF9JYkugBfFBkWTtmpsgF/s45n0Xfpkd5lBZaZNND2x/AZ06mD0dl
         fYUJBBGM0VrP/I2mSStcI2uddjS2oYMSuuaGhwQ3LJS5m1Stcz2Fnc79koTI+ITuoj4q
         Wxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pDMz4GEEd1HrNqab3SFEgh4HTzshHqZlUT8h2DVo/0o=;
        b=Wd9/KfgvmXSGwsPf+bjrGaTU+a/gKjqBjfPEUxRrDyGN1OYFRupunHm4M0vmJyr4Ph
         wfs5CD7mD+il1gprfWRnt3mhyP9QNKVPHdBlPxGBJxsLkBz19pFAzFTiScwdzInTh1Og
         LJIUcv8SCtVzFSJfaCcm8vRcp3onzlS35Vt7oYKNbZXxoRQgDNYK7thqHlV0x+03Eftx
         GC3dYKEX6QEZ5MpP888W0J9YCfrqn8of2g43SyYy6ujLE/QKbvK8RavNwoA7osPqHR7p
         z6MMUqxzNwIgTjVETK3zYqytR2F5hh74y5cscDvIaJqQdDlN8MCh7pGznoi6LPrrqr9H
         wt+Q==
X-Gm-Message-State: AOAM5322sjQZgiyWae9elkMHustrqULbW2niwpS9QS5ig2TI8JBYYXw9
        3c2vXqbVHMCddPKhF/+8npU=
X-Google-Smtp-Source: ABdhPJyoqH2qE0gyMJuzujXPkfwbJMIuJEyJhbRiulWkylIrNAE8lewKA/I7Fqiq7o7Uu7FIu8YohA==
X-Received: by 2002:a63:6643:: with SMTP id a64mr14118116pgc.246.1592912834633;
        Tue, 23 Jun 2020 04:47:14 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.179.62.127])
        by smtp.gmail.com with ESMTPSA id w203sm6828258pfc.128.2020.06.23.04.47.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2020 04:47:13 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     jgross@suse.com, boris.ostrovsky@oracle.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [RFC PATCH v2] xen/privcmd: Convert get_user_pages*() to pin_user_pages*()
Date:   Tue, 23 Jun 2020 17:25:28 +0530
Message-Id: <1592913328-15486-1-git-send-email-jrdr.linux@gmail.com>
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
 drivers/xen/privcmd.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index a250d11..eea90cd 100644
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
@@ -613,11 +618,7 @@ static void unlock_pages(struct page *pages[], unsigned int nr_pages)
 
 	if (!pages)
 		return;
-
-	for (i = 0; i < nr_pages; i++) {
-		if (pages[i])
-			put_page(pages[i]);
-	}
+	unpin_user_pages_dirty_lock(pages, nr_pages, 1);
 }
 
 static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
@@ -630,6 +631,7 @@ static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
 	struct xen_dm_op_buf *xbufs = NULL;
 	unsigned int i;
 	long rc;
+	int errno = 0;
 
 	if (copy_from_user(&kdata, udata, sizeof(kdata)))
 		return -EFAULT;
@@ -683,9 +685,12 @@ static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
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

