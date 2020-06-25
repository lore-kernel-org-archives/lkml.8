Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA83C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 02:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A843C20789
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 02:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGJIN5xG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389617AbgFYCyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 22:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389357AbgFYCyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 22:54:52 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540D6C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 19:54:51 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so2583666pge.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 19:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fAhw99hSHSp4oWrS0namYNm6Go3NsuSaLTMdS2js2yg=;
        b=tGJIN5xGsgN1is4VPvkWyDq1pQcJK/f4mEt+aWjJHg7bZ3RJcDogKlmQ0OSbuVj4dk
         m8f1/44VpRJ3kiSvogq4WXlZ3AY6U2bU3iwIhwsi9/432OcHSqoK785PT1o24waKPk3y
         JkpBWrh9BmojPyt6eC9QUQqiXQK5t8N4VSGy8DmuPGEt9bR/ONK3zzbAggeOqH7PR7UW
         TlCDWeZoRDnx4wuJN4Y2p4v0QoXAKAgzmw1+ZZV1tyk93pdcs1CcjpKikxhpATOSO5Lc
         RsNnXAUUon3g9H+ZafgA/DX3BsvOxBOIRnnzmEgwjDKYQudXSSRn33PYSWi6eyNCcZWx
         whGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fAhw99hSHSp4oWrS0namYNm6Go3NsuSaLTMdS2js2yg=;
        b=tImNQCHoSM+o05vGvFn1d36AP1eFAnIKe9wxDEP52yWMtzmYC3UfXptfkRDCJ79YVF
         BPFx//nUKPXjqX00541T8l6ec7ptQTfqiug1smRWAXYvFXGgv6dBodQgLNnKZmEZwE32
         bIes8gT0lOftiTtpSzTS0c0L6pLcpea2AD8Nc42J9k3M8RffZ0aPF1QUd1FOKporW7eD
         C59Ym+BoyGv8FZsQtEHRlEcWPHCAhzcOHC23aZvpZ5tRoMi3pLpfrO/xVrZ9vWNncHL1
         QIAMH4lejHevAqEkzObB41lxig55FePFGe1gnPx8Mk66AIoOH22t1UjjPcbZvEe7ucU1
         AFuQ==
X-Gm-Message-State: AOAM533e0elF7r7heEuHJuRPjWdRKHpLGJT76WxbmnrN2PrrTunLwkHC
        mLE9NQnZEGKWP3Jk1/DLz9WOyovp17w=
X-Google-Smtp-Source: ABdhPJypIwr6XPQgemt6CJF4aVOuSE9P8rFDuFGhKBDr+zcFrzEKlnZEEU3wYydNz5mYaZJaYnAkvg==
X-Received: by 2002:a63:de18:: with SMTP id f24mr23694179pgg.415.1593053690835;
        Wed, 24 Jun 2020 19:54:50 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.182.254.114])
        by smtp.gmail.com with ESMTPSA id y10sm18593000pgi.54.2020.06.24.19.54.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jun 2020 19:54:50 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Paul Durrant <xadimgnik@gmail.com>
Subject: [PATCH 1/2] xen/privcmd: Corrected error handling path and mark pages dirty
Date:   Thu, 25 Jun 2020 08:32:39 +0530
Message-Id: <1593054160-12628-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
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

As discussed, pages need to be marked as dirty before unpinned it in
unlock_pages() which was oversight.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Paul Durrant <xadimgnik@gmail.com>
---
Hi,

I'm compile tested this, but unable to run-time test, so any testing
help is much appriciated.

 drivers/xen/privcmd.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index a250d11..0da417c 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -580,43 +580,44 @@ static long privcmd_ioctl_mmap_batch(
 
 static int lock_pages(
 	struct privcmd_dm_op_buf kbufs[], unsigned int num,
-	struct page *pages[], unsigned int nr_pages)
+	struct page *pages[], unsigned int nr_pages, int *pinned)
 {
 	unsigned int i;
+	int errno = 0, page_count = 0;
 
 	for (i = 0; i < num; i++) {
 		unsigned int requested;
-		int pinned;
 
+		*pinned += page_count;
 		requested = DIV_ROUND_UP(
 			offset_in_page(kbufs[i].uptr) + kbufs[i].size,
 			PAGE_SIZE);
 		if (requested > nr_pages)
 			return -ENOSPC;
 
-		pinned = get_user_pages_fast(
+		page_count = get_user_pages_fast(
 			(unsigned long) kbufs[i].uptr,
 			requested, FOLL_WRITE, pages);
-		if (pinned < 0)
-			return pinned;
+		if (page_count < 0) {
+			errno = page_count;
+			return errno;
+		}
 
-		nr_pages -= pinned;
-		pages += pinned;
+		nr_pages -= page_count;
+		pages += page_count;
 	}
 
-	return 0;
+	return errno;
 }
 
 static void unlock_pages(struct page *pages[], unsigned int nr_pages)
 {
 	unsigned int i;
 
-	if (!pages)
-		return;
-
 	for (i = 0; i < nr_pages; i++) {
-		if (pages[i])
-			put_page(pages[i]);
+		if (!PageDirty(page))
+			set_page_dirty_lock(page);
+		put_page(pages[i]);
 	}
 }
 
@@ -630,6 +631,7 @@ static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
 	struct xen_dm_op_buf *xbufs = NULL;
 	unsigned int i;
 	long rc;
+	int pinned = 0;
 
 	if (copy_from_user(&kdata, udata, sizeof(kdata)))
 		return -EFAULT;
@@ -683,9 +685,11 @@ static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
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

