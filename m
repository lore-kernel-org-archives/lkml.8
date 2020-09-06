Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDC6C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 06:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 524852080A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 06:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBMF2qL2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgIFGwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 02:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgIFGwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 02:52:40 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBC4C061573
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 23:52:39 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 31so6456804pgy.13
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 23:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I8rUO5c4QrQRi9NNPvOCt3d+iZWUjwi1tunN9Rub0tk=;
        b=bBMF2qL2q68MmK+glJEpZUPZMT5jo4AkJIZPACEdTgHHQYds5lYa0HzW4ZqHxulhek
         kg1UBfq/mFaLo4mOn+pW+Vr2Ub09QHqW8e0PkGGW7AXh2TpyTa73nKEBjxSt3a74KlNC
         1C7BDNXH0LpF0QsHSLlfC3icvJnycMKJdKAerK94DBpDlsG0OV/dMQgJRn/DoCBQYdkp
         KrL3X4uQ8sCo0qSULOuCxy86q9BFzrAgFX3dvOLE74SF2yab+XAfBFLVnQ6SRnF8YZBm
         5tUaZAPBx/Mz/D38G/C1aYXVHplqBczDkQnixhFqxwN2Ff/FOOGJSbaD7CVvyjbKRph2
         x8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I8rUO5c4QrQRi9NNPvOCt3d+iZWUjwi1tunN9Rub0tk=;
        b=rU+t2rNcX6SomU1QS2Mv8DNuCqslsyeSX75ptvE2Bhr+uPPISEOukjEBeB5OLfttwo
         2kWuEHbRs8Hd2KhcaHciy57z+colA3SvPKKRymSvZC0oTMzR7uEDPmv8au1F8IF8gb+Z
         MUUCEPmk0ZE84spugk4wFx1r4Tqgvs+zWwu1LPhWiQMTCu6jooKh6+h9pzFZAhLaLD7E
         fntL0w7dFJbt8eOaduO8K3M1LEGGL+xj7Tw/jJl+LmlbI6ydrX7F1j4Qh7YFWMyAgGZq
         JdbVI8mMhR9m9wevpdD7Zb4Ef0QC8Hc5Lwee3nfRosEtoDbQ4nNBW1DokoZGeCKUrNKi
         q13A==
X-Gm-Message-State: AOAM532deJcDubaBwDeJrpTK7OTXDdefxd5pdIr/V67yxwteojaSXxE9
        Avq5M8JoJwnq56Yzk0ZIzy4=
X-Google-Smtp-Source: ABdhPJwEUgCBR4QoLI3A2rl1Ro4L22TGg8358epQwwM3mEnmQWCqsaTjXqpy9QwbeAFz1ke6Dlv9ug==
X-Received: by 2002:aa7:83cf:: with SMTP id j15mr15147634pfn.251.1599375157754;
        Sat, 05 Sep 2020 23:52:37 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.54.54])
        by smtp.gmail.com with ESMTPSA id n128sm9199947pga.5.2020.09.05.23.52.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Sep 2020 23:52:36 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, david.vrabel@citrix.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/2] xen/gntdev.c: Mark pages as dirty
Date:   Sun,  6 Sep 2020 12:21:53 +0530
Message-Id: <1599375114-32360-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be a bug in the original code when gntdev_get_page()
is called with writeable=true then the page needs to be marked dirty
before being put.

To address this, a bool writeable is added in gnt_dev_copy_batch, set
it in gntdev_grant_copy_seg() (and drop `writeable` argument to
gntdev_get_page()) and then, based on batch->writeable, use
set_page_dirty_lock().

Fixes: a4cdb556cae0 (xen/gntdev: add ioctl for grant copy)
Suggested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: David Vrabel <david.vrabel@citrix.com>
---
 drivers/xen/gntdev.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 64a9025a..5e1411b 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -720,17 +720,18 @@ struct gntdev_copy_batch {
 	s16 __user *status[GNTDEV_COPY_BATCH];
 	unsigned int nr_ops;
 	unsigned int nr_pages;
+	bool writeable;
 };
 
 static int gntdev_get_page(struct gntdev_copy_batch *batch, void __user *virt,
-			   bool writeable, unsigned long *gfn)
+				unsigned long *gfn)
 {
 	unsigned long addr = (unsigned long)virt;
 	struct page *page;
 	unsigned long xen_pfn;
 	int ret;
 
-	ret = get_user_pages_fast(addr, 1, writeable ? FOLL_WRITE : 0, &page);
+	ret = get_user_pages_fast(addr, 1, batch->writeable ? FOLL_WRITE : 0, &page);
 	if (ret < 0)
 		return ret;
 
@@ -746,9 +747,13 @@ static void gntdev_put_pages(struct gntdev_copy_batch *batch)
 {
 	unsigned int i;
 
-	for (i = 0; i < batch->nr_pages; i++)
+	for (i = 0; i < batch->nr_pages; i++) {
+		if (batch->writeable && !PageDirty(batch->pages[i]))
+			set_page_dirty_lock(batch->pages[i]);
 		put_page(batch->pages[i]);
+	}
 	batch->nr_pages = 0;
+	batch->writeable = false;
 }
 
 static int gntdev_copy(struct gntdev_copy_batch *batch)
@@ -837,8 +842,9 @@ static int gntdev_grant_copy_seg(struct gntdev_copy_batch *batch,
 			virt = seg->source.virt + copied;
 			off = (unsigned long)virt & ~XEN_PAGE_MASK;
 			len = min(len, (size_t)XEN_PAGE_SIZE - off);
+			batch->writeable = false;
 
-			ret = gntdev_get_page(batch, virt, false, &gfn);
+			ret = gntdev_get_page(batch, virt, &gfn);
 			if (ret < 0)
 				return ret;
 
@@ -856,8 +862,9 @@ static int gntdev_grant_copy_seg(struct gntdev_copy_batch *batch,
 			virt = seg->dest.virt + copied;
 			off = (unsigned long)virt & ~XEN_PAGE_MASK;
 			len = min(len, (size_t)XEN_PAGE_SIZE - off);
+			batch->writeable = true;
 
-			ret = gntdev_get_page(batch, virt, true, &gfn);
+			ret = gntdev_get_page(batch, virt, &gfn);
 			if (ret < 0)
 				return ret;
 
-- 
1.9.1

