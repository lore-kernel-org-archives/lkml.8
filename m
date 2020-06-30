Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF57C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 804FE20809
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHwvxnfk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbgF3Hoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731077AbgF3Hof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:44:35 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDFBC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:44:35 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k1so8156866pls.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sVK5V/4PBzeYWjMj+/BOipu6Mqur09tAOGAuoqIzEPw=;
        b=bHwvxnfk/4rv5l902jpKhPfmpGks9NYfD6z8bU6lXaQ++Ss8cARLGhUr1mCI299/Ri
         MtjVixl0k6CTlphPiWnx+fWwIkhbH0TQfZsUO1eRNpjf1/trfVLP1WW49zCv8Kb9qPvz
         F5269NB9yyeOS1agBK2DXaTVHESxtI5v4Ftp5vlhuIJbmUQysIA5qSYdawgrZkFqnWFo
         1vTIocvjWkkyX5r/m9lJrfXiIyuZwWKOdvWDkVAnWtHgOTirKfmd2gxLZwFl0Wghu3NV
         /U1JYNWVbDDsxT9UOgCd30DPK1nH7WhKzfs603mT1OrF/Pald320eI/bbe2EE/zMfrR5
         IKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sVK5V/4PBzeYWjMj+/BOipu6Mqur09tAOGAuoqIzEPw=;
        b=cW38ksxMfZRk6IM/GJ9EpAuTtMTOZUpQLANTNtrbcKYRbY0id3auP8/TKDCpwUvbeU
         QqHhNgd8az5ZgQn3mgXsn1//KmabrELpScsE/hn4s6HOZmnIeM7el1+TbAKGM+d3XGXo
         jiRur8d3o3jUYE3LGVw1BAa+33U8+O04mYN9Y5CwYSrouuJnFo1jJefLO5u9ZOgYkVaF
         Vm9k4lPR3rgJ2D30d5pdxdUyVrjASMeHB8CxxXF4G3l1Ho9Tv+VX/9eLBFyQTRkf5G2t
         ilUNGt91rADJBOSuFSLpmjrEjg2e/e+naAw2zuf1blnCYpTiCxiv5wVt/nqy9P+GddVC
         up/g==
X-Gm-Message-State: AOAM531pJnPjzEjrV2yTX2UuykPfm4BAi11Q5kqmF4VO3gJ6Q2XUbv2w
        YE0fcY8GpZi+oL9MMM9hL8Y=
X-Google-Smtp-Source: ABdhPJzq1rYQk6wf24CmsFZCONIfWMH8K7yvJ9eYrKxRrMFc52O14Ueg3KnsHOsz4Um9iK1YNuhxIw==
X-Received: by 2002:a17:902:6945:: with SMTP id k5mr16235242plt.336.1593503075145;
        Tue, 30 Jun 2020 00:44:35 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.182.225.143])
        by smtp.gmail.com with ESMTPSA id w1sm1754276pfq.53.2020.06.30.00.44.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2020 00:44:34 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     jane.pnx9@gmail.com, ldufour@linux.ibm.com,
        gregkh@linuxfoundation.org, harshjain32@gmail.com, pakki001@umn.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2 4/4] staging: kpc2000: kpc_dma: Remove additional goto statements
Date:   Tue, 30 Jun 2020 13:22:19 +0530
Message-Id: <1593503539-18649-5-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1593503539-18649-1-git-send-email-jrdr.linux@gmail.com>
References: <1593503539-18649-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As 3 goto level referring to same common code, those can be
accomodated with a single goto level and renameing it to
unpin_pages. Set the -ERRNO when returning partial mapped
pages in more appropriate place.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Bharath Vedartham <linux.bhar@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 8cd20ad..d21a4fd 100644
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
@@ -79,22 +79,27 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 	rv = pin_user_pages(iov_base, acd->page_count, FOLL_TOUCH | FOLL_WRITE, acd->user_pages, NULL);
 	mmap_read_unlock(current->mm);        /*  release the semaphore */
 	if (rv != acd->page_count) {
+		nr_pages = rv;
+		if (rv > 0)
+			rv = -EFAULT;
+
 		dev_err(&priv->ldev->pldev->dev, "Couldn't pin_user_pages (%d)\n", rv);
-		goto err_get_user_pages;
+		goto unpin_pages;
 	}
+	nr_pages = acd->page_count;
 
 	// Allocate and setup the sg_table (scatterlist entries)
 	rv = sg_alloc_table_from_pages(&acd->sgt, acd->user_pages, acd->page_count, iov_base & (PAGE_SIZE - 1), iov_len, GFP_KERNEL);
 	if (rv) {
 		dev_err(&priv->ldev->pldev->dev, "Couldn't alloc sg_table (%d)\n", rv);
-		goto err_alloc_sg_table;
+		goto unpin_pages;
 	}
 
 	// Setup the DMA mapping for all the sg entries
 	acd->mapped_entry_count = dma_map_sg(&ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, ldev->dir);
 	if (acd->mapped_entry_count <= 0) {
 		dev_err(&priv->ldev->pldev->dev, "Couldn't dma_map_sg (%d)\n", acd->mapped_entry_count);
-		goto err_dma_map_sg;
+		goto unpin_pages;
 	}
 
 	// Calculate how many descriptors are actually needed for this transfer.
@@ -187,15 +192,10 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 	unlock_engine(ldev);
 	dma_unmap_sg(&ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, ldev->dir);
 	sg_free_table(&acd->sgt);
- err_dma_map_sg:
- err_alloc_sg_table:
-	unpin_user_pages(acd->user_pages, acd->page_count);
 
- err_get_user_pages:
-	if (rv > 0) {
-		unpin_user_pages(acd->user_pages, rv);
-		rv = -EFAULT;
-	}
+ unpin_pages:
+	if (nr_pages > 0)
+		unpin_user_pages(acd->user_pages, nr_pages);
 	kfree(acd->user_pages);
  err_alloc_userpages:
 	kfree(acd);
-- 
1.9.1

