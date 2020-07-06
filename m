Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153FAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFA2E20720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FREEGuCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgGFSIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbgGFSID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:08:03 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387EAC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 11:08:03 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p1so6368728pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 11:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mBXFHkH5TzG6LqeVLyEATGFp3OINlEiEkwTG6DKP5gc=;
        b=FREEGuCxU2Zl2/sBJH058EpPMS4GiGXU/dTLgSmQEKbeNdyxgdzwv6AAMNmM25OGkN
         wHBZkctV9M8/clpVivrB7YRq+baoOE5bJDhR17Lw9dkYo23TMg+x1b8gyTP83jcBRsUn
         3SNWA8P3JttgJfmavqXK/qcf7fBcuz/PfiCLo7HOo3VIdWpaL4z8nf/hygxZQJjiflk+
         qPQPmXDwdqqBEwSL55lx+ZvGU5tvKjsYuSs334PaBtvBgBObRn//cpQIispeu/2WLEAh
         iKi3Ceg4sZjdH2QCP/1xYDV+sGiKJrKHFlkCfJNO/GbDEUNaHfr68A7APrHx0fubgBoX
         ag7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mBXFHkH5TzG6LqeVLyEATGFp3OINlEiEkwTG6DKP5gc=;
        b=ra8vnG+hr5iEAW9bxgxr/Xbqz/YsMKHtJg8pwc0yBvtte304SghNYtmh5OPW7Zmtzm
         oVkNZKSWSUQBiA6BGDAGEa9U64EVxiX3zICt1iRgXPMB828UXSAcC8pDeCiRIP2nSZUY
         SMIHzB2zjpIBLcGu8btQD23tSynky2XeG4egTqbgB4sk589aDP7bLCocxO6TwhULWxPX
         4euNIPMtYf6BaPpo8kNl9+g/UKFbmm1vxYgrcClZ/umKrj730YawV9BnMJ1H3KCtALve
         m8B/Wb7g9khqcYaXYeUEz/d8ueV3KitG9SbhLmf4PqdyYt2IQm9a7EJX131Yk7Q92qhA
         42Og==
X-Gm-Message-State: AOAM532eS9MLWd6F8TpmdGYktBTed8/1Qinj+SMBwyJ1eYWtEY6lks8d
        EI6pFS24NxZLM4Xb4WzEQ7w=
X-Google-Smtp-Source: ABdhPJzfrg4kfMMYzI0FM6dp3y6GDVRu7C/vmGzXICthTgrs/634fOSnQFK49BpoDjYsRBctgws2Eg==
X-Received: by 2002:a17:90a:aa83:: with SMTP id l3mr399709pjq.73.1594058882791;
        Mon, 06 Jul 2020 11:08:02 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.43.125])
        by smtp.gmail.com with ESMTPSA id 199sm20425544pgc.79.2020.07.06.11.07.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2020 11:08:02 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Paul Durrant <xadimgnik@gmail.com>
Subject: [PATCH v2 1/3] xen/privcmd: Corrected error handling path
Date:   Mon,  6 Jul 2020 23:46:10 +0530
Message-Id: <1594059372-15563-2-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1594059372-15563-1-git-send-email-jrdr.linux@gmail.com>
References: <1594059372-15563-1-git-send-email-jrdr.linux@gmail.com>
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
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Paul Durrant <xadimgnik@gmail.com>
---
 drivers/xen/privcmd.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index a250d11..33677ea 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -580,13 +580,13 @@ static long privcmd_ioctl_mmap_batch(
 
 static int lock_pages(
 	struct privcmd_dm_op_buf kbufs[], unsigned int num,
-	struct page *pages[], unsigned int nr_pages)
+	struct page *pages[], unsigned int nr_pages, unsigned int *pinned)
 {
 	unsigned int i;
+	int page_count = 0;
 
 	for (i = 0; i < num; i++) {
 		unsigned int requested;
-		int pinned;
 
 		requested = DIV_ROUND_UP(
 			offset_in_page(kbufs[i].uptr) + kbufs[i].size,
@@ -594,14 +594,15 @@ static int lock_pages(
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
@@ -611,13 +612,8 @@ static void unlock_pages(struct page *pages[], unsigned int nr_pages)
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
@@ -630,6 +626,7 @@ static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
 	struct xen_dm_op_buf *xbufs = NULL;
 	unsigned int i;
 	long rc;
+	unsigned int pinned = 0;
 
 	if (copy_from_user(&kdata, udata, sizeof(kdata)))
 		return -EFAULT;
@@ -683,9 +680,11 @@ static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
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

