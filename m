Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73E6C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 03:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8863E2076D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 03:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJXHKUnE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgGLDbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 23:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgGLDbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 23:31:34 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BD7C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 20:31:34 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so4520641pgf.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 20:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aJSWgi0xiDq2TEjOwzrr33u9Kob9ua2/jtyaxeBw01I=;
        b=BJXHKUnEMD8COwDxple2uc80bG5s+/UbetrM7wV8qMA4W1AeaRkA1dUyAA+qm438vT
         Gy00Mc+YrUQxaq/DmQnTK1DFyC3H+fK0aLz6QNB/mvbhx4hZHMLc+AM+rAPjoq2VGf4k
         sTWacxWoTe8csdNCUsjNqLRQyLsgRh+itgowLckdvIv4Nqt2ooHoxOl3UtBKHxwHkPGa
         jgH0sN/FUstxj6s1MRpaEihCKLF7llJxium2YMebgjk+qKe3lORUerU1ZbCR0fNoAocG
         koPDJjKw+JGN2l7JqMyjXe2+sP64iRvf3HrcuZhNGqf+POiictvmNBqs9fI9orDMVJFq
         7KEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aJSWgi0xiDq2TEjOwzrr33u9Kob9ua2/jtyaxeBw01I=;
        b=ogo7ywgiyjlkUXXt+el6fWIGlS5tUeLn9INtDqU/Nf/1zt3Rse0enncjoZF1xgIBvS
         D6NKULVdgahjQUrfLowFRsZMqCvPRh5nQCK2f3dNWxwSzr7LdbBiSe/ddHjItsuDqzEA
         UiggIN/rzmwSkW3CDrPx69V+IhCtCWZHWqpLuvPN2aDugiXutMeo4rPLDGTuqwuFNLwD
         +Th+x+Tn5MOj+6Htkpm55xWws0A0l2xgxKSOvxfK0zBO+CNsEebj/Y7WX6F5a8nFA8Yu
         nqtbZnGz/I+hvIC6Lv3kpmG4WnCKea6Ps1Qg3pIjDck6fWdH800Jpol2UNAUWpYNdKKi
         y8Yg==
X-Gm-Message-State: AOAM5337nb1/hNHQ31REDucqLjoS9atALyYReWQu9uajbvfzVKkgj1aI
        5iikyPAP0DtMD46iFBFzejg=
X-Google-Smtp-Source: ABdhPJzGcosdIsNjTLJCw8K3Nj8FTvzS0ofcadybPbfYsTh6uAimwx5dECsp1E5FMwZE8E+TEIqYmw==
X-Received: by 2002:a63:dd4d:: with SMTP id g13mr63445998pgj.179.1594524693521;
        Sat, 11 Jul 2020 20:31:33 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.167.224.89])
        by smtp.gmail.com with ESMTPSA id s89sm9750271pjj.28.2020.07.11.20.31.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Jul 2020 20:31:32 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Paul Durrant <xadimgnik@gmail.com>
Subject: [PATCH v3 1/3] xen/privcmd: Corrected error handling path
Date:   Sun, 12 Jul 2020 09:09:53 +0530
Message-Id: <1594525195-28345-2-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1594525195-28345-1-git-send-email-jrdr.linux@gmail.com>
References: <1594525195-28345-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, if lock_pages() end up partially mapping pages, it used
to return -ERRNO due to which unlock_pages() have to go through
each pages[i] till *nr_pages* to validate them. This can be avoided
by passing correct number of partially mapped pages & -ERRNO separately,
while returning from lock_pages() due to error.

With this fix unlock_pages() doesn't need to validate pages[i] till
*nr_pages* for error scenario and few condition checks can be ignored.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Paul Durrant <xadimgnik@gmail.com>
---
 drivers/xen/privcmd.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 5dfc59f..b001673 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -579,13 +579,13 @@ static long privcmd_ioctl_mmap_batch(
 
 static int lock_pages(
 	struct privcmd_dm_op_buf kbufs[], unsigned int num,
-	struct page *pages[], unsigned int nr_pages)
+	struct page *pages[], unsigned int nr_pages, unsigned int *pinned)
 {
 	unsigned int i;
 
 	for (i = 0; i < num; i++) {
 		unsigned int requested;
-		int pinned;
+		int page_count;
 
 		requested = DIV_ROUND_UP(
 			offset_in_page(kbufs[i].uptr) + kbufs[i].size,
@@ -593,14 +593,15 @@ static int lock_pages(
 		if (requested > nr_pages)
 			return -ENOSPC;
 
-		pinned = get_user_pages_fast(
+		page_count = get_user_pages_fast(
 			(unsigned long) kbufs[i].uptr,
 			requested, FOLL_WRITE, pages);
-		if (pinned < 0)
-			return pinned;
+		if (page_count < 0)
+			return page_count;
 
-		nr_pages -= pinned;
-		pages += pinned;
+		*pinned += page_count;
+		nr_pages -= page_count;
+		pages += page_count;
 	}
 
 	return 0;
@@ -610,13 +611,8 @@ static void unlock_pages(struct page *pages[], unsigned int nr_pages)
 {
 	unsigned int i;
 
-	if (!pages)
-		return;
-
-	for (i = 0; i < nr_pages; i++) {
-		if (pages[i])
-			put_page(pages[i]);
-	}
+	for (i = 0; i < nr_pages; i++)
+		put_page(pages[i]);
 }
 
 static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
@@ -629,6 +625,7 @@ static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
 	struct xen_dm_op_buf *xbufs = NULL;
 	unsigned int i;
 	long rc;
+	unsigned int pinned = 0;
 
 	if (copy_from_user(&kdata, udata, sizeof(kdata)))
 		return -EFAULT;
@@ -682,9 +679,11 @@ static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
 		goto out;
 	}
 
-	rc = lock_pages(kbufs, kdata.num, pages, nr_pages);
-	if (rc)
+	rc = lock_pages(kbufs, kdata.num, pages, nr_pages, &pinned);
+	if (rc < 0) {
+		nr_pages = pinned;
 		goto out;
+	}
 
 	for (i = 0; i < kdata.num; i++) {
 		set_xen_guest_handle(xbufs[i].h, kbufs[i].uptr);
-- 
1.9.1

