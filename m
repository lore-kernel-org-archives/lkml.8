Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8546AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E83F2074D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsy1oTEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgGAGKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgGAGKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:10:00 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05FEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:10:00 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j19so4305159pgm.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 23:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iJXQLBehWwPwwPoGiInoAvr+iwWO0xFUwp5XsZYJ0Wc=;
        b=qsy1oTEzSRTnDgDlzAbsXmEbfOTK6Kgt+sy4W4NbwNJeT/VgP5zyHxXEAl7okwkCY2
         4v9rfF40pxuxPrjHK1mS9QoJn1ALGVIAvsKF2QJmYXpMhmW3rJZ+4phopvzekJq4owgS
         xeBvwHnrtDk1EXUjR3/UrYnmOphRxpk9ApPK2VQbF8uBMhoWNv4oMTeHbNvhMvGbp2sI
         yKxXK3uXJeFpLmlS1zkUL9Con0gW7VAkjwFQqoPzftnGu6ZEmgeju4Lsw5HGK0y4FpPp
         NxxoYy0pjuSTDhiDzRmmmiEmOA/FO1R5T1fzd/RhDp8R/9HOJwGPmAGdI/nHr25jiquX
         gNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iJXQLBehWwPwwPoGiInoAvr+iwWO0xFUwp5XsZYJ0Wc=;
        b=DaI78eUKxGIJZgrbtSncksYGRxYj3PojAKBm8GFOr1r94yma7tLxA1G3Ia5gTzKFS5
         1u0B0/M/VypJ7ef5nAALtiP8v7LS0hgY2/sx4bOOwrG1UcshSWNJMaLjGKYVioaEigbS
         LVY7uc498u6rc7q04kpJeM51r4te/ENPNsy+s4ZJUKx8bhenwsZ+ySlQIl9j3DV8Mwva
         ufTL367ph1G2wnpYPnhxIbX7boTCK2mfbzrMbZzNq9dJ7H/fEvepNosp7kn19fOuVhar
         0bkg7IVfPJPTqKktjmq7cBHqSDAXKws1KnMEi5IH1U0sTommYODsudMrzVf2v8Jj8Stp
         AKmA==
X-Gm-Message-State: AOAM531NDs5qiDdUUzoKBWPQ7+B1Iw2fsv0cMVh/6+5RlMsaMBLko6sT
        Zf7I44YHvYFJjvC+lOXuVcc=
X-Google-Smtp-Source: ABdhPJyAWnEZKEKAJ11azWAi7WrF/Rs8eY9d2O15O3QWBbIEB9lh8c4pvA0qM811KBZO3njehbGxGA==
X-Received: by 2002:a63:5013:: with SMTP id e19mr18445859pgb.68.1593583800326;
        Tue, 30 Jun 2020 23:10:00 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.42.200])
        by smtp.gmail.com with ESMTPSA id 127sm4694073pgf.5.2020.06.30.23.09.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2020 23:09:59 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     gregkh@linuxfoundation.org, jane.pnx9@gmail.com,
        daniel.m.jordan@oracle.com, simon@nikanor.nu,
        harshjain32@gmail.com, pakki001@umn.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3 4/4] staging: kpc2000: kpc_dma: Remove additional goto statements
Date:   Wed,  1 Jul 2020 11:47:44 +0530
Message-Id: <1593584264-16982-5-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1593584264-16982-1-git-send-email-jrdr.linux@gmail.com>
References: <1593584264-16982-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As 3 goto level referring to same common code, those can be
accomodated with a single goto level and renameing it to
unpin_pages. Set the -ERRNO when returning partial mapped
pages in more appropriate place.

When dma_map_sg() failed, the previously allocated memory was
not freed properly. This is corrected now.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Bharath Vedartham <linux.bhar@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 8cd20ad..dd716edd 100644
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
+		goto free_table;
 	}
 
 	// Calculate how many descriptors are actually needed for this transfer.
@@ -186,16 +191,12 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
  err_descr_too_many:
 	unlock_engine(ldev);
 	dma_unmap_sg(&ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, ldev->dir);
+ free_table:
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

