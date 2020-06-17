Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE079C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8B5420663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edvNWiJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgFQCUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 22:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgFQCUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 22:20:41 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8B9C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 19:20:41 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e18so511804pgn.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 19:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jlkXg/8cOfRCJwhgUdmNAqWeiDO0B4upmFZZOpihX9I=;
        b=edvNWiJ+gkcqCHT7jn5Sx5Bppkph0xBg6PExMZ0ZPnaw4TGNXhwu0hbMLP+K0Vn10U
         i63dPF1ZNJIgbArGNAUG6fauIcC59cJZfJdlSm7hucbaUnmtcqadgb1wK1NfjQIphV6H
         Uww02kpaj2SNivtZBsvIs49JLRTsHscEfLaIEhpWmxM7le+7G+GtkCEnNsD4ZwTXhPtR
         cOMHGXVzwIl9ViqBfvSaVRI96k5nB25X1oiv2ycfbJFEsU2+ysmqu9H7c5RkxGCB9jMG
         RRoa90WwgsojE65qKCow6wrChWGBhvhUuV5sqFvEpabBTEkrotDExkhd7iRhNbfg//aN
         QniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jlkXg/8cOfRCJwhgUdmNAqWeiDO0B4upmFZZOpihX9I=;
        b=W1tgrdUHSrsfYhgK9OaoO/hc5iPzvngYG820ZKeKrbuOBvdnnooZfjjfZotOQmwepf
         03dPsB0CRELDIjZneNKLaOgPmsxeruJN2Uly0nixhKapM5aIoMGCS0Isdsu1lQVpDiFN
         BdP4V8VgOyALI82l/5pJWbmHclhpx2rJJbYgUNJ67++Y+YtNjf01SYG48n3UVBkEW28u
         FRF7xU+uiKKfG3LMBKxme0pB3AxG/RToOzBJPca3L6gdbyf/8rSL2/4MBDTt0M3afLKC
         y5t28bXDazdzGRT8kQqhQryd+v6k5nsugEgBmCwOK0Mv+MyEqREL4ixJkw70jrcxcXr1
         wX5w==
X-Gm-Message-State: AOAM530RcRuYsjMEb1nNv3fzu8X8CJiI2v+DxQsUvgcnObu4s8UExPv9
        JqpbvGEo1ojYoFbRAi1AhNY=
X-Google-Smtp-Source: ABdhPJwSZgwKD4NqK2+PwKN2v4HkajjDh0kBp7FxB9eNSPs43n8r1gDRLRWvcReIlLpH0HRzHVZANw==
X-Received: by 2002:aa7:93b4:: with SMTP id x20mr4968683pff.9.1592360441065;
        Tue, 16 Jun 2020 19:20:41 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.213.184])
        by smtp.gmail.com with ESMTPSA id h9sm1203208pfe.32.2020.06.16.19.20.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 19:20:40 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     gregkh@linuxfoundation.org, jane.pnx9@gmail.com, pakki001@umn.edu,
        ldufour@linux.ibm.com, harshjain32@gmail.com, simon@nikanor.nu,
        walken@google.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 4/4] staging: kpc2000: kpc_dma: Remove excess goto statement
Date:   Wed, 17 Jun 2020 07:57:23 +0530
Message-Id: <1592360843-3440-5-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1592360843-3440-1-git-send-email-jrdr.linux@gmail.com>
References: <1592360843-3440-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As 3 goto level referring to same common code, those can be
accomodated with a single goto level and renameing it to
unpin_user_pages.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 1f5ab81..b0fcde5 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -35,7 +35,7 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 			    unsigned long iov_base, size_t iov_len)
 {
 	unsigned int i = 0;
-	int rv = 0;
+	int rv = 0, nr_pages = 0;
 	struct kpc_dma_device *ldev;
 	struct aio_cb_data *acd;
 	DECLARE_COMPLETION_ONSTACK(done);
@@ -79,22 +79,23 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 	rv = pin_user_pages(iov_base, acd->page_count, FOLL_TOUCH | FOLL_WRITE, acd->user_pages, NULL);
 	mmap_read_unlock(current->mm);        /*  release the semaphore */
 	if (rv != acd->page_count) {
+		nr_pages = rv;
 		dev_err(&priv->ldev->pldev->dev, "Couldn't pin_user_pages (%ld)\n", rv);
-		goto err_get_user_pages;
+		goto unpin_user_pages;
 	}
-
+	nr_pages = acd->page_count;
 	// Allocate and setup the sg_table (scatterlist entries)
 	rv = sg_alloc_table_from_pages(&acd->sgt, acd->user_pages, acd->page_count, iov_base & (PAGE_SIZE - 1), iov_len, GFP_KERNEL);
 	if (rv) {
 		dev_err(&priv->ldev->pldev->dev, "Couldn't alloc sg_table (%ld)\n", rv);
-		goto err_alloc_sg_table;
+		goto unpin_user_pages;
 	}
 
 	// Setup the DMA mapping for all the sg entries
 	acd->mapped_entry_count = dma_map_sg(&ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, ldev->dir);
 	if (acd->mapped_entry_count <= 0) {
 		dev_err(&priv->ldev->pldev->dev, "Couldn't dma_map_sg (%d)\n", acd->mapped_entry_count);
-		goto err_dma_map_sg;
+		goto unpin_user_pages;
 	}
 
 	// Calculate how many descriptors are actually needed for this transfer.
@@ -187,13 +188,9 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 	unlock_engine(ldev);
 	dma_unmap_sg(&ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, ldev->dir);
 	sg_free_table(&acd->sgt);
- err_dma_map_sg:
- err_alloc_sg_table:
-	unpin_user_pages(acd->user_pages, acd->page_count);
-
- err_get_user_pages:
-	if (rv > 0)
-		unpin_user_pages(acd->user_pages, rv);
+ unpin_user_pages:
+	if (nr_pages > 0)
+		unpin_user_pages(acd->user_pages, nr_pages);
 	kfree(acd->user_pages);
  err_alloc_userpages:
 	kfree(acd);
-- 
1.9.1

