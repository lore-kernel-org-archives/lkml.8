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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A15C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16F3120720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEACz1Ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgGFSIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729658AbgGFSIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:08:16 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6B0C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 11:08:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id s26so3652741pfm.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 11:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ljWc7ncVT9pbFQys6lUrJ2oby+afUmM7eFZjxIhMARg=;
        b=jEACz1RudmH76IjHbdFlmoPGUPJKFxQCq2v9MrfJJA8KB3hgvmPKoJ6dh7OSUm81N/
         tl3W9rYACLLYLqhNvYdQec8GTl2ejOttzQ58EI02HItGcnKiiC5/2aB5g66OCIZC/E1u
         /mQOQRtDqM/vypg2TSJ4IrsIMarYUK8d/G66KFBDESnUPDZbWua4S7CX2i+MFnWN6+gm
         TAl9dt7TTOtSu6v1DhRGv8HYoLhUJhndqmVklEGZWSNyfwLROdQQHvcrbP7ORlKCEii6
         54YlItX98evWB9sVh7JTXi0t4Ki9jcwLstQgwmyBLwwyw2nX7hSrmTmI1pu9DpWmC1n2
         Kljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ljWc7ncVT9pbFQys6lUrJ2oby+afUmM7eFZjxIhMARg=;
        b=SVmi6Dt9VxC7V9s2hgFrpoaYXLHsNobiJw8m0vQ0/leilWyya5rh4SEVJuSUu7WB5n
         YPSaSQ8D/X7kF0IUL2npmteIMwtSLdb3sejU8+faoDS7arTTVlbnK+IUbkHggHLJydmR
         VW49nRYFniRFi+NTQ4HkOkSTn2dW5HjNrEiDsu9H5LaVD5c64R3OVr0U5RN6eaFlFDfg
         yfuUnyTlskfe3fOXyXI5kZPv/TDP398V5U4A0ycnVgBlf10XKfowSZQOlMf+tI+NKSOm
         w8Ez2nGiQJEYqcGP3klePsHA0krd7PewKaLDYuI5aNED1tihZEwfJS2++H6LyV21hLn1
         BJtw==
X-Gm-Message-State: AOAM532FS98inmoWWdJF/85kxMN2VIfQ0GWVZdqiw9pN6TBDCQau5+QV
        IrKdRdlreYs36bA5I+sF2i0pxVJ54sM=
X-Google-Smtp-Source: ABdhPJxIo6PQngVuGXtLZOqfdIq2vAywCi8VVu0pPrqJTL0U3sjfe2jLu94RvE7iZvdk15XpRbmE0w==
X-Received: by 2002:a65:5682:: with SMTP id v2mr41106431pgs.231.1594058895951;
        Mon, 06 Jul 2020 11:08:15 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.43.125])
        by smtp.gmail.com with ESMTPSA id 199sm20425544pgc.79.2020.07.06.11.08.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2020 11:08:15 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Paul Durrant <xadimgnik@gmail.com>
Subject: [PATCH v2 3/3] xen/privcmd: Convert get_user_pages*() to  pin_user_pages*()
Date:   Mon,  6 Jul 2020 23:46:12 +0530
Message-Id: <1594059372-15563-4-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1594059372-15563-1-git-send-email-jrdr.linux@gmail.com>
References: <1594059372-15563-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 2019, we introduced pin_user_pages*() and now we are converting
get_user_pages*() to the new API as appropriate. [1] & [2] could
be referred for more information. This is case 5 as per document [1].

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
        https://lwn.net/Articles/807108/

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Paul Durrant <xadimgnik@gmail.com>
---
 drivers/xen/privcmd.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index f6c1543..5c5cd24 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -594,7 +594,7 @@ static int lock_pages(
 		if (requested > nr_pages)
 			return -ENOSPC;
 
-		page_count = get_user_pages_fast(
+		page_count = pin_user_pages_fast(
 			(unsigned long) kbufs[i].uptr,
 			requested, FOLL_WRITE, pages);
 		if (page_count < 0)
@@ -610,13 +610,7 @@ static int lock_pages(
 
 static void unlock_pages(struct page *pages[], unsigned int nr_pages)
 {
-	unsigned int i;
-
-	for (i = 0; i < nr_pages; i++) {
-		if (!PageDirty(pages[i]))
-			set_page_dirty_lock(pages[i]);
-		put_page(pages[i]);
-	}
+	unpin_user_pages_dirty_lock(pages, nr_pages, true);
 }
 
 static long privcmd_ioctl_dm_op(struct file *file, void __user *udata)
-- 
1.9.1

