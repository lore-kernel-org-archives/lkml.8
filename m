Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427FEC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 17:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CBF204EA
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 17:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="or7Yj6wb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgEaRnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 13:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgEaRnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 13:43:23 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FAAC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 10:43:23 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 5so3910566pjd.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=++n8hYI7Hh/vLPZoLCJ3ybLJ1cQuKKnfR3srqDdsFqA=;
        b=or7Yj6wbWRbcUof3aPMTrXzC6Vty0IKsuZmHclnbXMuzVoBys6Mf1FIMscIynDJG4I
         jaUtSxKzb7THMZ9depepNWDU9biPH8AbtWckODKKo016njYRuf+6Wiyt0DcofFSZ2D3d
         Jz43SrssK8bQEA4tfA7lNsZzVIFhMD6JKWzt27HDjtu3HGFFmwBEJ4aOEmzPMzRgotES
         FroUj8Pb4c9SOJHpa4iVAAMGPCjVXErhF0DbjXOZLo2rm5XJGRZ8yWQ004O23DcjLMa0
         pGNjAiQoBykDUKUlpSQxVs7aoRyil/npFOg0ptyn5hbfbOsfeGZymGSFRL00a1/lH82+
         prVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=++n8hYI7Hh/vLPZoLCJ3ybLJ1cQuKKnfR3srqDdsFqA=;
        b=qpJppZAMKmt1KnWstS5dvlHESQDbyFKz8Do0AvrjYTebyMN4If/YTjVAmOSM6zp2gP
         HhtWhQVZDQAMXF3XGDQT7FeMiW7Jy9P9Xx7s6qqJa4A74Duzh7+XP2tCJeUrUwstBvgI
         5zd/jpTRvLqIWhVibvhTzVkKeiw75GGJGi4eXcubxNN/tDUHQ9gE/ouEDLZZIBWqqfAt
         5W9WXaxYQ2i6DLu+K9yW72mHcKudF+zESgCRtNiDm/qRldvrgOSjzdBr4pE4MhfctbPM
         JuqxfxHH9CYyHgP5ecZMQnGRWF50v5uyi8h/xMo6CCp88Y6zXTAmhJhKnsU2Bmzf+9GG
         FiLw==
X-Gm-Message-State: AOAM530Lig+3BUP95Nvrm0XHGoWW1P+v+PGWcSHFMqHLUEFXrQnO1IWO
        uSgF3JpzGVd6KYChsRt49HQ=
X-Google-Smtp-Source: ABdhPJzHSnEPb3AH9bRq0HQlO7tVo/4iay4/TCFEo5BBOG4UwnaAMCFunroy+R9JYQsAk3PbMUCO2A==
X-Received: by 2002:a17:90a:32ee:: with SMTP id l101mr13742252pjb.213.1590947002134;
        Sun, 31 May 2020 10:43:22 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.167.39.216])
        by smtp.gmail.com with ESMTPSA id go1sm4922841pjb.26.2020.05.31.10.43.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2020 10:43:21 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     gregkh@linuxfoundation.org, jane.pnx9@gmail.com, simon@nikanor.nu,
        harshjain32@gmail.com, linux.bhar@gmail.com, festevam@gmail.com,
        jeremy@azazel.net
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] staging: kpc2000: kpc_dma: Convert get_user_pages() --> pin_user_pages()
Date:   Sun, 31 May 2020 23:21:31 +0530
Message-Id: <1590947491-11194-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 2019, we introduced pin_user_pages*() and now we are converting
get_user_pages*() to the new API as appropriate. [1] & [2] could
be referred for more information.

When pin_user_pages() returns numbers of partially mapped pages,
those pages were not unpinned as part of error handling. Fixed
it as part of this patch.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
        https://lwn.net/Articles/807108/

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
Hi,

I'm compile tested this, but unable to run-time test, so any testing
help is much appriciated.

 drivers/staging/kpc2000/kpc_dma/fileops.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 8975346..29bab13 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -48,6 +48,7 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 	u64 card_addr;
 	u64 dma_addr;
 	u64 user_ctl;
+	int nr_pages = 0;
 
 	ldev = priv->ldev;
 
@@ -76,13 +77,15 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 
 	// Lock the user buffer pages in memory, and hold on to the page pointers (for the sglist)
 	mmap_read_lock(current->mm);      /*  get memory map semaphore */
-	rv = get_user_pages(iov_base, acd->page_count, FOLL_TOUCH | FOLL_WRITE | FOLL_GET, acd->user_pages, NULL);
+	rv = pin_user_pages(iov_base, acd->page_count, FOLL_TOUCH | FOLL_WRITE, acd->user_pages, NULL);
 	mmap_read_unlock(current->mm);        /*  release the semaphore */
 	if (rv != acd->page_count) {
-		dev_err(&priv->ldev->pldev->dev, "Couldn't get_user_pages (%ld)\n", rv);
+		dev_err(&priv->ldev->pldev->dev, "Couldn't pin_user_pages (%ld)\n", rv);
+		nr_pages = rv;
 		goto err_get_user_pages;
 	}
 
+	nr_pages = acd->page_count;
 	// Allocate and setup the sg_table (scatterlist entries)
 	rv = sg_alloc_table_from_pages(&acd->sgt, acd->user_pages, acd->page_count, iov_base & (PAGE_SIZE - 1), iov_len, GFP_KERNEL);
 	if (rv) {
@@ -189,10 +192,9 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 	sg_free_table(&acd->sgt);
  err_dma_map_sg:
  err_alloc_sg_table:
-	for (i = 0 ; i < acd->page_count ; i++)
-		put_page(acd->user_pages[i]);
-
  err_get_user_pages:
+	if (nr_pages > 0)
+		unpin_user_pages(acd->user_pages, nr_pages);
 	kfree(acd->user_pages);
  err_alloc_userpages:
 	kfree(acd);
@@ -217,8 +219,7 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
 
 	dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
 
-	for (i = 0 ; i < acd->page_count ; i++)
-		put_page(acd->user_pages[i]);
+	unpin_user_pages(acd->user_pages, acd->page_count);
 
 	sg_free_table(&acd->sgt);
 
-- 
1.9.1

